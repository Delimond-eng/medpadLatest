import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepProgressView extends StatelessWidget {
  //height of the container
  final double height;
//width of the container
  final double width;
//container decoration
  final BoxDecoration decoration;
//list of texts to be shown for each step
  final List<String> stepsText;
//cur step identifier
  final int curStep;
//active color
  final Color activeColor;
//in-active color
  final Color inactiveColor;
//dot radius
  final double dotRadius;
//container padding
  final EdgeInsets padding;
//line height
  final double lineHeight;
//header textstyle
  final TextStyle headerStyle;
//steps text
  final TextStyle stepStyle;
  const StepProgressView(
    List<String> stepsText,
    int curStep,
    double height,
    double width,
    double dotRadius,
    Color activeColor,
    Color inactiveColor,
    TextStyle headerStyle,
    TextStyle stepsStyle, {
    Key key,
    this.decoration,
    this.padding,
    this.lineHeight = 3.0,
  })  : stepsText = stepsText,
        curStep = curStep,
        height = height,
        width = width,
        dotRadius = dotRadius,
        activeColor = activeColor,
        inactiveColor = inactiveColor,
        headerStyle = headerStyle,
        stepStyle = stepsStyle,
        assert(curStep >= 0 == true),
        assert(width > 0),
        assert(height >= 2 * dotRadius),
        assert(width >= dotRadius * 2 * stepsText.length),
        super(key: key);

  List<Widget> buildDots() {
    var wids = <Widget>[];
    stepsText.asMap().forEach((i, text) {
      var circleColor = (i == 0 || curStep > i) ? activeColor : inactiveColor;

      var lineColor = curStep > i + 1 ? activeColor : inactiveColor;

      wids.add(CircleAvatar(
        radius: curStep > i ? 15 : dotRadius,
        backgroundColor: circleColor,
        child: Center(
          child: Text(
            "${i + 1}",
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ));

      //add a line separator
      //0-------0--------0
      if (i != stepsText.length - 1) {
        wids.add(Expanded(
            child: Container(
          height: lineHeight,
          color: lineColor,
        )));
      }
    });

    return wids;
  }

  List<Widget> buildText() {
    var wids = <Widget>[];
    stepsText.asMap().forEach((i, text) {
      wids.add(Text(text,
          style: GoogleFonts.mulish(
              color: curStep > i ? Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900 : null,
              fontWeight: curStep > i ? FontWeight.w700 : FontWeight.normal,
              fontSize: 12.0)));
    });

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        height: this.height,
        width: this.width,
        decoration: this.decoration,
        child: Column(
          children: <Widget>[
            Row(
              children: buildDots(),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buildText(),
            )
          ],
        ));
  }
}
