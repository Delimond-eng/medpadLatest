import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/widgets/prescription_card.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/d_button_widget.dart';
import 'package:medpad/widgets/modal_input_widget.dart';

class PatientPremierSoinPage extends StatefulWidget {
  @override
  _PatientPremierSoinPageState createState() => _PatientPremierSoinPageState();
}

class _PatientPremierSoinPageState extends State<PatientPremierSoinPage> {
  final textTraitement = TextEditingController();
  final textDosage = TextEditingController();

  List<Soins> soinsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/medpadUI1.png"),
              fit: BoxFit.scaleDown),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(.9)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: Container(
                      margin: EdgeInsets.only(top: 35, left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.medical_services,
                              color: primaryColor),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Premiers soins",
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
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.blue[800], width: 1))),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: ModalInputText(
                                    icon: Icons.medical_services,
                                    hintText: "traitement...",
                                    controller: textTraitement,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Flexible(
                                    child: ModalInputText(
                                  icon: Icons.medical_services,
                                  hintText: "dosage ex.2x4",
                                  controller: textDosage,
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // ignore: deprecated_member_use
                            Row(
                              children: [
                                Flexible(
                                  child: Dbutton(
                                    icon: Icons.add,
                                    label: "Enregistrer",
                                    height: 55.0,
                                    press: submitted,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                SizedBox(width: 10.0,),
                                Flexible(
                                  child: Dbutton(
                                    icon: Icons.clear,
                                    label: "Fermer",
                                    height: 55.0,
                                    color: Colors.grey[800],
                                    press: (){
                                      Navigator.pop(context);
                                    },
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                )
                              ],

                            )

                          ],
                        ),
                      ),
                      if (soinsList.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(8.0),
                          child: Text(
                            "Premiers soins effectués...",
                            style: GoogleFonts.mulish(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .5,
                                color: Colors.blue[900]),
                          ),
                        ),
                      if (soinsList.isNotEmpty)
                        GridView.builder(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 2.20),
                          itemCount: soinsList.length,
                          itemBuilder: (context, index) {
                            return PrescriptionCard(
                              dosage: soinsList[index].dosage,
                              prescription: soinsList[index].traitement,
                              color: Colors.blue[800],
                            );
                          },
                        )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitted() async {
    if (textTraitement.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          color: bgColor,
          message: "vous devez entrer le traitement !");
      return;
    }

    if (textDosage.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          color: bgColor,
          message: "vous devez entrer le dosage !");
      return;
    }
    Xloading.showLottieLoading(context);
    try {
      await ApiManagerService.premiersoins(
              traitement: textTraitement.text, dosage: textDosage.text)
          .then((result) {
        Xloading.dismiss();
        if (result == "success") {
          XDialog.showSuccessAnimation(context);
          setState(() {
            Soins s = Soins(
                textTraitement.text,
                textDosage.text
            );
            soinsList.add(s);
          });
          textTraitement.text = "";
          textDosage.text = "";
        } else {
          XDialog.showErrorMessage(context,
              title: "Echec",
              message: "Echec de transmission des données au serveur !");
          return;
        }
      });
    } catch (err) {
      print(err);
      Xloading.dismiss();
      XDialog.showErrorMessage(context,
          title: "Erreur",
          message:
              "Une erreur est servenue lors de l'envoi des données au serveur !");
    }
  }
}

class Soins{
  String traitement;
  String dosage;
  Soins(this.traitement, this.dosage);
}
