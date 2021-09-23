import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ConsultCard extends StatelessWidget {
  final double level;
  final Function press;
  final String patientName;
  ConsultCard({Key key, this.level, this.press, this.patientName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image3.webp"), fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12.0)
          ],
          borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 120.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/consult2.jpg")),
                  borderRadius: BorderRadius.circular(12.0)
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.8),
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(

                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white54,
                        child: Icon(
                          CupertinoIcons.person,
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white38, width: 1))),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                patientName,
                                style: GoogleFonts.mulish(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          offset: Offset(0, 1))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        alignment: Alignment.bottomLeft,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    (level == 0)
                        ? "Aucune donnée ... "
                        : "consultation réalisée à $level %",
                    style: GoogleFonts.mulish(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LinearPercentIndicator(
                      animation: true,
                      lineHeight: 5.0,
                      animationDuration: 2000,
                      backgroundColor: Colors.grey[200],
                      percent: (level / 100),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: (level <= 10)
                          ? Colors.red[800]
                          : (level <= 20)
                              ? Colors.red[400]
                              : (level <= 40)
                                  ? Colors.orange[700]
                                  : (level <= 60)
                                      ? Colors.lightGreen[600]
                                      : (level <= 70)
                                          ? Colors.green[400]
                                          : (level <= 80)
                                              ? Colors.green[600]
                                              : Colors.green[800]),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                // ignore: deprecated_member_use
                child: FlatButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.blue[50],
                    label: Text(
                      "Voir le detail",
                      style: GoogleFonts.mulish(color: Colors.blue[800]),
                    ),
                    icon: Icon(
                      Icons.arrow_right_alt,
                      color: Colors.blue[800],
                    ),
                    onPressed: press),
              ),
            )
          ],
        ),
      ),
    );
  }
}
