import 'dart:math';

import 'package:finanseeup/utils/consts/sizes.dart';
import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Coordinate {
  DateTime date;
  double amount;

  Coordinate({required this.date, required this.amount});
}

class lineBarGraph extends StatefulWidget {
  final String Graph;
  final List<Coordinate> Coordinates;
  final List<Coordinate>? Coordinates2;
  final List<String>? Legends;

  const lineBarGraph(
      {super.key,
      required this.Graph,
      required this.Coordinates,
      this.Coordinates2,
      this.Legends});

  @override
  // ignore: library_private_types_in_public_api
  _lineBarGraphState createState() => _lineBarGraphState();
}

class _lineBarGraphState extends State<lineBarGraph> {
  List<Coordinate> _currentCoordinates = [], _currentCoordinates2 = [];
  List<String>? _legends;
  String _graph = "";

  @override
  void initState() {
    super.initState();
    _currentCoordinates = widget.Coordinates;
    if (widget.Coordinates2 != null && widget.Coordinates2!.isNotEmpty) {
      _currentCoordinates2 = widget.Coordinates2!;
    }
    if (widget.Legends != null && widget.Legends!.isNotEmpty) {
      _legends = widget.Legends;
    }
    _graph = widget.Graph;
  }

  void updatecoordinates(
      List<Coordinate> newCoordinates, List<Coordinate>? newCoordinates2) {
    setState(() {
      _currentCoordinates = newCoordinates;
      if (widget.Coordinates2 != null && widget.Coordinates2!.isNotEmpty) {
        _currentCoordinates2 = newCoordinates2!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Coordinate, DateTime>> series = [
      charts.Series(
        id: 'coordinates',
        data: widget.Coordinates,
        domainFn: (Coordinate coordinate, _) => coordinate.date,
        measureFn: (Coordinate coordinate, _) => coordinate.amount,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        displayName: widget.Legends?[0],
      ),
      if (widget.Coordinates2 != null && widget.Coordinates2!.isNotEmpty)
        charts.Series(
          id: 'coordinates1',
          data: widget.Coordinates2!,
          domainFn: (Coordinate coordinate, _) => coordinate.date,
          measureFn: (Coordinate coordinate, _) => coordinate.amount,
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          displayName: widget.Legends?[1],
        ),
    ];

    return Card(
      elevation: 4.0,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.md),
        height: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppHelperFunctions.bgColor()),
        child: ListView(
          children: [
            Text(
              _graph,
              style: TextStyle(
                fontSize: AppSizes.fontSizeLg,
                fontWeight: FontWeight.bold,
                color: AppHelperFunctions.textColor(),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            SizedBox(
              height: 220.0, // Adjust the height of the chart
              child: charts.TimeSeriesChart(
                series,
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                primaryMeasureAxis: const charts.NumericAxisSpec(
                  tickProviderSpec:
                      charts.BasicNumericTickProviderSpec(desiredTickCount: 5),
                ),
                behaviors: [
                  if (_legends?.length == 2) charts.SeriesLegend(),
                ],
                // Add colored area under the curve
                defaultRenderer: charts.LineRendererConfig(
                  includeArea: true,
                  stacked: true,
                  areaOpacity: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
