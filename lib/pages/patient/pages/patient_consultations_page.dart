import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/pages/consultations_phase_screen/consult_antecedent_page.dart';
import 'package:medpad/pages/patient/pages/consultations_phase_screen/consult_examen_page.dart';
import 'package:medpad/pages/patient/pages/consultations_phase_screen/consult_hospitalisation_page.dart';
import 'package:medpad/pages/patient/pages/consultations_phase_screen/consult_prescription_page.dart';
import 'package:medpad/pages/patient/pages/consultations_phase_screen/consult_signe_vitaux_page.dart';
import 'package:medpad/pages/patient/pages/consultations_phase_screen/examen_labo_page.dart';
import 'package:medpad/pages/patient/pages/consultations_phase_screen/histoire_maladie.dart';
import 'package:medpad/pages/patient/pages/consultations_phase_screen/prise_contact_screen.dart';
import 'package:medpad/pages/patient/widgets/step_progress_widget.dart';
import 'package:medpad/widgets/subPageHeader.dart';

class PatientConsultationsPage extends StatefulWidget {
  PatientConsultationsPage({Key key}) : super(key: key);

  @override
  _PatientConsultationsPageState createState() =>
      _PatientConsultationsPageState();
}

class _PatientConsultationsPageState extends State<PatientConsultationsPage> {
  final _stepsText = [
    "Prise de contact",
    "Signes vitaux",
    "Histoire maladie",
    "Antécédents",
    "Examens physiques",
    "Examens labo",
    "Prescriptions",
    "Mode de traitement"
  ];

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 60.0;

  Color _activeColor = Colors.blue[800];

  Color _inactiveColor = Colors.grey;

  TextStyle _headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  String selectedDropDownValue;

  final PageController pageController = PageController(initialPage: 0);

  int currentPage = 0;
  String currentPageTitle = "Prise de contact";
  int currentSteps = 1;
  int pageNumber = 1;
  double percent = 10.0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int index) {
    setState(() {
      currentPage = index;
      currentSteps = index + 1;
    });
  }

  void goForward() {
    setState(() {
      if (currentPage >= 7) {
        currentPage = 7;
      } else {
        currentPage++;
      }
    });
    pageController.animateToPage(currentPage,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void goBack() {
    setState(() {
      if (currentPage <= 0) {
        currentPage = 0;
      } else {
        currentPage--;
      }
    });
    pageController.animateToPage(currentPage,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List<Widget> pageList = [
      ConsultPriseContactScreen(
        onCreate: goForward,
      ),
      ConsultSigneVitauxScreen(),
      ConsultationHistoireMaladie(),
      ConsultationAntecedents(),
      ConsultationExamensPhysique(),
      ExamenLaboPage(),
      ConsultationPrescription(
        onEnd: () {
          Get.back();
          pageController.animateToPage(0,
              duration: Duration(milliseconds: 100),
              curve: Curves.fastLinearToSlowEaseIn);
        },
      ),
      ConsultationHospitalisationPage()
    ];
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/image3.webp"), fit: BoxFit.fill),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white70],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 20,
                        bottom: 10),
                    child: SubPageHeader(
                      icon: Icons.accessibility,
                    ),
                  )
                ],
              ),
              StepProgressView(
                _stepsText,
                currentSteps,
                _stepProgressViewHeight,
                size.width,
                _stepCircleRadius,
                _activeColor,
                _inactiveColor,
                _headerStyle,
                _stepStyle,
                decoration: BoxDecoration(color: Colors.transparent),
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: PageView(
                controller: pageController,
                onPageChanged: onPageChanged,
                children: pageList,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPage == 0)
                    Container(width: 100)
                  else
                    // ignore: deprecated_member_use
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: primaryColor,
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.arrow_left,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Précèdent",
                              style: GoogleFonts.mulish(color: Colors.white),
                            )
                          ],
                        ),
                        onPressed: goBack),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 0; i < pageList.length; i++)
                              if (i == currentPage)
                                SliderDot(true)
                              else
                                SliderDot(false)
                          ],
                        ),
                      )
                    ],
                  ),
                  if (currentPage == 7)
                    Container(
                      child: FlatButton.icon(
                        color: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          onPressed: () async{
                            Xloading.showLottieLoading(context);
                            await apiController.cleanData();
                            await apiController.loadData();
                            Xloading.dismiss();
                            Navigator.pop(context);
                      }, icon: Icon(Icons.clear, color: Colors.white,), label: Text("Fermer ", style: GoogleFonts.mulish(color: Colors.white),)),
                    )
                  else
                    // ignore: deprecated_member_use
                    RaisedButton(
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Text(
                              "Suivant",
                              style: GoogleFonts.mulish(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              CupertinoIcons.arrow_right,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        onPressed: goForward),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SliderDot extends StatelessWidget {
  bool isActive;
  SliderDot(this.isActive);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.grey[400],
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
