import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamenCard extends StatelessWidget {
  final String examenTitle;
  final String examenValue;
  const ExamenCard({
    Key key,
    this.examenTitle,
    this.examenValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 300.0,
      child: Card(
        elevation: 5,
        shadowColor: Colors.black12,
        color: Colors.blue[100],
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))
              ),
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Libellé examen",
                    style: GoogleFonts.mulish(
                        color: Colors.blue[900],
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    examenTitle.toLowerCase(),
                    style: GoogleFonts.mulish( fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Valeur",
                    style: GoogleFonts.mulish(
                        color: Colors.blue[800],
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    examenValue.toLowerCase(),
                    style: GoogleFonts.mulish( fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}