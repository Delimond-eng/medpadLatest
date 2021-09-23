import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/pages/patient_consultations_page.dart';
import 'package:medpad/pages/patient/pages/patient_premier_soins_page.dart';
import 'package:medpad/pages/patient/patient_tab_pages/antecedents_page.dart';
import 'package:medpad/pages/patient/patient_tab_pages/consult_docs_page.dart';
import 'package:medpad/pages/patient/patient_tab_pages/home.dart';
import 'package:medpad/pages/patient/patient_tab_pages/premier_soins_view.dart';
import 'package:medpad/pages/patient/patient_tab_pages/tab_consult_page.dart';
import 'package:medpad/pages/patient/widgets/tab_widget.dart';
import 'package:medpad/widgets/nav_card_widget.dart';

class PatientTabPage extends StatefulWidget {
  PatientTabPage({Key key}) : super(key: key);

  @override
  _PatientTabPageState createState() => _PatientTabPageState();
}

class _PatientTabPageState extends State<PatientTabPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      HomeTab(),
      AntecedentsPage(),
      ConsultDocsPage(
        onNavigate: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TabConsultations()));
        },
      ),
      PremierSoinsView()
    ];
    List<Tab> _tabs = [
      Tab(
        icon: Icon(Icons.show_chart_rounded),
        text: "Accueil",
        height: 60.0,
      ),
      Tab(
        icon: Icon(CupertinoIcons.link_circle_fill),
        text: "Antécédents",
        height: 60.0,
      ),
      Tab(
        icon: Icon(CupertinoIcons.doc_person_fill),
        text: "Consultations",
        height: 60.0,
      ),
      Tab(
        icon: Icon(Icons.medical_services_rounded),
        text: "Premiers soins",
        height: 60.0,
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/consult2.jpg"), fit: BoxFit.fill),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white70),
        child: Container(
          child: Column(children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: Container(
                    margin: EdgeInsets.only(top: 35, left: 10),
                    child: Row(
                      children: [
                        Icon(
                            CupertinoIcons
                                .rectangle_stack_fill_badge_person_crop,
                            color: primaryColor),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Dossier médical",
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
            ),
            Expanded(
                child: Container(
                    child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Obx((){
                              return Container(
                                margin:
                                EdgeInsets.only(top: 20, left: 10, right: 10),
                                width: MediaQuery.of(context).size.width / 1.50,
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Fields(
                                        title: "Nom",
                                        value: appController.singlePatientDocList[0].isEmpty ? "xxxxxxxx" : appController.singlePatientDocList[0].toUpperCase(),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Fields(
                                              title: "Date naissance",
                                              value: appController.singlePatientDocList[1].isEmpty ? "xx-xx-xxxx" : appController.singlePatientDocList[1],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Fields(
                                              title: "Sexe",
                                              value: appController.singlePatientDocList[3].isEmpty ? "xx" : appController.singlePatientDocList[3],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Fields(
                                        title: "Profession",
                                        value: appController.singlePatientDocList[2].isEmpty ? "xxxxxxxxxx" : appController.singlePatientDocList[2],
                                      ),
                                      Fields(
                                        title: "Téléphone",
                                        value: appController.singlePatientDocList[4].isEmpty ? "(+243)xxxxxx" : appController.singlePatientDocList[4],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NavCard(
                                    icon: "assets/svg/traitment.svg",
                                    title: "Premiers soins",
                                    pressed: () {
                                      menuController.activeItem.value = "Premiers soins";
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientPremierSoinPage()));
                                    },
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  NavCard(
                                    icon: "assets/svg/consult.svg",
                                    title: "Consultation",
                                    pressed: () {
                                      storage.write("plainte_patient", "");
                                      storage.write("patient_name", appController.singlePatientDocList[0].toString());
                                      appController.showScan(context, onSuccess: (){
                                        menuController.activeItem.value = "Consultation";
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PatientConsultationsPage()));
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: TabBarWidget(
                      childs: _widgets,
                      tabs: _tabs,
                    ))
              ],
            )))
          ]),
        ),
      ),
    );
  }
}

class Fields extends StatelessWidget {
  final String title;
  final String value;
  const Fields({
    Key key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(.1),
          border: Border(
            bottom: BorderSide(
              color: Colors.blue[200],
              width: 2.0
            )
          )
        ),
        height: 50,
        child: Container(
            child: Row(
              children: [
                Container(
                  height: 50.0,
                  width: 125.0,
                  padding: EdgeInsets.only(bottom: 5.0, top: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4,0),
                          color: lightGrey.withOpacity(.3),
                          blurRadius: 12.0
                      )
                    ]
                  ),
                  child: Text(
                    "$title",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
                  alignment: Alignment.center,
                  child: Text(
                    "$value",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.blue[900]),
                  ),
                ),
              ],
            )));
  }
}