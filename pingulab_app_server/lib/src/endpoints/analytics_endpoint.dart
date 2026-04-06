import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint para análisis de gráficas, ventas netas, amortización y ganancias
class AnalyticsEndpoint extends Endpoint {
  int _normalizeMonthsBack(int monthsBack) {
    if (monthsBack < 1) return 1;
    if (monthsBack > 120) return 120;
    return monthsBack;
  }

  /// Obtiene datos de ventas mensuales para la gráfica
  Future<String> getMonthlySalesData(
    Session session, {
    int monthsBack = 12,
  }) async {
    monthsBack = _normalizeMonthsBack(monthsBack);
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - monthsBack, now.day);

    // Obtener todas las ventas completadas en el rango
    final allSales = await Sale.db.find(session);
    final sales = allSales.where((s) => !s.created.isBefore(startDate)).toList();

    // Agrupar por mes-año
    final monthlyData = <String, double>{};
    for (var i = 0; i < monthsBack; i++) {
      final date = DateTime(now.year, now.month - (monthsBack - i - 1), 1);
      final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';
      monthlyData[monthKey] = 0.0;
    }

    // Sumar ventas por mes
    for (var sale in sales) {
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
    monthsBack = _normalizeMonthsBack(monthsBack);
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - monthsBack, now.day);

    // Obtener todas las ventas en el rango
    final allSales = await Sale.db.find(session);
    final sales = allSales.where((s) => !s.created.isBefore(startDate)).toList();

    // Agrupar por mes-año y calcular ganancias
    final monthlyData = <String, double>{};
    for (var i = 0; i < monthsBack; i++) {
      final date = DateTime(now.year, now.month - (monthsBack - i - 1), 1);
      final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';
      monthlyData[monthKey] = 0.0;
    }

    // Calcular ganancias por venta
    for (var sale in sales) {
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

    final depreciationData = <Map<String, dynamic>>[];
    double totalDepreciation = 0.0;

    for (var printer in printers) {
      // Calcular depreciación: costo / años de vida útil
      final monthlyDepreciation = printer.purchaseCost / (depreciationYears * 12);

      // Obtener total de horas de impresion usando esta impresora
      final quotes = await Quote.db.find(
        session,
        where: (t) => t.printerId.equals(printer.id),
      );

      double totalPrintHours = 0;
      for (var quote in quotes) {
        totalPrintHours += quote.printHours;
      }

      final usagePercentage =
          totalPrintHours > 0 ? (totalPrintHours / (depreciationYears * 365 * 24)) * 100 : 0.0;
      totalDepreciation += printer.purchaseCost;

      depreciationData.add({
        'printerName': printer.name,
        'printerId': printer.id,
        'purchaseCost': printer.purchaseCost,
        'monthlyDepreciation': monthlyDepreciation,
        'depreciationPercentage': (usagePercentage).clamp(0.0, 100.0),
        'totalPrintHours': totalPrintHours,
      });
    }

    return jsonEncode({
      'printers': depreciationData,
      'totalDepreciation': totalDepreciation,
      'averageDepreciation': depreciationData.isEmpty 
          ? 0.0 
          : totalDepreciation / depreciationData.length,
    });
  }

  /// Obtiene datos de análisis comparativo: ventas vs costos
  Future<String> getSalesVsCostsAnalysis(
    Session session, {
    int monthsBack = 12,
  }) async {
    monthsBack = _normalizeMonthsBack(monthsBack);
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - monthsBack, now.day);

    // Obtener todas las ventas en el rango
    final allSales = await Sale.db.find(session);
    final sales = allSales.where((s) => !s.created.isBefore(startDate)).toList();

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
    final thisMonthEnd = DateTime(now.year, now.month + 1, 1);
    final allSales = await Sale.db.find(session);

    // Ventas este mes
    final thisMonthSales = allSales
        .where((s) => !s.created.isBefore(thisMonthStart) && s.created.isBefore(thisMonthEnd))
        .toList();

    // Ventas mes pasado
    final lastMonthSales = allSales
        .where((s) => !s.created.isBefore(lastMonthStart) && s.created.isBefore(thisMonthStart))
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
}
