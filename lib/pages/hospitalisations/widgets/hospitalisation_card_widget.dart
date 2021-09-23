import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/style.dart';

class HospitalisationViewCard extends StatelessWidget {
  final Function onNavigate;
  final String patientName;
  final String litDesign;

  const HospitalisationViewCard({Key key, this.onNavigate, this.patientName, this.litDesign}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12.0)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130.0,
            decoration: BoxDecoration(
                color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12.0)
              ],
            ),
            padding: EdgeInsets.all(10.0),
            child: Stack(
              children: [

                Container(
                  child: Lottie.asset("assets/lotties/31796-stethoscope.json",
                      fit: BoxFit.cover,
                      width: 60.0,
                      height: 60.0,
                      animate: true,
                      alignment: Alignment.center
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.only(top:20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white54,
                        child: Icon(
                          CupertinoIcons.person,
                          size: 15.0,
                          color: Colors.blue[900],
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Flexible(
                        child: Text(
                          patientName.substring(0).toUpperCase(),
                          style: GoogleFonts.mulish(
                              color: Colors.blue[900],
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,)
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.bottomLeft,
                ),

              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.all(8.0),
            child: Text(
                "Lit : ${litDesign.substring(0).toUpperCase()}",
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w900, color: Colors.blue[900])
            ),
            alignment: Alignment.center,
          ),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            // ignore: deprecated_member_use
            child: FlatButton.icon(
              icon: Icon(Icons.arrow_right_alt, color: Colors.blue[900],),
              minWidth: 200.0,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              ),
              color: Colors.blue[50],
              label: Text("Voir detail", style: GoogleFonts.mulish(color: Colors.blue[900], fontSize: 15, letterSpacing: 1.0)),
              onPressed: onNavigate,
            ),
          ),
        ],
      ),
    );
  }
}
