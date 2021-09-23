import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsive.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/labo/pages/examen_en_cour_page.dart';
import 'package:medpad/pages/labo/wigdets/actions.dart';
import 'package:medpad/pages/labo/wigdets/labo_action_card.dart';
import 'package:medpad/pages/patient/pages/patient_premier_soins_page.dart';
import 'package:medpad/widgets/action_card_widget.dart';

class LaboratoryPageView extends StatefulWidget {
  LaboratoryPageView({Key key}) : super(key: key);

  @override
  _LaboratoryPageViewState createState() => _LaboratoryPageViewState();
}

class _LaboratoryPageViewState extends State<LaboratoryPageView> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/medpadUI2.png"), fit: BoxFit.scaleDown),
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
                                Icon(Icons.biotech, color: primaryColor),
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
                  child: GridView.count(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 40.0, right: 20, left: 20),
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 40.0,
                    childAspectRatio: 1.4,
                    children: [
                      ActionCard(
                        title: "Configuration\nsigne vitaux",
                        icon: Icons.accessibility,
                        navigate: () {
                          configSignesVitaux(context: context);
                        },
                        clIndex: 10,
                      ),
                      ActionCard(
                        title: "Configuration types\nexamens médicaux",
                        icon: Icons.biotech_outlined,
                        navigate: () {
                          configExamens(context: context);
                        },
                        clIndex: 4,
                      ),
                      ActionCard(
                        title: "Voir Examens en cours",
                        icon: Icons.biotech_rounded,
                        navigate: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ExamenEnCoursPage()));
                        },
                        clIndex: 14,
                      ),

                      ActionCard(
                        title: "Autres...",
                        icon: Icons.medication_rounded,
                        navigate: () {

                        },
                        clIndex: 8,
                      ),
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
