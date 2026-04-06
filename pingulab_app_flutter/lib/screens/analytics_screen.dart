import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import '../main.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _salesData;
  Map<String, dynamic>? _profitData;
  Map<String, dynamic>? _depreciationData;
  Map<String, dynamic>? _analysisData;
  Map<String, dynamic>? _metrics;
  bool _isHistoricalRange = true;
  int _monthsBack = 12;
  static const List<int> _monthOptions = [1, 3, 6, 12, 24];

  int get _rangeMonthsBack => _isHistoricalRange ? 0 : _monthsBack;

  @override
  void initState() {
    super.initState();
    _loadAnalyticsData();
  }

  Future<void> _loadAnalyticsData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final salesJson = await client.analytics.getMonthlySalesData(monthsBack: _rangeMonthsBack);
      final profitJson = await client.analytics.getNetProfitData(monthsBack: _rangeMonthsBack);
      final depreciationJson = await client.analytics.getPrinterDepreciationData(depreciationYears: 5);
      final analysisJson = await client.analytics.getSalesVsCostsAnalysis(monthsBack: _rangeMonthsBack);
      final metricsJson = await client.analytics.getOverallMetrics();

      final sales = jsonDecode(salesJson) as Map<String, dynamic>;
      final profit = jsonDecode(profitJson) as Map<String, dynamic>;
      final depreciation = jsonDecode(depreciationJson) as Map<String, dynamic>;
      final analysis = jsonDecode(analysisJson) as Map<String, dynamic>;
      final metrics = jsonDecode(metricsJson) as Map<String, dynamic>;

      setState(() {
        _salesData = sales;
        _profitData = profit;
        _depreciationData = depreciation;
        _analysisData = analysis;
        _metrics = metrics;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error cargando datos: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análisis de Ventas y Ganancias'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAnalyticsData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadAnalyticsData,
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRangeSelector(),
                        const SizedBox(height: 16),

                        // Métricas generales
                        if (_metrics != null) _buildMetricsCards(),
                        const SizedBox(height: 24),

                        // Gráfica de ventas mensuales
                        if (_salesData != null) _buildSalesChart(),
                        const SizedBox(height: 24),

                        // Gráfica de ganancias netas
                        if (_profitData != null) _buildProfitChart(),
                        const SizedBox(height: 24),

                        // Análisis de ventas vs costos
                        if (_analysisData != null) _buildCostsAnalysisChart(),
                        const SizedBox(height: 24),

                        // Amortización de impresoras
                        if (_depreciationData != null) _buildDepreciationChart(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildRangeSelector() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rango de gráficas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DropdownButton<bool>(
                  value: _isHistoricalRange,
                  items: const [
                    DropdownMenuItem<bool>(
                      value: true,
                      child: Text('Histórico (hasta hoy)'),
                    ),
                    DropdownMenuItem<bool>(
                      value: false,
                      child: Text('Por mes'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _isHistoricalRange = value;
                    });
                    _loadAnalyticsData();
                  },
                ),
                if (!_isHistoricalRange)
                  DropdownButton<int>(
                    value: _monthsBack,
                    items: _monthOptions
                        .map(
                          (months) => DropdownMenuItem<int>(
                            value: months,
                            child: Text('$months mes${months == 1 ? '' : 'es'}'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _monthsBack = value;
                      });
                      _loadAnalyticsData();
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsCards() {
    final thisMonth = _metrics!['thisMonth'] as Map<String, dynamic>;
    final lastMonth = _metrics!['lastMonth'] as Map<String, dynamic>;
    final changes = _metrics!['changes'] as Map<String, dynamic>;
    final totals = _metrics!['totals'] as Map<String, dynamic>;

    final revenueChange = (changes['revenueChange'] as num).toDouble();
    final profitChange = (changes['profitChange'] as num).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Métricas Generales',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildMetricCard(
              'Ingresos Este Mes',
              '\$${(thisMonth['revenue'] as num).toStringAsFixed(2)}',
              revenueChange > 0 ? Colors.green : Colors.red,
              '${revenueChange > 0 ? '+' : ''}${revenueChange.toStringAsFixed(1)}%',
            ),
            _buildMetricCard(
              'Ganancia Este Mes',
              '\$${(thisMonth['profit'] as num).toStringAsFixed(2)}',
              profitChange > 0 ? Colors.green : Colors.red,
              '${profitChange > 0 ? '+' : ''}${profitChange.toStringAsFixed(1)}%',
            ),
            _buildMetricCard(
              'Ventas Este Mes',
              '${thisMonth['sales']}',
              Colors.blue,
            ),
            _buildMetricCard(
              'Clientes Totales',
              '${totals['customers']}',
              Colors.purple,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    Color color, [
    String? change,
  ]) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            if (change != null) ...[
              const SizedBox(height: 4),
              Text(
                change,
                style: TextStyle(
                  fontSize: 11,
                  color: change.startsWith('+') ? Colors.green : Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSalesChart() {
    final months = (_salesData!['months'] as List).cast<String>();
    final sales = (_salesData!['totalSales'] as List).cast<num>().map((e) => e.toDouble()).toList();

    final spots = <FlSpot>[];
    for (var i = 0; i < months.length; i++) {
      spots.add(FlSpot(i.toDouble(), sales[i]));
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ventas Mensuales',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < months.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                months[index].split('-').join('/'),
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('\$${(value / 1000).toStringAsFixed(0)}K',
                              style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfitChart() {
    final months = (_profitData!['months'] as List).cast<String>();
    final profits = (_profitData!['netProfit'] as List).cast<num>().map((e) => e.toDouble()).toList();

    final spots = <FlSpot>[];
    for (var i = 0; i < months.length; i++) {
      spots.add(FlSpot(i.toDouble(), profits[i]));
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ganancias Netas Mensuales',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < months.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                months[index].split('-').join('/'),
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('\$${(value / 1000).toStringAsFixed(0)}K',
                              style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: profits.any((p) => p < 0) ? Colors.orange : Colors.green,
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostsAnalysisChart() {
    final months = (_analysisData!['months'] as List).cast<String>();
    final data = _analysisData!['data'] as Map<String, dynamic>;
    final totals = _analysisData!['totals'] as Map<String, dynamic>;

    final salesSpots = <FlSpot>[];
    final costSpots = <FlSpot>[];

    for (var i = 0; i < months.length; i++) {
      final monthData = data[months[i]] as Map<String, dynamic>;
      salesSpots.add(FlSpot(i.toDouble(), (monthData['sales'] as num).toDouble()));
      final totalCosts = ((monthData['filamentCost'] ?? 0.0) as num).toDouble() +
          ((monthData['electricityCost'] ?? 0.0) as num).toDouble() +
          ((monthData['suppliesCost'] ?? 0.0) as num).toDouble() +
          ((monthData['depreciationCost'] ?? 0.0) as num).toDouble();
      costSpots.add(FlSpot(i.toDouble(), totalCosts));
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ventas vs Costos Totales',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem('Ventas', Colors.blue),
                _buildLegendItem('Costos', Colors.red),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < months.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                months[index].split('-').join('/'),
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('\$${(value / 1000).toStringAsFixed(0)}K',
                              style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: salesSpots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                    ),
                    LineChartBarData(
                      spots: costSpots,
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatRow('Ventas Totales', '\$${(totals['sales'] as num).toStringAsFixed(2)}'),
                    _buildStatRow('Costos Totales', '\$${(totals['totalCosts'] as num).toStringAsFixed(2)}'),
                    _buildStatRow('Ganancia Total', '\$${(totals['profit'] as num).toStringAsFixed(2)}',
                        (totals['profit'] as num).toDouble() >= 0 ? Colors.green : Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDepreciationChart() {
    final printers = (_depreciationData!['printers'] as List).cast<Map<String, dynamic>>();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Amortización Real de Impresoras',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (printers.isNotEmpty)
              SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    barGroups: List.generate(
                      printers.length,
                      (index) => BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: (printers[index]['amortizedPercentage'] as num).toDouble(),
                            color: _getDepreciationColor(
                              (printers[index]['amortizedPercentage'] as num).toDouble(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < printers.length) {
                              final name = printers[index]['printerName'] as String;
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  name.substring(0, min(3, name.length)),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text('${value.toInt()}%', style: const TextStyle(fontSize: 10));
                          },
                        ),
                      ),
                    ),
                    maxY: 100,
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text('No hay impresoras registradas'),
                ),
              ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: printers.length,
              itemBuilder: (context, index) {
                final printer = printers[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          printer['printerName'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildStatRow(
                          'Costo Inicial',
                          '\$${(printer['purchaseCost'] as num).toStringAsFixed(2)}',
                        ),
                        _buildStatRow(
                          'Depreciación Mensual',
                          '\$${(printer['monthlyDepreciation'] as num).toStringAsFixed(2)}',
                        ),
                        _buildStatRow(
                          'Amortizado',
                          '${(printer['amortizedPercentage'] as num).toStringAsFixed(1)}%',
                        ),
                        _buildStatRow(
                          'Monto Amortizado',
                          '\$${(printer['amortizedAmount'] as num).toStringAsFixed(2)}',
                        ),
                        _buildStatRow(
                          'Pendiente por Amortizar',
                          '\$${(printer['pendingAmortization'] as num).toStringAsFixed(2)}',
                        ),
                        _buildStatRow(
                          'Horas de Impresión',
                          '${(printer['totalPrintHours'] as num).toStringAsFixed(0)} hrs',
                        ),
                        _buildStatRow(
                          'Ventas Vinculadas',
                          '${printer['linkedSales']}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDepreciationColor(double percentage) {
    if (percentage < 25) return Colors.green;
    if (percentage < 50) return Colors.lightGreen;
    if (percentage < 75) return Colors.orange;
    return Colors.red;
  }
}

int min(int a, int b) => a < b ? a : b;
