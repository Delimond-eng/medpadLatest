import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/pages/hospital/pages/config_lit_page.dart';
import 'package:medpad/pages/hospital/widgets/h_menu_card.dart';
import 'package:medpad/pages/patient/pages/patient_consultations_page.dart';
import 'package:medpad/widgets/action_card_widget.dart';

class HospitalManagerPageView extends StatefulWidget {
  HospitalManagerPageView({Key key}) : super(key: key);

  @override
  _HospitalManagerPageViewState createState() =>
      _HospitalManagerPageViewState();
}

class _HospitalManagerPageViewState extends State<HospitalManagerPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image3.webp"), fit: BoxFit.fill),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(.9)),
          child: Container(
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
                                Icon(Icons.local_hospital_rounded,
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
                    child: Container(
                        child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 40.0, right: 20, left: 20),
                  crossAxisCount: 4,
                  crossAxisSpacing: 40.0,
                  childAspectRatio: 1.4,
                  children: [
                    ActionCard(
                      title: "Configuration Lit",
                      icon: CupertinoIcons.bed_double_fill,
                      strIcon: "assets/svg/bed4.svg",
                      navigate: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HLitPage()));
                      },
                      clIndex: 10,
                    ),
                    ActionCard(
                      title: "Autres",
                      icon: CupertinoIcons.circle,
                      navigate: () {

                      },

                      clIndex: 15,
                    ),
                    ActionCard(
                      title: "Other",
                      icon: Icons.circle,
                      navigate: () {},
                      clIndex: 5,
                    ),
                    ActionCard(
                      title: "Other",
                      icon: CupertinoIcons.circle,
                      navigate: () {},
                    ),
                  ],
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
