import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class PrescCard extends StatelessWidget {
  final String prescription;
  final String dosage;
  const PrescCard({Key key, this.prescription, this.dosage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 180.0,
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Prescription",
                      style: GoogleFonts.mulish(
                          color: Colors.blue[900],
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      prescription.toLowerCase(),
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w800),
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
                          color: Colors.blue[900],
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      dosage.toLowerCase(),
                      style: GoogleFonts.mulish( fontWeight: FontWeight.w800),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
