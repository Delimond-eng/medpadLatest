import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 150,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
                Text(
                  "Rendement",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        height: 0.5,
                      ),
                ),
                SizedBox(height: 16.0),
                Text("10 / 20")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    value: 25,
    showTitle: true,
    title: "Lundi",
    titleStyle: GoogleFonts.mulish(
        color: secondaryColor, shadows: [Shadow(color: Colors.black)]),
    radius: 30,
  ),
  PieChartSectionData(
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    value: 20,
    title: "Mardi",
    titleStyle: GoogleFonts.mulish(
        color: secondaryColor, shadows: [Shadow(color: Colors.black)]),
    showTitle: true,
    radius: 40,
  ),
  PieChartSectionData(
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    value: 10,
    title: "Mercredi",
    titleStyle: GoogleFonts.mulish(
        color: secondaryColor, shadows: [Shadow(color: Colors.black)]),
    showTitle: true,
    radius: 30,
  ),
  PieChartSectionData(
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    value: 15,
    title: "Jeudi",
    titleStyle: GoogleFonts.mulish(
        color: secondaryColor, shadows: [Shadow(color: Colors.black)]),
    showTitle: true,
    radius: 25,
  ),
  PieChartSectionData(
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
        .withOpacity(.5),
    value: 25,
    title: "Vendredi",
    showTitle: true,
    titleStyle: GoogleFonts.mulish(color: secondaryColor, shadows: [
      Shadow(
        color: Colors.black,
      )
    ]),
    radius: 28,
  ),
  PieChartSectionData(
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
        .withOpacity(.5),
    value: 25,
    showTitle: true,
    title: "Samedi",
    titleStyle: GoogleFonts.mulish(color: secondaryColor, shadows: [
      Shadow(
        color: Colors.black,
      )
    ]),
    radius: 25,
  ),
  PieChartSectionData(
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
        .withOpacity(.5),
    value: 25,
    title: "Dimanche",
    titleStyle: GoogleFonts.mulish(
        color: secondaryColor, shadows: [Shadow(color: Colors.black)]),
    showTitle: true,
    radius: 20,
  ),
];
