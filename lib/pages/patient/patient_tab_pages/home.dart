import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SfCartesianChart(
              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: "Bilan du patient"),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    // Bind data source
                    dataSource: <SalesData>[
                      SalesData('Jan', 35),
                      SalesData('Fev', 28),
                      SalesData('mar', 34),
                      SalesData('Avr', 32),
                      SalesData('Mai', 5),
                      SalesData('juin', 40),
                      SalesData('Juil', 10),
                      SalesData('Aout', 40),
                      SalesData('Sept', 60),
                      SalesData('Oct', 40),
                      SalesData('Dec', 0),
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales)
              ]),
          SfCartesianChart(
              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: "Bilan du patient"),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    // Bind data source
                    dataSource: <SalesData>[
                      SalesData('Jan', 35),
                      SalesData('Fev', 28),
                      SalesData('mar', 34),
                      SalesData('Avr', 32),
                      SalesData('Mai', 5),
                      SalesData('juin', 40),
                      SalesData('Juil', 10),
                      SalesData('Aout', 40),
                      SalesData('Sept', 60),
                      SalesData('Oct', 40),
                      SalesData('Dec', 0),
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales)
              ]),
        ],
      ),
    ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
