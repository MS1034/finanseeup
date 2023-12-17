import 'package:finanseeup/utils/consts/sizes.dart';
import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Coordinate {
  DateTime date;
  double value;
  String legend;

  Coordinate({required this.date, required this.value, required this.legend});
}

class lineGraph extends StatefulWidget {
  final List<List<Coordinate>> seriesList;

  const lineGraph({Key? key, required this.seriesList}) : super(key: key);

  @override
  _lineGraphState createState() => _lineGraphState();
}

class _lineGraphState extends State<lineGraph> {
  List<List<Coordinate>> _currentSeriesList = [];

  @override
  void initState() {
    super.initState();
    _currentSeriesList = widget.seriesList;
  }

  void updateSeriesList(List<List<Coordinate>> newSeriesList) {
    setState(() {
      _currentSeriesList = newSeriesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Coordinate, DateTime>> series = _currentSeriesList
        .asMap()
        .entries
        .map((entry) => charts.Series(
              id: 'Series ${entry.key + 1}',
              data: entry.value,
              domainFn: (Coordinate coordinate, _) => coordinate.date,
              measureFn: (Coordinate coordinate, _) => coordinate.value,
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              // displayNameFn: (Coordinate coordinate, _) => coordinate.legend,
            ))
        .toList();

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
              'Balance Trend',
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
