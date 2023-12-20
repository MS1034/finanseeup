import 'package:finanseeup/controllers/line_graph_controller.dart';
import 'package:finanseeup/controllers/pie_chart_controller.dart';
import 'package:finanseeup/controllers/statistics_controller.dart';
import 'package:finanseeup/widgets/lineBarGraph.dart';
import 'package:finanseeup/widgets/pieChart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics>
    with SingleTickerProviderStateMixin {
  late StatisticsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = StatisticsController(
      onStateChanged: () {
        setState(() {});
      },
    );

    _controller.initState();
    _controller.tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistics'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
          ],
          bottom: TabBar(
            controller: _controller.tabController,
            tabs: const [
              Tab(text: 'Balance Trend'),
              Tab(text: 'Cash Flow'),
              Tab(text: 'Spending'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller.tabController,
          children: [
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                LineBarGraph(
                  controller: LineBarGraphController(
                    graph: "Balance Trend",
                    currentCoordinates: _controller.balanceTrendList,
                  ),
                )
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                LineBarGraph(
                  controller: LineBarGraphController(
                    graph: "Cash Flow",
                    currentCoordinates: _controller.incomeList,
                    currentCoordinates2: _controller.expenseList,
                    legends: const ['Income', 'Expense'],
                  ),
                )
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                PieChart(
                  controller: PieChartController(
                    graph: "Expenses Structure",
                    currentPieces: _controller.spendings,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Filter by Date'),
                  const SizedBox(height: 8.0),
                  _buildFilterOptions(setState),
                  const SizedBox(height: 8.0),
                  // _buildDateRangePicker(setState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterOptions(Function setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFilterButton('7D', setState),
        _buildFilterButton('30D', setState),
        _buildFilterButton('90D', setState),
        _buildFilterButton('180D', setState),
        _buildFilterButton('365D', setState),
      ],
    );
  }

  Widget _buildFilterButton(String filter, Function setState) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _controller.selectedFilter = filter;
          _controller.filterRecords(_controller.selectedFilter);
        });
      },
      style: _controller.selectedFilter == filter
          ? ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, foregroundColor: Colors.white)
          : null,
      child: Text(filter),
    );
  }
}
