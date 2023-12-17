import 'package:finanseeup/utils/consts/sizes.dart';
import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Piece {
  final String category;
  final double amount;

  Piece({required this.category, required this.amount});
}

class pieChart extends StatefulWidget {
  final String Graph;
  final List<Piece> Pieces;

  pieChart({required this.Graph, required this.Pieces});

  @override
  // ignore: library_private_types_in_public_api
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<pieChart> {
  List<Piece> _currentPieces = [];
  String _graph = "";

  @override
  void initState() {
    super.initState();
    _currentPieces = widget.Pieces;
    _graph = widget.Graph;
  }

  void updatePieces(List<Piece> newPieces) {
    setState(() {
      _currentPieces = newPieces;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Piece, String>> series = [
      charts.Series(
        id: 'chart',
        data: _currentPieces,
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
              _graph,
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
