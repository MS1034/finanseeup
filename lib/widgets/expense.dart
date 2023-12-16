import 'package:finanseeup/utils/consts/sizes.dart';
import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Expense {
  DateTime date;
  double amount;

  Expense({required this.date, required this.amount});
}

class ExpenseBarGraph extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseBarGraph({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Expense, DateTime>> series = [
      charts.Series(
        id: 'Expenses',
        data: expenses,
        domainFn: (Expense expense, _) => expense.date,
        measureFn: (Expense expense, _) => expense.amount,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        displayName: 'Money',
      ),
    ];

    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(color: AppHelperFunctions.bgColor()),
        child: Column(
          children: [
            Text(
              'Balance Trend',
              style: TextStyle(
                fontSize: AppSizes.fontSizeLg,
                fontWeight: FontWeight.bold,
                color: AppHelperFunctions
                    .textColor(), // Use your textColor function
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            Container(
              height: 200.0, // Adjust the height of the chart
              child: charts.TimeSeriesChart(
                series,
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                primaryMeasureAxis: charts.NumericAxisSpec(
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
