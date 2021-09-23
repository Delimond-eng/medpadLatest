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

class ExamenLaboPage extends StatefulWidget {
  ExamenLaboPage({Key key}) : super(key: key);

  @override
  _ExamenLaboPageState createState() => _ExamenLaboPageState();
}

class _ExamenLaboPageState extends State<ExamenLaboPage> {
  bool isSelected;
  List<dynamic> examenIdList = [];
  var status;
  bool isDropped = false;
  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icons.select_all,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Sélectionnez les examens Laboratoire",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          if (isDropped == true)
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white70,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sélectionner examens laboratoires",
                        style: GoogleFonts.mulish(color: Colors.blue[900]),
                      ),
                    ),
                    GridView.builder(
                        itemCount: apiController.examenFicheList.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio:
                                ResponsiveWidget.isCustomScreen(context) ||
                                        ResponsiveWidget.isMediumScreen(context)
                                    ? 3.10
                                    : 3.80),
                        itemBuilder: (BuildContext context, int index) {
                          var list = apiController.examenFicheList[index];
                          return Card(
                            elevation: 2,
                            color: list.isSelected == true
                                ? Colors.blue
                                : Colors.white,
                            child: CheckboxListTile(
                              value: list.isSelected,
                              onChanged: (val) {
                                setState(() {
                                  list.isSelected = val;
                                });

                                if (list.isSelected == true) {
                                  examenIdList.add(list.ficheLaboratoireId);
                                } else {
                                  examenIdList.removeWhere(
                                      (id) => id == list.ficheLaboratoireId);
                                }
                              },
                              title: Text(
                                list.examen.toUpperCase(),
                                style: GoogleFonts.mulish(
                                    color: list.isSelected == true
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              activeColor: primaryColor,
                              checkColor: Colors.white,
                            ),
                          );
                        }),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(bottom: 5, left: 8.0),
                            // ignore: deprecated_member_use
                            child: FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              color: Colors.blue[900],
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Ajouter",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: sendExamens,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(bottom: 5, right: 8.0),
                            // ignore: deprecated_member_use
                            child: FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              color: Colors.red[300],
                              icon: Icon(
                                CupertinoIcons.minus,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Reduire",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  isDropped = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Examens laboratoire",
              style: GoogleFonts.mulish(color: Colors.blue[900]),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border(
                      bottom: BorderSide(color: primaryColor.withOpacity(.5)))),
              child: apiController.examenEcoursList.isEmpty
                  ? Center(
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
                            "Aucun examen Laboratoire pour l'instant !",
                            style: GoogleFonts.mulish(
                                color: Colors.black38,
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
                          crossAxisCount: 4,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 3.20),
                      itemCount: apiController.examenEcoursList.length,
                      itemBuilder: (context, index) {
                        var list = apiController.examenEcoursList[index];
                        return Card(
                          elevation: 2,
                          color: Colors
                              .primaries[
                                  Random().nextInt(Colors.primaries.length)]
                              .shade900,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Examen labo",
                                    style: GoogleFonts.mulish(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${list.examen.toUpperCase()}",
                                    style: GoogleFonts.mulish(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
            ),
          )
        ],
      );
    }));
  }

  Future<void> sendExamens() async {
    var consultId = storage.read("consult_id");
    if (examenIdList.length <= 0) {
      XDialog.showErrorMessage(context,
          title: "Avertissement",
          message:
              "vous devez sélectionner les examens,\npour effectuer cette opération");
      return;
    }
    if (consultId.toString() == "" ||
        consultId.toString().isEmpty ||
        consultId == null) {
      XDialog.showErrorMessage(context,
          title: "Désolé !",
          message:
              "vous devez commencer par la prise de contact avec le patient,\npour effectuer cette opération");
      return;
    }

    try {
      Xloading.showLottieLoading(context);
      for (int i = 0; i < examenIdList.length; i++) {
        await ApiManagerService.sendExamenLabo(
                consultId: consultId, ficheLaboId: examenIdList[i])
            .then((result) {
          print(result);
          Xloading.dismiss();
          var statusSuccess = result["reponse"]["status"];
          if (statusSuccess == "success") {
            setState(() {
              status = statusSuccess;
            });
          } else {
            XDialog.showErrorMessage(context,
                title: "Echec",
                message:
                    "Une erreur est survenu lors de l'envoi des données dans le serveur,\nveuillez réessayer ultérieurement");
            return;
          }
        });
      }

      XDialog.showSuccessAnimation(context);
      apiController.loadData();
      apiController.viewExamenEnCours(consultId: consultId);
    } catch (err) {
      print(err);
      Xloading.dismiss();
      XDialog.showErrorMessage(context,
          title: "Echec",
          message:
              "Une erreur est survenu lors de l'envoi des données dans le serveur,\nveuillez réessayer ultérieurement");
      print(err);
    }
  }
}
