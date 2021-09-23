import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class PatientManagerActionCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final Function navigate;

  const PatientManagerActionCard(
      {Key key, this.color, this.icon, this.title, this.navigate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: navigate,
        borderRadius: BorderRadius.circular(10),
        hoverColor: color.withOpacity(.1),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 6),
                  color: lightGrey.withOpacity(.1),
                  blurRadius: 12.0)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(16.0 * 0.75),
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)]
                          .withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        letterSpacing: .1,
                        color: light),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
