import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryCard extends StatelessWidget {
  final String question;
  final String reponse;
  const StoryCard({Key key, this.question, this.reponse}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width/ 1.50,
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black45,
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Question du Médecin",
                              style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '  ${question.toLowerCase()}',
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w600, color: Colors.white),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black45,
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Reponse du patient",
                              style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[900]),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '  ${reponse.toLowerCase()}',
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
