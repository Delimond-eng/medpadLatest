import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';
import 'dart:math' as math;

class AntCard extends StatelessWidget {
  final String antTitle;
  final String antQuestion;
  final String antReponse;
  final Color color;
  const AntCard(
      {Key key, this.antTitle, this.antQuestion, this.antReponse, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0, right: 5.0, left: 5.0),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 170.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5.0,
              shadowColor: Colors.black26,
              color: Colors.blue[200],
              child: Container(
                margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
                padding: EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.black54,
                          color: Colors.blue[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: 120,
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.medical_services,
                                          color: Colors.blue[800],
                                          size: 18.0,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "QUESTION",
                                          style: GoogleFonts.mulish(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue[800]),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '  ${antQuestion.toLowerCase()}',
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.black54,
                          color: Colors.blue[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: 120,
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons
                                              .person_crop_circle_fill_badge_exclam,
                                          color: Colors.blue[800],
                                          size: 18.0,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "REPONSE",
                                          style: GoogleFonts.mulish(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue[800]),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '  ${antQuestion.toLowerCase()}',
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: 10,
            child: Container(
              height: 80.0,
              width: 300,
              child: Card(
                color: Colors
                    .primaries[math.Random().nextInt(Colors.primaries.length)]
                    .shade900,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                shadowColor: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        (antTitle == "personnel")
                            ? Icons.attribution_outlined
                            : (antTitle == "chirurgical")
                                ? Icons.circle
                                : Icons.wc_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Antécédent $antTitle",
                        style: GoogleFonts.mulish(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*Widget build(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                offset: Offset(5,0),
                color: lightGrey.withOpacity(.3),
                blurRadius: 12.0
            )
          ]
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(top: 50.0),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 6),
                              color: lightGrey.withOpacity(.1),
                              blurRadius: 12.0)

                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Padding(
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
                  ),
                ),
                SizedBox(width: 8.0),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 6),
                              color: lightGrey.withOpacity(.1),
                              blurRadius: 12.0)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
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
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(5,2),
                      color: lightGrey.withOpacity(.3),
                      blurRadius: 12.0
                  )
                ],
                color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(antTitle=="personnel" ? CupertinoIcons.person : antTitle=="familiale" ? Icons.wc_outlined : Icons.circle, color: Colors.white,),
                SizedBox(width: 10.0,),
                Text("Antécédent $antTitle", style: GoogleFonts.mulish(color: Colors.white, fontWeight: FontWeight.w600),),
              ],
            ),
          )
        ],
      ));
}
 */
