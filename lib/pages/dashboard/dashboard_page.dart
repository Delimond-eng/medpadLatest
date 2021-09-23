import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/pages/dashboard/widgets/dash_card.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashBoardPageView extends StatefulWidget {
  @override
  _DashBoardPageViewState createState() => _DashBoardPageViewState();
}

class _DashBoardPageViewState extends State<DashBoardPageView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/image3.webp"), fit: BoxFit.fill),
      ),
      child: Container(
        decoration: BoxDecoration(
          color : Colors.white.withOpacity(.9)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Obx(() => Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
                                ? 56
                                : 6),
                        child: Container(
                          margin: EdgeInsets.only(top: 35, left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.dashboard_rounded,
                                  color: primaryColor),
                              Text(
                                "${menuController.activeItem.value}",
                                style: GoogleFonts.mulish(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 35.0),
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio:
                      ResponsiveWidget.isCustomScreen(context) ||
                          ResponsiveWidget.isMediumScreen(context)
                          ? 1.40
                          : 1.40),
                    children: [
                      DashCard(
                        title: "Patients",
                        value: "200",
                      ),

                      DashCard(
                        title: "Médecins",
                        value: "10",
                      ),

                      DashCard(
                        title: "Lits",
                        value: "300",
                      ),

                      DashCard(
                        title: "Infirmiers",
                        value: "50",
                      ),

                      DashCard(
                        title: "Examens Labo en Cours",
                        value: "50",
                      ),

                      DashCard(
                        title: "Consultations en Cours",
                        value: "50",
                      ),
                      DashCard(
                        title: "Toutes les consultations",
                        value: "1050",
                      ),

                      DashCard(
                        title: "Resultats Labo disponibles",
                        value: "50",
                      ),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        animationDuration: 2000,
                        percent: 0.7,
                        header: Text("Consultations\nmensuelles", textAlign: TextAlign.center, style: GoogleFonts.mulish(fontSize: 15.0),),
                        center: new Text(
                          "70.0%",
                          style: GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 14.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                      ),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        animationDuration: 2000,
                        percent: 0.7,
                        header: Text("Hospitalisations\nmensuelles", textAlign: TextAlign.center, style: GoogleFonts.mulish(fontSize: 15.0),),
                        center: new Text(
                          "70.0%",
                          style:GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 14.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                      ),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        animationDuration: 2000,
                        percent: 0.7,
                        header: Text("Scannages\nmensuels", textAlign: TextAlign.center, style: GoogleFonts.mulish(fontSize: 15.0),),
                        center: new Text(
                          "70.0 %",
                          style: GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 14.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                      ),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        animationDuration: 2000,
                        percent: 0.7,
                        header: Text("Bilan\nTotal", textAlign: TextAlign.center, style: GoogleFonts.mulish(fontSize: 15.0),),
                        center: new Text(
                          "70.0 %",
                          style:GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 14.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                      ),
                    ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
