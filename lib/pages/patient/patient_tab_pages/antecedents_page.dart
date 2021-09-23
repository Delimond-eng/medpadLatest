import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/pages/patient/patient_tab_pages/widgets/antecedent_widget.dart';
import 'package:pdf/widgets.dart' as pw;

class AntecedentsPage extends StatefulWidget {
  const AntecedentsPage({Key key}) : super(key: key);
  @override
  _AntecedentsPageState createState() => _AntecedentsPageState();
}

class _AntecedentsPageState extends State<AntecedentsPage> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: (appController.patientAntecedentsList.isEmpty)
              ? Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Column(
                    children: [
                      Lottie.asset(
                        "assets/lotties/16656-empty-state.json",
                        alignment: Alignment.center,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        animate: true,
                      ),
                      Text(
                        "Aucun antécédent!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: appController.patientAntecedentsList.length,
                  itemBuilder: (context, index) {
                    var list = appController.patientAntecedentsList[index];
                    return AntCard(
                      antTitle: list.antecedentType,
                      antQuestion: list.question,
                      antReponse: list.reponse,
                      color: primaryColor,
                    );
                  }),
        ));
  }
}
