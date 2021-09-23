import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/patient_tab_pages/widgets/antecedent_widget.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/input_text_grey.dart';

class ConsultationAntecedents extends StatefulWidget {
  ConsultationAntecedents({Key key}) : super(key: key);

  @override
  _ConsultationAntecedentsState createState() =>
      _ConsultationAntecedentsState();
}

class _ConsultationAntecedentsState extends State<ConsultationAntecedents> {
  var consultId = storage.read("consult_id");
  final textQuestion = TextEditingController();
  final textResponse = TextEditingController();
  String antecedentType;
  bool isDropped = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
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
                      "Consultez les antécédents du patient",
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            if (isDropped == true)
              Container(
                width: size.width,
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  border: Border(
                      bottom: BorderSide(
                          color: primaryColor.withOpacity(.5), width: 1)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 6),
                        color: lightGrey.withOpacity(.1),
                        blurRadius: 12.0)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sélectionner l'Antécédent",
                          style: TextStyle(
                              color: bgColor, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors
                                      .primaries[Random()
                                          .nextInt(Colors.primaries.length)]
                                      .shade900,
                                  width: 2.0))),
                      child: DropdownButton<String>(
                        menuMaxHeight: 300,
                        dropdownColor: Colors.white,
                        value: antecedentType,
                        underline: SizedBox(),
                        hint: Text(
                          "Sélectionnez le type d'antécédents",
                          style: GoogleFonts.mulish(
                              color: Colors.grey[400],
                              fontSize: 14.0,
                              fontStyle: FontStyle.italic),
                        ),
                        isDense: true,
                        items:
                            ["personnel", "familiale", "chirurgical"].map((e) {
                          return DropdownMenuItem<String>(
                              value: e,
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "$e",
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            antecedentType = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 5.0),
                    InputText(
                        hintText: "Entrez une question...",
                        icon: CupertinoIcons.question_circle_fill,
                        inputController: textQuestion,
                        title: "Question",
                        isRequired: true),
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      hintText: "Entrez la reponse...",
                      icon: CupertinoIcons.pencil_ellipsis_rectangle,
                      inputController: textResponse,
                      title: "Reponse",
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: FlatButton.icon(
                              color: Colors.blue[800],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: saveAntecedent,
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
            Obx(() {
              if (apiController.consultAntecedentList.isEmpty)
                return Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 80.0),
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
                );
              else
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: apiController.consultAntecedentList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var list = apiController.consultAntecedentList[index];
                    return AntCard(
                      antTitle: list.antecedentType,
                      antQuestion: list.question,
                      antReponse: list.reponse,
                    );
                  },
                );
            })
          ],
        ),
      ),
    );
  }

  Future<void> saveAntecedent() async {
    if (textQuestion.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          message: "vous devez entrer la question !",
          color: bgColor);
      return;
    }
    if (consultId == null) {
      XDialog.showErrorMessage(context,
          title: "Avertissemrnt !",
          message:
              "vous devez commencer par la prise de contact avec le patient !",
          color: bgColor);
      return;
    }

    if (textResponse.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          message: "vous devez entrer la reponse !",
          color: bgColor);
      return;
    }
    if (antecedentType == null || antecedentType == "") {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          message: "vous devez sélectionner le type d'antécédent !",
          color: bgColor);
      return;
    }
    try {
      print("consult id : $consultId");

      Xloading.showLottieLoading(context);

      ApiManagerService.consultationAntecedents(
              consultId: consultId,
              antecedentType: antecedentType.trim(),
              question: textQuestion.text,
              reponse: textResponse.text)
          .then((result) {
        Xloading.dismiss();
        if (result.reponse.status == "success") {
          XDialog.showSuccessAnimation(context);
          apiController.consultAntecedentList.value =
              result.reponse.antecedents;
          apiController.loadData();
          textQuestion.text = "";
          textResponse.text = "";
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
