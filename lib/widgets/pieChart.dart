import 'package:finanseeup/controllers/pie_chart_controller.dart';
import 'package:finanseeup/models/piece.dart';
import 'package:finanseeup/utils/consts/sizes.dart';
import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChart extends StatefulWidget {
  final PieChartController controller;

  PieChart({required this.controller});

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Piece, String>> series = [
      charts.Series(
        id: 'chart',
        data: widget.controller.currentPieces,
        domainFn: (Piece category, _) => category.category,
        measureFn: (Piece category, _) => category.amount.toInt(),
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (Piece category, _) =>
            '${category.category}: \$${category.amount.toString()}',
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
              height: 220.0,
              child: charts.PieChart(
                series,
                animate: true,
                // defaultRenderer: charts.ArcRendererConfig(
                //   arcRendererDecorators: [charts.ArcLabelDecorator()],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
