import 'dart:math';

import 'package:finanseeup/models/coordinate.dart';
import 'package:finanseeup/models/piece.dart';
import 'package:finanseeup/models/transaction.dart';
import 'package:flutter/material.dart';

class StatisticsController {
  late TabController tabController;
  String selectedFilter = '7D';
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
      transactionType: ["Income", "Expense"][Random().nextInt(2)],
    ),
  );
  List<Coordinate> balanceTrendList = [], incomeList = [], expenseList = [];
  List<Piece> spendings = [];

  late void Function() onStateChanged;
  StatisticsController({required this.onStateChanged});

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filterRecords(selectedFilter);
    });
  }

  void dispose() {
    tabController.dispose();
  }

  void filterRecords(String filter) {
    int range = int.parse(filter.substring(0, filter.length - 1));
    DateTime startDate = DateTime.now().subtract(Duration(days: range - 1)),
        endDate = DateTime.now();
    List<Coordinate> AllDays = [];
    for (DateTime date = startDate;
        date.isBefore(endDate) || isSameDay(date, endDate);
        date = date.add(const Duration(days: 1))) {
      AllDays.add(Coordinate(date: date, amount: 0));
    }

    updateBalanceTrendGraph(AllDays, startDate, endDate);
    updateCashFlowGraph(AllDays, startDate, endDate);
    updateSpendingGraph(startDate, endDate);

    onStateChanged();
  }

  void updateBalanceTrendGraph(
      List<Coordinate> AllDays, DateTime startDate, DateTime endDate) {
    List<Coordinate> allCoordinatesIntoCoordinate = allCoordinates
        .where((element) => element.transactionType != "Transfer")
        .map((e) => Coordinate(
            date: e.dateTime!,
            amount: e.amount * ((e.transactionType == "Income") ? 1 : -1)))
        .toList();

    List<Coordinate> newBalanceTrendList = filterByDateRange(
        allCoordinatesIntoCoordinate, AllDays, startDate, endDate);

    List<Coordinate> summedCoordinates =
        groupSumByDate_Coordinate(newBalanceTrendList);

    balanceTrendList.clear();
    balanceTrendList.addAll(summedCoordinates);
  }

  void updateCashFlowGraph(
      List<Coordinate> AllDays, DateTime startDate, DateTime endDate) {
    List<Coordinate> allcoordinatesintocoordinateIncome = allCoordinates
        .where((element) => element.transactionType == "Income")
        .map((e) => Coordinate(date: e.dateTime!, amount: e.amount))
        .toList();

    List<Coordinate> allcoordinatesintocoordinateExpense = allCoordinates
        .where((element) => element.transactionType == "Expense")
        .map((e) => Coordinate(date: e.dateTime!, amount: e.amount))
        .toList();

    incomeList = filterByDateRange(
        allcoordinatesintocoordinateIncome, AllDays, startDate, endDate);

    expenseList = filterByDateRange(
        allcoordinatesintocoordinateExpense, AllDays, startDate, endDate);

    List<Coordinate> summedcoordinatesIncome =
        groupSumByDate_Coordinate(incomeList);
    List<Coordinate> summedcoordinatesExpense =
        groupSumByDate_Coordinate(expenseList);

    incomeList.clear();
    incomeList.addAll(summedcoordinatesIncome);

    expenseList.clear();
    expenseList.addAll(summedcoordinatesExpense);
  }

  void updateSpendingGraph(DateTime startDate, DateTime endDate) {
    List<Piece> allpiecesintocoordinateExpense = allCoordinates
        .where((element) => (element.transactionType == "Expense" &&
            (element.dateTime!.isAfter(startDate) ||
                isSameDay(element.dateTime!, startDate)) &&
            (element.dateTime!.isBefore(endDate) ||
                isSameDay(element.dateTime!, endDate))))
        .map((e) => Piece(category: e.category ?? "", amount: e.amount))
        .toList();

    List<Piece> summedpiecesExpense =
        groupSumByDate_Piece(allpiecesintocoordinateExpense);

    spendings.clear();
    spendings.addAll(summedpiecesExpense);
  }

  List<Coordinate> groupSumByDate_Coordinate(List<Coordinate> list) {
    Map<DateTime, double> amountMap = {};

    for (var coordinate in list) {
      DateTime coordinateDate = DateTime(
          coordinate.date.year, coordinate.date.month, coordinate.date.day);
      amountMap[coordinateDate] =
          (amountMap[coordinateDate] ?? 0) + coordinate.amount;
    }

    List<Coordinate> summedCoordinates = amountMap.entries
        .map((entry) => Coordinate(date: entry.key, amount: entry.value))
        .toList();

    summedCoordinates.sort((a, b) => a.date.compareTo(b.date));
    return summedCoordinates;
  }

  List<Piece> groupSumByDate_Piece(List<Piece> list) {
    Map<String, double> amountMap = {};

    for (var piece in list) {
      amountMap[piece.category] =
          (amountMap[piece.category] ?? 0) + piece.amount;
    }

    List<Piece> summedPiece = amountMap.entries
        .map((entry) => Piece(category: entry.key, amount: entry.value))
        .toList();

    summedPiece.sort((a, b) => a.category.compareTo(b.category));
    return summedPiece;
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

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
