import 'package:charts_flutter/flutter.dart' as charts;
import 'package:finanseeup/controllers/line_graph_controller.dart';
import 'package:finanseeup/models/coordinate.dart';
import 'package:finanseeup/utils/consts/sizes.dart';
import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:flutter/material.dart';

class LineBarGraph extends StatefulWidget {
  final LineBarGraphController controller;

  const LineBarGraph({super.key, required this.controller});

  @override
  _LineBarGraphState createState() => _LineBarGraphState();
}

class _LineBarGraphState extends State<LineBarGraph> {
  @override
  void initState() {
    super.initState();
    widget.controller.initialize(
        widget.controller.currentCoordinates,
        widget.controller.currentCoordinates2,
        widget.controller.legends,
        widget.controller.graph);
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Coordinate, DateTime>> series = [
      charts.Series(
        id: 'coordinates',
        data: widget.controller.currentCoordinates,
        domainFn: (Coordinate coordinate, _) => coordinate.date,
        measureFn: (Coordinate coordinate, _) => coordinate.amount,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        displayName: widget.controller.legends?[0],
      ),
      if (widget.controller.currentCoordinates2.isNotEmpty)
        charts.Series(
          id: 'coordinates1',
          data: widget.controller.currentCoordinates2,
          domainFn: (Coordinate coordinate, _) => coordinate.date,
          measureFn: (Coordinate coordinate, _) => coordinate.amount,
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          displayName: widget.controller.legends?[1],
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
              widget.controller.graph,
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
                  if (widget.controller.legends?.length == 2)
                    charts.SeriesLegend(),
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
