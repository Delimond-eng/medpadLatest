import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/d_button_widget.dart';
import 'package:medpad/widgets/modal_input_widget.dart';

class ExamenEnCoursPage extends StatefulWidget {
  ExamenEnCoursPage({Key key}) : super(key: key);

  @override
  _ExamenEnCoursPageState createState() => _ExamenEnCoursPageState();
}

class _ExamenEnCoursPageState extends State<ExamenEnCoursPage> {
  final textResult = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/consult.jpg"), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(.9)),
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
                              Icon(
                                CupertinoIcons.lab_flask_solid,
                                color: primaryColor,
                                size: 18.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${menuController.activeItem.value} > Examens en cours...",
                                style: GoogleFonts.mulish(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return Expanded(
                  child: Container(
                    child: apiController.examenEcoursList.isEmpty
                        ? Center(
                            child: Text(
                              "Aucun Examen laboratoire en cours pour l'instant !",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                  color: primaryColor.withOpacity(.3),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1.40),
                            itemCount: apiController.examenEcoursList.length,
                            itemBuilder: (context, index) {
                              var list = apiController.examenEcoursList[index];
                              return ExamenCard(
                                examenName: list.examen,
                                examenResult: list.resultat,
                                pressed: () {
                                  openModalResult(
                                      examenId: list.examenLaboratoireId,
                                      title: list.examen.toUpperCase());
                                },
                              );
                            },
                          ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openModalResult({examenId, title}) async {
    Modal.show(context,
        height: 220,
        title: " Examen -> $title",
        modalContent: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text("Entrer le resultat de l'examen"),
              SizedBox(
                height: 8,
              ),
              ModalInputText(
                hintText: "Entrer le resultat de l'examen !",
                icon: Icons.biotech,
                controller: textResult,
              ),
              Expanded(child: Container()),
              Container(
                // ignore: deprecated_member_use
                child: FlatButton.icon(
                  label: Text("valider", style: GoogleFonts.mulish(color: Colors.white),),
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.blue[800],
                  onPressed: () async {
                    try {
                      if (textResult.text.isEmpty) {
                        XDialog.showErrorMessage(context,
                            title: "Desolé!",
                            message:
                                "Vous devez entrer le resultat de cet examen !");
                        return;
                      }
                      Xloading.show(context, "Traitement en cours...");
                      await ApiManagerService.saveResultExamen(
                              result: textResult.text, examenId: examenId)
                          .then((res) {
                        Get.back();
                        if (res != null) {
                          Get.back();
                          XDialog.showSuccessMessage(context,
                              title: "Succès",
                              message: "opération effectuée avec succès !");
                          apiController.loadData();
                          textResult.text = "";
                        } else {
                          Get.back();
                          XDialog.showErrorMessage(context,
                              title: "Echec",
                              message:
                                  "Echec de l'envoi des données , \n Veuillez réessayer ultérieurement!");
                        }
                      });
                    } catch (err) {
                      print(err);
                      Get.back();
                      XDialog.showErrorMessage(context,
                          title: "Erreur",
                          message:
                              "Une erreur est servenue lors de l'envoi des données, \n Veuillez réessayer ultérieurement!");
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}


class ExamenCard extends StatelessWidget {
  final String examenName;
  final String examenResult;
  final Function pressed;
  const ExamenCard({Key key, this.examenName, this.examenResult, this.pressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
              child: Row(
                children: [
                  Text(
                    "Patient : ",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "ex. patient name",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Examen : ",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    examenName.toUpperCase(),
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            if (examenResult.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Resultat : ",
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      examenResult,
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 8.0,),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(8.0),
              // ignore: deprecated_member_use
              child: FlatButton(
                  color: Colors.blue[50],
                  minWidth: 150.0,
                  onPressed: pressed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(
                    Icons.arrow_right_alt_sharp,
                    color: Colors.blue[800],
                  )),
            )
          ],
        ));
  }
}
