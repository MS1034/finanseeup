import 'dart:math';
import 'package:finanseeup/models/account.dart';
import 'package:finanseeup/models/enum_account_type.dart';
import 'package:finanseeup/models/enum_payment_type.dart';
import 'package:finanseeup/models/enum_transaction_type.dart';
import 'package:finanseeup/models/transaction.dart';
import 'package:finanseeup/widgets/lineBarGraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  _Statistics_State createState() => _Statistics_State();
}

class _Statistics_State extends State<Statistics> {
  String selectedFilter = '7D'; // Default filter
  DateTime startDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime endDate = DateTime.now();

  List<TransactionModel> allCoordinates = List.generate(
    120,
    (index) => TransactionModel(
        accountId: ["A", "B", "C"][Random().nextInt(3)],
        category: ["A", "B", "C", "D", "E", "F"][Random().nextInt(6)],
        paymentType: "Cash",
        dateTime: DateTime.now().subtract(Duration(days: Random().nextInt(71))),
        amount: Random().nextDouble() *
            1000.0 *
            ((Random().nextInt(5) == 0) ? -1.0 : 1.0),
        transactionType: ["Income", "Expense"][Random().nextInt(2)]),
  );

  List<Coordinate> balanceTrendList = [], incomeList = [], expenseList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      filterRecords(selectedFilter);
    });
  }

  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
      // Schedule the filterRecords function to be called after the widget is rendered.
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        filterRecords(selectedFilter);
      });
    }

    return Scaffold(
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          lineBarGraph(Graph: "Balance Trend", Coordinates: balanceTrendList),
          lineBarGraph(
            Graph: "Cash Flow",
            Coordinates: incomeList,
            Coordinates2: expenseList,
            Legends: const ['Income', 'Expense'],
          ),
        ],
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Filter by Date'),
                  SizedBox(height: 8.0),
                  _buildFilterOptions(setState),
                  SizedBox(height: 8.0),
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
          selectedFilter = filter;
          filterRecords(selectedFilter);
        });
      },
      child: Text(filter),
      style: selectedFilter == filter
          ? ElevatedButton.styleFrom(backgroundColor: Colors.blue)
          : null,
    );
  }

  Widget _buildDateRangePicker(Function setState) {
    return Row(
      children: [
        Expanded(
          child: Text('Select Date Range'),
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () async {
            DateTimeRange? pickedRange = await showDateRangePicker(
              context: context,
              initialDateRange: DateTimeRange(start: startDate, end: endDate),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );

            if (pickedRange != null) {
              setState(() {
                startDate = pickedRange.start;
                endDate = pickedRange.end;
              });
            }
          },
        ),
      ],
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void filterRecords(String filter) {
    int range = int.parse(filter.substring(0, filter.length - 1));
    DateTime startDate = DateTime.now().subtract(Duration(days: range - 1)),
        endDate = DateTime.now();

    // Initializing with 0 for all days
    List<Coordinate> AllDays = [];
    for (DateTime date = startDate;
        date.isBefore(endDate) || isSameDay(date, endDate);
        date = date.add(const Duration(days: 1))) {
      AllDays.add(Coordinate(date: date, amount: 0));
    }

    updateBalanceTrendGraph(AllDays, startDate, endDate);
    updateCashFlowGraph(AllDays, startDate, endDate);
  }

  void updateBalanceTrendGraph(
      List<Coordinate> AllDays, DateTime startDate, DateTime endDate) {
    //Convert from transaction to coordinate and filtering by use
    List<Coordinate> allCoordinatesIntoCoordinate = allCoordinates
        .map((e) => Coordinate(date: e.dateTime!, amount: e.amount))
        .toList();

    setState(() {
      balanceTrendList = filterByDateRange(
          allCoordinatesIntoCoordinate, AllDays, startDate, endDate);
    });

    List<Coordinate> summedCoordinates = GroupSumByDate(balanceTrendList);
    setState(() {
      balanceTrendList.clear();
      balanceTrendList.addAll(summedCoordinates);
    });
  }

  void updateCashFlowGraph(
      List<Coordinate> AllDays, DateTime startDate, DateTime endDate) {
    //Convert from transaction to coordinate and filtering by use
    List<Coordinate> allCoordinatesIntoCoordinate_Income = allCoordinates
        .where((element) => element.transactionType == TransactionType.Income)
        .map((e) => Coordinate(date: e.dateTime!, amount: e.amount))
        .toList();

    List<Coordinate> allCoordinatesIntoCoordinate_Expense = allCoordinates
        .where((element) => element.transactionType == TransactionType.Expense)
        .map((e) => Coordinate(date: e.dateTime!, amount: e.amount))
        .toList();

    setState(() {
      incomeList = filterByDateRange(
          allCoordinatesIntoCoordinate_Income, AllDays, startDate, endDate);

      expenseList = filterByDateRange(
          allCoordinatesIntoCoordinate_Expense, AllDays, startDate, endDate);
    });

    List<Coordinate> summedCoordinates_Income = GroupSumByDate(incomeList);
    List<Coordinate> summedCoordinates_Expense = GroupSumByDate(expenseList);

    setState(() {
      incomeList.clear();
      incomeList.addAll(summedCoordinates_Income);

      expenseList.clear();
      expenseList.addAll(summedCoordinates_Expense);
    });
  }

  List<Coordinate> GroupSumByDate(List<Coordinate> list) {
    Map<DateTime, double> amountMap = {};

    for (var coordinate in list) {
      DateTime coordinateDate = DateTime(
          coordinate.date.year, coordinate.date.month, coordinate.date.day);
      amountMap[coordinateDate] =
          (amountMap[coordinateDate] ?? 0) + coordinate.amount;
    }

    // Now `amountMap` contains the summed amounts for each unique date
    List<Coordinate> summedCoordinates = amountMap.entries
        .map((entry) => Coordinate(date: entry.key, amount: entry.value))
        .toList();

    summedCoordinates.sort((a, b) => a.date.compareTo(b.date));
    return summedCoordinates;
  }

  List<Coordinate> filterByDateRange(List<Coordinate> list,
      List<Coordinate> AllDays, DateTime startDate, DateTime endDate) {
    return (list + AllDays)
        .where((Coordinate) =>
            (Coordinate.date.isAfter(startDate) ||
                isSameDay(Coordinate.date, startDate)) &&
            (Coordinate.date.isBefore(endDate) ||
                isSameDay(Coordinate.date, endDate)))
        .toList();
  }
}
