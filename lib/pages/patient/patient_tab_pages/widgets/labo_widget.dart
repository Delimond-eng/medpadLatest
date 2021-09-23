import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class LaboCard extends StatelessWidget {
  final String examTitle;

  const LaboCard({Key key, this.examTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 300.0,
      child: Card(
        elevation: 5,
        shadowColor: Colors.black12,
        color: Colors.deepPurple[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))),
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Examen",
                      style: GoogleFonts.mulish(
                          color: Colors.deepPurple[800],
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      examTitle,
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w800),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
