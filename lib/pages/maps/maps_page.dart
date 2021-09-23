import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';

class MapsPageView extends StatefulWidget {
  @override
  _MapsPageViewState createState() => _MapsPageViewState();
}

class _MapsPageViewState extends State<MapsPageView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: Container(
                    margin: EdgeInsets.only(top: 35, left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.map_rounded, color: primaryColor),
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
            ))
      ],
    );
  }
}
