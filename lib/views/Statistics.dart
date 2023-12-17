import 'dart:math';

import 'package:finanseeup/widgets/expense.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

// class Expense {
//   final DateTime date;
//   final double amount;

//   Expense(this.date, this.amount);
// }

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  _Statistics_State createState() => _Statistics_State();
}

class _Statistics_State extends State<Statistics> {
  String selectedFilter = '7D'; // Default filter
  DateTime startDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime endDate = DateTime.now();

  List<Coordinate> allExpenses = List.generate(
    50,
    (index) => Coordinate(
        date: DateTime.now().subtract(Duration(days: Random().nextInt(31))),
        value: Random().nextDouble() *
            1000.0 *
            ((Random().nextInt(5) == 0) ? -1.0 : 1.0),
        legend: "Trend"),
  );

  List<Coordinate> filterPreviewList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Call filterRecords after the widget is fully rendered
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
          lineGraph(seriesList: [filterPreviewList])
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

  void filterRecords(String filter) {
    int range = int.parse(filter.substring(0, filter.length - 1));
    DateTime startDate = DateTime.now().subtract(Duration(days: range - 1)),
        endDate = DateTime.now();

    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    bool containsDate(Set<DateTime> dates, DateTime date) {
      for (var element in dates) {
        if (isSameDay(element, date)) {
          return true;
        }
      }

      return false;
    }

    // Initializing with 0 for all days
    List<Coordinate> AllDays = [];
    for (DateTime date = startDate;
        date.isBefore(endDate) || isSameDay(date, endDate);
        date = date.add(const Duration(days: 1))) {
      AllDays.add(Coordinate(date: date, value: 0, legend: ""));
    }

    setState(() {
      filterPreviewList = (allExpenses + AllDays)
          .where((expense) =>
              (expense.date.isAfter(startDate) ||
                  isSameDay(expense.date, startDate)) &&
              (expense.date.isBefore(endDate) ||
                  isSameDay(expense.date, endDate)))
          .toList();
    });

    Map<DateTime, double> amountMap = {};

    for (var expense in filterPreviewList) {
      DateTime expenseDate =
          DateTime(expense.date.year, expense.date.month, expense.date.day);
      amountMap[expenseDate] = (amountMap[expenseDate] ?? 0) + expense.value;
    }

    // Now `amountMap` contains the summed amounts for each unique date
    List<Coordinate> summedExpenses = amountMap.entries
        .map((entry) =>
            Coordinate(date: entry.key, value: entry.value, legend: ""))
        .toList();

    summedExpenses.sort((a, b) => a.date.compareTo(b.date));
    setState(() {
      filterPreviewList.clear();
      filterPreviewList.addAll(summedExpenses);
    });

    print(filterPreviewList.map((element) {
      return "${element.value} ${element.date}";
    }));

    // Set<DateTime> existingDates =
    //     filterPreviewList.map((expense) => expense.date).toSet();

    // for (DateTime date = startDate;
    //     date.isBefore(endDate) || isSameDay(date, endDate);
    //     date = date.add(const Duration(days: 1))) {
    //   if (!containsDate(existingDates, date)) {
    //     // If the date is not in the existing dates, add an Expense with amount 0
    //     filterPreviewList.add(Expense(date: date, amount: 0));
    //   }
    // }

    // DateTime minDate = FilterPreviewList.map((expense) => expense.date)
    //     .reduce((value, element) => value.isBefore(element) ? value : element);

    // DateTime maxDate = FilterPreviewList.map((expense) => expense.date)
    //     .reduce((value, element) => value.isAfter(element) ? value : element);

    // if (!isSameDay(minDate, startDate)) {
    //   FilterPreviewList.add(Expense(startDate, 0));
    //   if (!isSameDay(minDate.add(const Duration(days: -1)), startDate)) {
    //     FilterPreviewList.add(
    //         Expense(DateTime.now().add(const Duration(days: -30)), 0));
    //     print("ba");
    //   }
    // }
  }
}
