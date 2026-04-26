import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint para análisis de gráficas, ventas netas, amortización y ganancias
class AnalyticsEndpoint extends Endpoint {
  /// Resumen financiero por rango de meses de un año.
  ///
  /// Incluye:
  /// - Gastos totales
  /// - Total ganado (ingresos)
  /// - Gasto de filamento recuperado
  /// - Ganancia general
  /// - Ganancia por impresora
  Future<String> getFinancialSummaryByMonthRange(
    Session session, {
    required int year,
    required int startMonth,
    required int endMonth,
  }) async {
    if (startMonth < 1 || startMonth > 12 || endMonth < 1 || endMonth > 12) {
      throw Exception('Mes inválido. Debe estar entre 1 y 12.');
    }

    var fromMonth = startMonth;
    var toMonth = endMonth;
    if (fromMonth > toMonth) {
      final temp = fromMonth;
      fromMonth = toMonth;
      toMonth = temp;
    }

    final startDate = DateTime(year, fromMonth, 1);
    final endDateExclusive =
        toMonth == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, toMonth + 1, 1);

    final sales = await Sale.db.find(
      session,
      orderBy: (t) => t.created,
    );

    double totalRevenue = 0.0;
    double totalFilamentCost = 0.0;
    double totalElectricityCost = 0.0;
    double totalSuppliesCost = 0.0;
    double totalDepreciationCost = 0.0;
    double totalPostProcessingCost = 0.0;
    double totalShippingCost = 0.0;

    final printerRevenue = <int, double>{};
    final printerCosts = <int, double>{};
    final printerNames = <int, String>{};

    for (final sale in sales) {
      if (!_isDateInRange(sale.created, startDate, endDateExclusive)) continue;
      totalRevenue += sale.totalAmount;

      final quote = await Quote.db.findById(session, sale.quoteId);
      if (quote == null) continue;

      final filament = quote.filamentCost;
      final electricity = quote.electricityCost;
      final supplies = quote.suppliesCost;
      final depreciation = quote.depreciationCost;
      final postProcessing = quote.postProcessingCost ?? 0.0;
      final shipping = quote.shippingCost ?? 0.0;

      totalFilamentCost += filament;
      totalElectricityCost += electricity;
      totalSuppliesCost += supplies;
      totalDepreciationCost += depreciation;
      totalPostProcessingCost += postProcessing;
      totalShippingCost += shipping;

      if (quote.printerId != null) {
        final printerId = quote.printerId!;

        final printer = await Printer.db.findById(session, printerId);
        printerNames[printerId] = printer?.name ?? 'Impresora #$printerId';

        final quoteCost =
            filament + electricity + supplies + depreciation + postProcessing + shipping;

        printerRevenue[printerId] = (printerRevenue[printerId] ?? 0.0) + sale.totalAmount;
        printerCosts[printerId] = (printerCosts[printerId] ?? 0.0) + quoteCost;
      }
    }

    final totalExpenses = totalFilamentCost +
        totalElectricityCost +
        totalSuppliesCost +
        totalDepreciationCost +
        totalPostProcessingCost +
        totalShippingCost;

    final generalProfit = totalRevenue - totalExpenses;

    final profitByPrinter = <Map<String, dynamic>>[];
    for (final entry in printerRevenue.entries) {
      final printerId = entry.key;
      final revenue = entry.value;
      final costs = printerCosts[printerId] ?? 0.0;
      final profit = revenue - costs;

      profitByPrinter.add({
        'printerId': printerId,
        'printerName': printerNames[printerId] ?? 'Impresora #$printerId',
        'totalRevenue': revenue,
        'totalExpenses': costs,
        'totalProfit': profit,
      });
    }

    profitByPrinter.sort(
      (a, b) => (b['totalProfit'] as num).compareTo(a['totalProfit'] as num),
    );

