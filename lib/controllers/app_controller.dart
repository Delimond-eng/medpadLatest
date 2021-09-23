import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/models/patient_doc_model.dart';
import 'package:medpad/pages/patient/pages/patient_register_page.dart';
import 'package:medpad/pages/patient/pages/patient_tab_page.dart';
import 'package:medpad/routing/routes.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/models/hospitalisations_model.dart';
import 'package:medpad/services/cryptage_service.dart';
import 'package:medpad/services/native_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();

  // ignore: deprecated_member_use
  var singlePatientDocList = List<String>().obs;

  // ignore: deprecated_member_use
  var consultationList = List<Consultations>().obs;
  // ignore: deprecated_member_use
  var signeVitauxList = List<SignesVitaux>().obs;
  // ignore: deprecated_member_use
  var histoireMaladieList = List<HistoireMaladie>().obs;
  // ignore: deprecated_member_use
  var examensPhysiqueList = List<ExamensPhysique>().obs;
  // ignore: deprecated_member_use
  var examensLaboList = List<ExamensLaboratoire>().obs;
  // ignore: deprecated_member_use
  var prescriptionsList = List<Prescriptions>().obs;
  // ignore: deprecated_member_use
  var hospitalisationsList = List<Hospitalisations>().obs;
  // ignore: deprecated_member_use
  var patientIdentityList = List<String>().obs;

  // ignore: deprecated_member_use
  var patientAntecedentsList = List<Antecedents>().obs;

  // ignore: deprecated_member_use
  var premiersoinsList = List<PremierSoins>().obs;
  // Hospitalisations return data
  // ignore: deprecated_member_use
  var hospitalisationSignesVitauxList = List<HospitalisationSignesVitaux>().obs;
  // ignore: deprecated_member_use
  var hospitalisationTraitementsList = List<HospitalisationTraitements>().obs;
  // ignore: deprecated_member_use
  var hospitalisationprescriptionsList =
      List<HospitalisationPrescriptions>().obs;
  // ignore: deprecated_member_use
  var hospitalisationObservationsList = List<HospitalisationObservations>().obs;
  // ignore: deprecated_member_use
  var hospitalisationActesList = List<HospitalisationActes>().obs;

  var strPlainte = "".obs;
  var strDateDoc = "".obs;
  var medAuthorizationAllowed = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  Future<void> loadDatas() async {
    try {
      await ApiManagerService.hospitalisationsView().then((result) {
        if (result.hospitalisations.isNotEmpty) {
          hospitalisationsList.value = result.hospitalisations;
        } else {
          hospitalisationsList.value = [];
        }
      });
    } catch (err) {
      print("error");
    }
  }

  Future<void> openUsbDevice() async {
    try {
      await NativeService.platform.invokeMethod("open_usb_device");
    } catch (err) {
      print(err);
    }
  }

  Future<void> closeUsbDevice() async {
    try {
      await NativeService.platform.invokeMethod("close_usb_device");
    } catch (err) {
      print(err);
    }
  }

  var btnController = RoundedLoadingButtonController().obs;
  var isActive = false.obs;
  var isFounded = false.obs;

  Future<dynamic> showScan(BuildContext context, {Function onSuccess}) async {
    isActive.value = false;
    isFounded.value = false;
    openUsbDevice();
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black45,
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(top: 50.0),
            child: Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: Obx(() => Container(
                      width: 300,
                      child: Stack(children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 80, left: 10, right: 10, bottom: 10),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Stack(
                                        // ignore: deprecated_member_use
                                        overflow: Overflow.visible,
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.zero,
                                            ),
                                            child: Center(
                                              child: (isActive.value == true)
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Lottie.asset(
                                                        "assets/lotties/4771-finger-print.json",
                                                        width: 150.0,
                                                        height: 150.0,
                                                        fit: BoxFit.cover,
                                                        animate: true,
                                                      ),
                                                    )
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Lottie.asset(
                                                          "assets/lotties/4771-finger-print.json",
                                                          width: 150.0,
                                                          height: 150.0,
                                                          reverse: true,
                                                          fit: BoxFit.cover,
                                                          animate: true),
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -30,
                                            right: 0,
                                            left: 0,
                                            child: Container(
                                              height: 70.0,
                                              width: 70.0,
                                              padding: EdgeInsets.all(15.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue[800],
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black87
                                                            .withOpacity(.4),
                                                        blurRadius: 10.0,
                                                        offset: Offset(0, 5))
                                                  ]),
                                              child: SvgPicture.asset(
                                                "assets/svg/scan02.svg",
                                                color: Colors.white,
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                          )
                                        ]),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 200.0,
                                      height: 50,
                                      child: RoundedLoadingButton(
                                          loaderSize: 25.0,
                                          loaderStrokeWidth: 2,
                                          onPressed: () async {
                                            String value = "";
                                            isActive.value = true;
                                            try {
                                              String jsonArrFingers =
                                                  jsonEncode(
                                                      apiController.fingerList);
                                              value = await NativeService
                                                  .platform
                                                  .invokeMethod("match_fingers",
                                                      jsonArrFingers);
                                            } catch (err) {
                                              print(err);
                                            }
                                            if (menuController
                                                    .activeItem.value ==
                                                StrScanning) {
                                              if (value != "0") {
                                                try {
                                                  await ApiManagerService
                                                          .getPatientDoc(
                                                              fingerId: value)
                                                      .then((result) {
                                                    Get.back();
                                                    XDialog.showSuccessAnimation(
                                                        context);
                                                    var patient =
                                                        result.patient;
                                                    String patientName =
                                                        GxdCryptor.decrypt(
                                                            patient.nom);
                                                    String
                                                        patientDateNaissance =
                                                        GxdCryptor.decrypt(
                                                            patient
                                                                .dateNaissance);
                                                    String patientProfession =
                                                        GxdCryptor.decrypt(
                                                            patient.profession);
                                                    String patientTelephone =
                                                        GxdCryptor.decrypt(
                                                            patient.telephone);
                                                    btnController.value
                                                        .success();

                                                    List<String>
                                                        patientIdentityList = [
                                                      patientName,
                                                      patientDateNaissance,
                                                      patientProfession,
                                                      patient.sexe,
                                                      patientTelephone
                                                    ];

                                                    singlePatientDocList.value =
                                                        patientIdentityList;
                                                    consultationList.value =
                                                        patient.consultations;
                                                    patientAntecedentsList
                                                            .value =
                                                        patient.antecedents;
                                                    premiersoinsList.value =
                                                        patient.premierSoins;
                                                    menuController
                                                            .activeItem.value =
                                                        "Dossier médical";
                                                    storage.write("patient_id",
                                                        patient.patientId);

                                                    navigationController
                                                        .rootingTo(
                                                            PatientTabPage());
                                                    apiController.loadFingers(
                                                        type: "medecin");
                                                    isActive.value = false;
                                                    isFounded.value = true;
                                                    closeUsbDevice();
                                                  });
                                                } catch (err) {
                                                  XDialog.showErrorMessage(
                                                      context,
                                                      title: "Error",
                                                      message:
                                                          "Error from scan");
                                                  btnController.value.stop();
                                                  isActive.value = false;
                                                  isFounded.value = false;
                                                }
                                              } else {
                                                btnController.value.stop();
                                                isActive.value = false;
                                                isFounded.value = false;
                                                XDialog.show(
                                                    context: context,
                                                    title: "Echec du scan",
                                                    icon: Icons.info,
                                                    content:
                                                        "L'empreinte du patient scannée est introuvable,\nVoulez-vous enroller ce patient ?",
                                                    onValidate: () async {
                                                      menuController.activeItem
                                                              .value =
                                                          "Enregistrement patient";
                                                      navigationController
                                                          .rootingTo(
                                                              PatientRegister());
                                                      Get.back();
                                                      btnController.value
                                                          .stop();
                                                    },
                                                    onCancel: () {
                                                      Get.back();
                                                      btnController.value
                                                          .stop();
                                                    });
                                              }
                                            } else {
                                              if (value != "0") {
                                                btnController.value.success();
                                                closeUsbDevice();
                                                storage.write(
                                                    "medecin_id", value);
                                                Future.delayed(Duration(
                                                    milliseconds: 200));
                                                Get.back();
                                                onSuccess();
                                                closeUsbDevice();
                                              } else {
                                                btnController.value.stop();
                                                XDialog.showErrorMessage(
                                                    context,
                                                    title: "Accès interdit!",
                                                    message:
                                                        "Vous n'avez aucun accès !");
                                              }
                                            }
                                          },
                                          elevation: 10,
                                          color: isFounded.value == true
                                              ? Colors.green[700]
                                              : Colors.blue[800],
                                          curve: Curves.easeIn,
                                          controller: btnController.value,
                                          child: Text(
                                              "scanner empreinte".toUpperCase(),
                                              style: GoogleFonts.mulish(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  letterSpacing: 1.0,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: bgColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/fingerprint1.svg",
                                          width: 35.0,
                                          height: 35.0,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          (menuController.activeItem.value == StrScanning) ? "PATIENT SCAN" : "MEDECIN SCAN",
                                          style: GoogleFonts.mulish(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.clear_circled_solid,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                      menuController.activeItem.value = "";
                                      isActive.value = false;
                                      isFounded.value = false;
                                      closeUsbDevice();
                                    },
                                  )
                                ],
                              ),
                            ))
                      ]),
                    ))),
          );
        });
  }
}
