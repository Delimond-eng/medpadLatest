import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrescriptionCard extends StatelessWidget {
  final String prescription;
  final String dosage;
  final Color color;
  const PrescriptionCard({Key key, this.prescription, this.dosage, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: color==null ? Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900 :color,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Prescription",
                style: GoogleFonts.mulish(
                    color: Colors.yellow[300],
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                prescription.toLowerCase(),
                style: GoogleFonts.mulish(
                    color: Colors.white, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width),
              SizedBox(
                height: 10,
              ),
              Text(
                "Dosage",
                style: GoogleFonts.mulish(
                    color: Colors.yellow[300],
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                dosage.toLowerCase(),
                style: GoogleFonts.mulish(
                    color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ],
          )),
    );
  }
}