    return jsonEncode({
      'filters': {
        'year': year,
        'startMonth': fromMonth,
        'endMonth': toMonth,
      },
      'totals': {
        'salesCount': sales.length,
        'totalGastos': totalExpenses,
        'totalGanado': totalRevenue,
        'totalGastoMaterialRecuperado': totalFilamentCost,
        'totalGananciasGenerales': generalProfit,
        'totalGananciasPorImpresora': profitByPrinter,
      },
      'expenseBreakdown': {
        'filament': totalFilamentCost,
        'electricity': totalElectricityCost,
        'supplies': totalSuppliesCost,
        'depreciation': totalDepreciationCost,
        'postProcessing': totalPostProcessingCost,
        'shipping': totalShippingCost,
      },
    });
  }

  /// Obtiene datos de ventas mensuales para la gráfica
  Future<String> getMonthlySalesData(
    Session session, {
    int monthsBack = 12,
  }) async {
    monthsBack = await _resolveMonthsBack(session, monthsBack);
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - monthsBack, now.day);

    // Obtener todas las ventas completadas en el rango
    final sales = await Sale.db.find(session);

    // Agrupar por mes-año
    final monthlyData = <String, double>{};
    for (var i = 0; i < monthsBack; i++) {
      final date = DateTime(now.year, now.month - (monthsBack - i - 1), 1);
      final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';
      monthlyData[monthKey] = 0.0;
    }

    // Sumar ventas por mes
    for (var sale in sales) {
      if (sale.created.isBefore(startDate)) continue;
      final monthKey = '${sale.created.year}-${sale.created.month.toString().padLeft(2, '0')}';
      if (monthlyData.containsKey(monthKey)) {
        monthlyData[monthKey] = monthlyData[monthKey]! + sale.totalAmount;
      }
    }

    return jsonEncode({
      'months': monthlyData.keys.toList(),
      'totalSales': monthlyData.values.toList(),
      'totalRevenue': monthlyData.values.fold<double>(0.0, (sum, value) => sum + value),
    });
  }

  /// Obtiene datos de ganancias netas (ingresos - costos)
  Future<String> getNetProfitData(
    Session session, {
    int monthsBack = 12,
  }) async {
    monthsBack = await _resolveMonthsBack(session, monthsBack);
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - monthsBack, now.day);

    // Obtener todas las ventas en el rango
    final sales = await Sale.db.find(session);

    // Agrupar por mes-año y calcular ganancias
    final monthlyData = <String, double>{};
    for (var i = 0; i < monthsBack; i++) {
      final date = DateTime(now.year, now.month - (monthsBack - i - 1), 1);
      final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';
      monthlyData[monthKey] = 0.0;
    }

    // Calcular ganancias por venta
    for (var sale in sales) {
      if (sale.created.isBefore(startDate)) continue;
      final quote = await Quote.db.findById(session, sale.quoteId);
      if (quote != null) {
        final monthKey = '${sale.created.year}-${sale.created.month.toString().padLeft(2, '0')}';
        if (monthlyData.containsKey(monthKey)) {
          // Ganancia = ingreso - costos totales
          final totalCost = quote.filamentCost +
              quote.electricityCost +
              quote.suppliesCost +
              quote.depreciationCost +
              (quote.postProcessingCost ?? 0.0);
          final profit = (sale.totalAmount - totalCost);
          monthlyData[monthKey] = monthlyData[monthKey]! + profit;
        }
      }
    }

    return jsonEncode({
      'months': monthlyData.keys.toList(),
      'netProfit': monthlyData.values.toList(),
      'totalProfit': monthlyData.values.fold<double>(0.0, (sum, value) => sum + value),
    });
  }

  /// Obtiene datos de amortización de impresoras
  Future<String> getPrinterDepreciationData(
    Session session, {
    int depreciationYears = 5,
  }) async {
    final printers = await Printer.db.find(session);
    final sales = await Sale.db.find(session);

    final depreciationData = <Map<String, dynamic>>[];
    double totalPrinterInvestment = 0.0;
    double totalAmortized = 0.0;

    for (var printer in printers) {
      // Calcular depreciación: costo / años de vida útil
      final monthlyDepreciation = printer.purchaseCost / (depreciationYears * 12);

      // Amortización real: suma de depreciationCost de cotizaciones vendidas
      double amortizedAmount = 0.0;
      double totalPrintHours = 0.0;
      int linkedSales = 0;

      for (final sale in sales) {
        final quote = await Quote.db.findById(session, sale.quoteId);
        if (quote == null) continue;
        if (quote.printerId != printer.id) continue;

        amortizedAmount += quote.depreciationCost;
        totalPrintHours += quote.printHours * quote.quantity;
        linkedSales++;
      }

      final amortizedPercentage =
          printer.purchaseCost > 0 ? ((amortizedAmount / printer.purchaseCost) * 100).clamp(0.0, 100.0) : 0.0;
      final pendingAmortization = (printer.purchaseCost - amortizedAmount).clamp(0.0, double.infinity);

      totalPrinterInvestment += printer.purchaseCost;
      totalAmortized += amortizedAmount;

      depreciationData.add({
        'printerName': printer.name,
        'printerId': printer.id,
        'purchaseCost': printer.purchaseCost,
        'monthlyDepreciation': monthlyDepreciation,
        'amortizedAmount': amortizedAmount,
        'amortizedPercentage': amortizedPercentage,
        'pendingAmortization': pendingAmortization,
        'totalPrintHours': totalPrintHours,
        'linkedSales': linkedSales,
      });
    }

    return jsonEncode({
      'printers': depreciationData,
      'totalDepreciation': totalPrinterInvestment,
      'totalAmortized': totalAmortized,
      'totalPendingAmortization':
          (totalPrinterInvestment - totalAmortized).clamp(0.0, double.infinity),
      'averageDepreciation': depreciationData.isEmpty 
          ? 0.0 
          : totalAmortized / depreciationData.length,
    });
  }

  /// Obtiene datos de análisis comparativo: ventas vs costos
  Future<String> getSalesVsCostsAnalysis(
    Session session, {
    int monthsBack = 12,
  }) async {
    monthsBack = await _resolveMonthsBack(session, monthsBack);
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - monthsBack, now.day);

    // Obtener todas las ventas en el rango
    final sales = await Sale.db.find(session);

    // Agrupar datos por mes
    final monthlyData = <String, Map<String, double>>{};
    for (var i = 0; i < monthsBack; i++) {
      final date = DateTime(now.year, now.month - (monthsBack - i - 1), 1);
      final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';
      monthlyData[monthKey] = {
        'sales': 0.0,
        'filamentCost': 0.0,
        'electricityCost': 0.0,
        'suppliesCost': 0.0,
        'depreciationCost': 0.0,
        'profit': 0.0,
      };
    }

    // Procesar cada venta
    for (var sale in sales) {
      if (sale.created.isBefore(startDate)) continue;
      final quote = await Quote.db.findById(session, sale.quoteId);
      if (quote != null) {
        final monthKey = '${sale.created.year}-${sale.created.month.toString().padLeft(2, '0')}';
        if (monthlyData.containsKey(monthKey)) {
          monthlyData[monthKey]!['sales'] = monthlyData[monthKey]!['sales']! + sale.totalAmount;
          monthlyData[monthKey]!['filamentCost'] =
              monthlyData[monthKey]!['filamentCost']! + quote.filamentCost;
          monthlyData[monthKey]!['electricityCost'] =
              monthlyData[monthKey]!['electricityCost']! + quote.electricityCost;
          monthlyData[monthKey]!['suppliesCost'] =
              monthlyData[monthKey]!['suppliesCost']! + quote.suppliesCost;
          monthlyData[monthKey]!['depreciationCost'] =
              monthlyData[monthKey]!['depreciationCost']! + quote.depreciationCost;
        }
      }
    }

    // Calcular ganancias
    for (var monthKey in monthlyData.keys) {
      final data = monthlyData[monthKey]!;
      final totalCosts = data['filamentCost']! +
          data['electricityCost']! +
          data['suppliesCost']! +
          data['depreciationCost']!;
      data['profit'] = data['sales']! - totalCosts;
    }

    // Calcular totales
    double totalSales = 0;
    double totalFilamentCost = 0;
    double totalElectricityCost = 0;
    double totalSuppliesCost = 0;
    double totalDepreciationCost = 0;

    for (var data in monthlyData.values) {
      totalSales += data['sales']!;
      totalFilamentCost += data['filamentCost']!;
      totalElectricityCost += data['electricityCost']!;
      totalSuppliesCost += data['suppliesCost']!;
      totalDepreciationCost += data['depreciationCost']!;
    }

    return jsonEncode({
      'months': monthlyData.keys.toList(),
      'data': monthlyData,
      'totals': {
        'sales': totalSales,
        'filamentCost': totalFilamentCost,
        'electricityCost': totalElectricityCost,
        'suppliesCost': totalSuppliesCost,
        'depreciationCost': totalDepreciationCost,
        'totalCosts':
            totalFilamentCost + totalElectricityCost + totalSuppliesCost + totalDepreciationCost,
        'profit': totalSales -
            (totalFilamentCost +
                totalElectricityCost +
                totalSuppliesCost +
                totalDepreciationCost),
      },
    });
  }

  /// Obtiene datos de rentabilidad de categorías de cotización
  Future<String> getCategoryProfitabilityData(Session session) async {
    final categories = await QuoteCategory.db.find(session);
    final categoryData = <Map<String, dynamic>>[];

    for (var category in categories) {
      // Obtener quotes de esta categoría
      final quotes = await Quote.db.find(
        session,
        where: (t) => t.categoryId.equals(category.id),
      );

      double totalRevenue = 0;
      double totalCosts = 0;
      int quoteCount = 0;

      for (var quote in quotes) {
        totalRevenue += quote.total;
        totalCosts += quote.filamentCost +
            quote.electricityCost +
            quote.suppliesCost +
            quote.depreciationCost +
            (quote.postProcessingCost ?? 0.0);
        quoteCount++;
      }

      final profit = totalRevenue - totalCosts;
      final profitMargin = totalRevenue > 0 ? ((profit / totalRevenue) * 100) : 0.0;

      categoryData.add({
        'categoryName': category.name,
        'categoryId': category.id,
        'quoteCount': quoteCount,
        'totalRevenue': totalRevenue,
        'totalCosts': totalCosts,
        'profit': profit,
        'profitMargin': profitMargin.toStringAsFixed(2),
      });
    }

    // Ordenar por rentabilidad descendente
    categoryData.sort((a, b) => (b['profit'] as num).compareTo(a['profit'] as num));

    return jsonEncode({
      'categories': categoryData,
      'totalCategories': categories.length,
    });
  }

  /// Obtiene un resumen general de métricas clave
  Future<String> getOverallMetrics(Session session) async {
    final now = DateTime.now();
    final thisMonthStart = DateTime(now.year, now.month, 1);
    final lastMonthStart = DateTime(now.year, now.month - 1, 1);
    // Ventas este mes
    final allSales = await Sale.db.find(session);
    final thisMonthSales = allSales
        .where((s) => !s.created.isBefore(thisMonthStart))
        .toList();

    // Ventas mes pasado
    final lastMonthEndExclusive = DateTime(now.year, now.month, 1);
    final lastMonthSales = allSales
      .where(
        (s) =>
          !s.created.isBefore(lastMonthStart) &&
          s.created.isBefore(lastMonthEndExclusive),
      )
      .toList();

    // Calcular ingresos
    double thisMonthRevenue = 0;
    double lastMonthRevenue = 0;
    double thisMonthCosts = 0;
    double lastMonthCosts = 0;

    for (var sale in thisMonthSales) {
      thisMonthRevenue += sale.totalAmount;
      final quote = await Quote.db.findById(session, sale.quoteId);
      if (quote != null) {
        thisMonthCosts += quote.filamentCost +
            quote.electricityCost +
            quote.suppliesCost +
            quote.depreciationCost;
      }
    }

    for (var sale in lastMonthSales) {
      lastMonthRevenue += sale.totalAmount;
      final quote = await Quote.db.findById(session, sale.quoteId);
      if (quote != null) {
        lastMonthCosts += quote.filamentCost +
            quote.electricityCost +
            quote.suppliesCost +
            quote.depreciationCost;
      }
    }

    final thisMonthProfit = thisMonthRevenue - thisMonthCosts;
    final lastMonthProfit = lastMonthRevenue - lastMonthCosts;

    // Calcular cambio porcentual
    final revenueChange = lastMonthRevenue > 0
        ? (((thisMonthRevenue - lastMonthRevenue) / lastMonthRevenue) * 100)
        : 0.0;
    final profitChange = lastMonthProfit > 0
        ? (((thisMonthProfit - lastMonthProfit) / lastMonthProfit) * 100)
        : 0.0;

    // Obtener total de clientes y cotizaciones
    final totalCustomers = await Customer.db.find(session);
    final totalQuotes = await Quote.db.find(session);

    return jsonEncode({
      'thisMonth': {
        'revenue': thisMonthRevenue,
        'costs': thisMonthCosts,
        'profit': thisMonthProfit,
        'sales': thisMonthSales.length,
      },
      'lastMonth': {
        'revenue': lastMonthRevenue,
        'costs': lastMonthCosts,
        'profit': lastMonthProfit,
        'sales': lastMonthSales.length,
      },
      'changes': {
        'revenueChange': revenueChange,
        'profitChange': profitChange,
      },
      'totals': {
        'customers': totalCustomers.length,
        'quotes': totalQuotes.length,
      },
    });
  }

  Future<int> _resolveMonthsBack(Session session, int monthsBack) async {
    if (monthsBack <= 0) return 12;
    if (monthsBack > 60) return 60;
    return monthsBack;
  }

  bool _isDateInRange(DateTime date, DateTime startInclusive, DateTime endExclusive) {
    return !date.isBefore(startInclusive) && date.isBefore(endExclusive);
  }
}
