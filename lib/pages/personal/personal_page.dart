import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsive.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/pages/personal/pages/infirmier_create_page.dart';
import 'package:medpad/pages/personal/pages/medecin_create_page.dart';
import 'package:medpad/pages/personal/widgets/personal_action_widget.dart';
import 'package:medpad/services/native_service.dart';
import 'package:medpad/widgets/action_card_widget.dart';

class PersonalManagerPageView extends StatefulWidget {
  @override
  _PersonalManagerPageViewState createState() =>
      _PersonalManagerPageViewState();
}

class _PersonalManagerPageViewState extends State<PersonalManagerPageView> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/medpadUI1.png"), fit: BoxFit.scaleDown),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.9)
        ),
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
                              Icon(Icons.people_rounded, color: primaryColor),
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
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 40.0, right: 20, left: 20),
                  crossAxisCount: 4,
                  crossAxisSpacing: 40.0,
                  childAspectRatio: 1.4,
                  children: [
                    ActionCard(
                      title: "Création Médecin",
                      icon: CupertinoIcons.person_badge_plus_fill,
                      navigate: () async{
                        appController.openUsbDevice();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedecinCreatePage()));
                      },
                      clIndex: 4,
                    ),
                    ActionCard(
                      title: "Création infirmier",
                      icon: CupertinoIcons.person_add,
                      navigate: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => InfirmierCreatePage()));
                      },
                      clIndex: 8,
                    ),
                    ActionCard(
                      title: "Assignation patient",
                      icon: Icons.assignment_returned_sharp,
                      navigate: () {},
                      clIndex: 2,
                    ),
                    ActionCard(
                      title: "Création personnel connexes",
                      icon: CupertinoIcons.person_3,
                      navigate: () {},
                      clIndex: 10,
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
