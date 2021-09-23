import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AntecedentCard extends StatelessWidget {
  final String antTitle;
  final String antQuestion;
  final String antReponse;
  AntecedentCard({Key key, this.antTitle, this.antQuestion, this.antReponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70.0,
              width: MediaQuery.of(context).size.width / 2 - 25,
              child: Card(
                elevation: 2.0,
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Antécédent",
                        style: GoogleFonts.mulish(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[200]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        antTitle,
                        style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 2.0,
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
                                      color: Colors.blue[900]),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  antQuestion.toLowerCase(),
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w600),
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
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 2.0,
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
                                  antReponse.toLowerCase(),
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w600),
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
            )
          ],
        ));
  }
}
