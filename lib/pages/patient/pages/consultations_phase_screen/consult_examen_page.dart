import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/input_text_grey.dart';

class ConsultationExamensPhysique extends StatefulWidget {
  ConsultationExamensPhysique({Key key}) : super(key: key);

  @override
  _ConsultationExamensPhysiqueState createState() =>
      _ConsultationExamensPhysiqueState();
}

class _ConsultationExamensPhysiqueState
    extends State<ConsultationExamensPhysique> {
  final textData = TextEditingController();
  final textValue = TextEditingController();
  bool isDropped = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        children: [
          if (isDropped == false)
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    splashColor: primaryColor.withOpacity(.4),
                    onTap: () {
                      setState(() {
                        isDropped = true;
                      });
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: Center(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Prélevez les examens physiques du patient",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          if (isDropped == true)
            Expanded(
              flex: 7,
              child: Container(
                width: size.width,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Examens physiques", style: GoogleFonts.mulish(color: Colors.blue[900], fontSize: 16.0),),
                    SizedBox(height: 15.0,),
                    InputText(
                        hintText: "Entrez le libellé de l'examen...",
                        icon: Icons.medical_services_rounded,
                        inputController: textData,
                        title: "Examen libellé",
                        isRequired: true),
                    SizedBox(
                      height: 15,
                    ),
                    InputText(
                      hintText: "Entrez la valeur...",
                      icon: Icons.medical_services_outlined,
                      inputController: textValue,
                      title: "Valeur",
                      isRequired: true,
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: FlatButton.icon(
                              color: Colors.blue[800],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: saveExamen,
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Enregistrer",
                                style: GoogleFonts.mulish(color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          splashColor: Colors.grey,
                          onTap: () {
                            setState(() {
                              isDropped = false;
                            });
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black45),
                            child: Center(
                                child: Icon(
                                  CupertinoIcons.chevron_up,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          SizedBox(
            height: 10.0,
          ),
          Obx(() {
            return Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: apiController.consultExamensList.isEmpty
                  ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  children: [
                    Lottie.asset("assets/lotties/16656-empty-state.json",
                      alignment: Alignment.center,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      animate: true,
                    ),
                    Text(
                      "Aucun Examen physique prélevé !",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          color: Colors.black87,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
                  : GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomScreen(context) ? 2.60 : 3),
                itemCount: apiController.consultExamensList.length,
                itemBuilder: (context, index) {
                  var list = apiController.consultExamensList[index];
                  return ExamenCardPhysique(
                    examenTitle: list.donneeLabel,
                    examenValue: list.donneeValeur,
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }

  Future<void> saveExamen() async {
    if (textData.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          message:
          "vous devez entrer le libellé de l'examen !",
          color: bgColor);
      return;
    } else if (textValue.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          message:
          "vous devez entrer la valeur au libellé !",
          color: bgColor);
      return;
    }
    try {
      var consultId = storage.read("consult_id");
      print("consult id : $consultId");

      Xloading.showLottieLoading(context);

      ApiManagerService.consultationExamenPhysique(
          consultationId: consultId,
          dataLabel: textData.text,
          dataValue: textValue.text)
          .then((result) {
        Xloading.dismiss();
        if (result.reponse.status == "success") {
          XDialog.showSuccessAnimation(context);
          print(result.reponse.status);
          apiController.consultExamensList.value =
              result.reponse.examensPhysique;
          apiController.loadData();
          textData.text = "";
          textValue.text = "";
        } else {
          XDialog.showErrorMessage(
            context,
            message:
            "une erreur est survenue lors de l'envoi de données au serveur,\nveuillez réessayer ultérieurement svp!",
            title: "Echec",
          );
        }
      });
    } catch (err) {
      Xloading.dismiss();
      print(err);
      XDialog.showErrorMessage(
        context,
        message:
        "une erreur est survenue lors de l'envoi de données au serveur,\nveuillez réessayer ultérieurement svp!",
        title: "Echec",
      );
    }
  }
}

class ExamenCardPhysique extends StatelessWidget {
  final String examenTitle;
  final String examenValue;
  const ExamenCardPhysique({
    Key key,
    this.examenTitle,
    this.examenValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Libellé examen",
              style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              examenTitle.toLowerCase(),
              style: GoogleFonts.mulish(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width),
            SizedBox(
              height: 5,
            ),
            Text(
              "Valeur",
              style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              examenValue.toLowerCase(),
              style: GoogleFonts.mulish(
                  color: Colors.white, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
