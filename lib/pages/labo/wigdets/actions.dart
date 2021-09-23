import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/d_button_widget.dart';
import 'package:medpad/widgets/modal_input_widget.dart';

final textSignValue = TextEditingController();
final textExamenNom = TextEditingController();

void configSignesVitaux({BuildContext context}) {
  Modal.show(context,
      height: 250,
      title: "Configuration des signes vitaux",
      modalContent: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),

            Text("Nom du signe vital"),
            SizedBox(
              height: 8,
            ),
            ModalInputText(
              hintText: "Entrez le nom du signe vital",
              icon: Icons.accessibility,
              controller: textSignValue,
            ),

            Expanded(child: Container()),

            // ignore: deprecated_member_use
            FlatButton.icon(
              color: Colors.blue[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              onPressed: ()async {
              
              try {
                if (textSignValue.text.isEmpty) {
                  XDialog.showErrorMessage(context,
                      title: "Desolé!",
                      message:
                      "Vous devez entrer le nom du signe vital, \n pour effectuer cette opération!");
                  return;
                }
                Xloading.show(context, "Traitement en cours...");
                await ApiManagerService.createSigneVitaux(
                    titre: textSignValue.text)
                    .then((res) {
                  Get.back();
                  if (res != null) {
                    XDialog.showSuccessMessage(context,
                        title: "Succès",
                        message: "opération effectuée avec succès !");
                    textSignValue.text = "";
                    apiController.loadData();
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
            }, icon: Icon(Icons.check, color: Colors.white,), label: Text("valider", style: GoogleFonts.mulish(color: Colors.white),))
          ],
        ),
      ));
}

void configExamens({BuildContext context}) {
  Modal.show(context,
      height: 250,
      title: "Configuration des types d'examen médical",
      modalContent: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text("Nom de l'examen"),
            SizedBox(
              height: 8,
            ),
            ModalInputText(
              hintText: "Entrez le nom de l'examen médical",
              icon: Icons.medication_rounded,
              controller: textExamenNom,
            ),
            Expanded(child: Container()),

            FlatButton.icon(
                color: Colors.blue[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                onPressed: ()async {
                  try
                  {
                    if (textExamenNom.text.isEmpty) {
                      XDialog.showErrorMessage(context,
                          title: "Desolé!",
                          message:
                          "Vous devez entrer le nom de l'examen médical, \n pour effectuer cette opération!");
                      return;
                    }
                    Xloading.show(context, "Traitement en cours...");
                    await ApiManagerService.createExamen(
                        examen: textExamenNom.text)
                        .then((res) {
                      Get.back();
                      if (res != null) {
                        XDialog.showSuccessMessage(context,
                            title: "Succès",
                            message: "opération effectuée avec succès !");
                        apiController.loadData();
                        textExamenNom.text = "";
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
                }, icon: Icon(Icons.check, color: Colors.white,), label: Text("valider", style: GoogleFonts.mulish(color: Colors.white),))
          ],
        ),
      ));
}
