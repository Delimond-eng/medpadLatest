import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsive.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/pages/patient/widgets/action_grid_widget.dart';

class PatientManagerPageView extends StatefulWidget {
  @override
  _PatientManagerPageViewState createState() => _PatientManagerPageViewState();
}

class _PatientManagerPageViewState extends State<PatientManagerPageView> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image3.webp"), fit: BoxFit.fill),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white30],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
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
                                Icon(CupertinoIcons.group_solid,
                                    color: primaryColor),
                                SizedBox(
                                  width: 10,
                                ),
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
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Responsive(
                        desktop: ActionGridWidget(),
                        tablet: ActionGridWidget(),
                        mobile: ActionGridWidget(
                          crossAxisAccount: _width < 650 ? 2 : 4,
                          childAspectRatio: _width < 650 ? 1.3 : 1,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
