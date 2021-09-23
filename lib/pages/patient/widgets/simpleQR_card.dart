import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class SimpleQRCard extends StatelessWidget {
  final String question;
  final String reponse;
  const SimpleQRCard({Key key, this.question, this.reponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Question ?",
                              style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              question.toLowerCase(),
                              style:
                                  GoogleFonts.mulish(fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 2,
                  color:Colors.grey[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reponse !",
                              style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue[900]),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              reponse.toLowerCase(),
                              style:
                                  GoogleFonts.mulish(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
