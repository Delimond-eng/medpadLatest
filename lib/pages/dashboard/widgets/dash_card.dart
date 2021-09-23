import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class DashCard extends StatelessWidget {
  final String title;
  final String value;

  const DashCard(
      {Key key,
      this.title,
      this.value,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12.0)
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
            height: 5,
          ),
          Expanded(child: Container()),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "$title\n",
                  style: GoogleFonts.mulish(
                      color: Colors.grey[500],
                      fontSize: 16.0)),
              TextSpan(
                  text: "$value\n",
                  style: GoogleFonts.mulish(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w900)),
            ]),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
