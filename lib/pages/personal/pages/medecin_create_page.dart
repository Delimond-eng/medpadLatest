import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/widgets/fingerprint_control.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/services/native_service.dart';
import 'package:medpad/widgets/d_button_widget.dart';
import 'package:medpad/widgets/input_text_grey.dart';
import 'package:medpad/widgets/subPageHeader.dart';

class MedecinCreatePage extends StatefulWidget {
  MedecinCreatePage({Key key}) : super(key: key);

  @override
  _MedecinCreatePageState createState() => _MedecinCreatePageState();
}

class _MedecinCreatePageState extends State<MedecinCreatePage> {
  String sexe = "";
  bool isMale = false, isFemale = false;
  final textNom = TextEditingController();
  final textDateNais = TextEditingController();
  final textEmail = TextEditingController();
  final textVille = TextEditingController();
  final textProvince = TextEditingController();
  final textAdresse = TextEditingController();
  final textPhone = TextEditingController();
  final textSpecialite = TextEditingController();

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    //var _size = MediaQuery.of(context).size;
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 20,
                    bottom: 10),
                child: SubPageHeader(
                    icon: CupertinoIcons.person_crop_circle_fill_badge_plus),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        appController.closeUsbDevice();
                      },
                      icon: Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.blue[900],
                      )),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 40, right: 40, top: 0),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      InputText(
                        title: "Nom",
                        inputController: textNom,
                        icon: Icons.assignment_ind_rounded,
                        hintText: "Entrez le nom du patient",
                        keyType: TextInputType.text,
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sexe",
                                    style: TextStyle(
                                      color: bgColor,
                                      fontWeight: FontWeight.w400,
                                    ),
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
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: isMale,
                                      onChanged: (value) {
                                        setState(() {
                                          isMale = value;
                                          sexe = isMale ? "M" : "";
                                          isFemale = false;
                                        });
                                      }),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Masculin"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Checkbox(
                                      value: isFemale,
                                      onChanged: (value) {
                                        setState(() {
                                          isFemale = value;
                                          sexe = isFemale ? "F" : "";
                                          isMale = false;
                                        });
                                      }),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Féminin"),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: InputText(
                              inputController: textDateNais,
                              icon: Icons.calendar_today_outlined,
                              keyType: TextInputType.datetime,
                              title: "Date de naissance ",
                              isRequired: true,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: InputText(
                                title: "Spécialité",
                                hintText: "Entrez la spécialité du médecin",
                                inputController: textSpecialite,
                                icon: CupertinoIcons.person_crop_square,
                                keyType: TextInputType.text,
                                isRequired: true),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: InputText(
                              title: "Téléphone",
                              hintText:
                                  "Entrez le n° de téléphone du médecin (+243) xxx xxx xxx",
                              icon: Icons.contact_phone_rounded,
                              inputController: textPhone,
                              keyType: TextInputType.phone,
                              isRequired: true,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Flexible(
                            child: InputText(
                                title: "Email",
                                hintText: "Entrez l'adresse mail du médecin",
                                icon: Icons.mail_rounded,
                                inputController: textEmail,
                                keyType: TextInputType.text,
                                isRequired: true),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputText(
                        inputController: textAdresse,
                        title: "Adresse",
                        hintText: "Entrez l'adresse du médecin",
                        icon: Icons.location_on,
                        keyType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: InputText(
                                title: "Ville / District",
                                inputController: textVille,
                                hintText: "Entrez ville/district",
                                icon: Icons.location_city_rounded,
                                keyType: TextInputType.text,
                                isRequired: true),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Flexible(
                            child: InputText(
                                title: "Province",
                                hintText: "Entrez la province ",
                                inputController: textProvince,
                                icon: Icons.account_balance_outlined,
                                keyType: TextInputType.text,
                                isRequired: true),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Dbutton(
                                press: () {
                                  showEnrollModal();
                                },
                                label: "Enroller empreintes",
                                height: 70.0,
                                icon: Icons.fingerprint,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Flexible(
                              child: Dbutton(
                                press: doctorRegister,
                                label: "Enregistrer",
                                height: 70.0,
                                icon: Icons.add,
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void cleanField() {
    textNom.text = "";
    textEmail.text = "";
    textAdresse.text = "";
    textDateNais.text = "";
    textPhone.text = "";
    textVille.text = "";
    textPhone.text = "";
    textSpecialite.text = "";
    textProvince.text = "";
    sexe = "";
    cleanFingerData();
  }

  void doctorRegister() async {
    List<String> fieldArr = [
      textNom.text,
      textEmail.text,
      textAdresse.text,
      textDateNais.text,
      textPhone.text,
      textVille.text,
      textPhone.text,
      textSpecialite.text,
      textProvince.text,
      sexe
    ];

    for (int i = 0; i < fieldArr.length; i++) {
      if (fieldArr[i].isEmpty) {
        XDialog.showErrorMessage(context,
            title: "Avertissement!",
            message:
                "vous devez renseigner tous les champs requis, \n pour effectuer cette opération !");
        return;
      }
    }

    if (strB64Image1.isEmpty || strB64Image2.isEmpty || strB64Image3.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Enrollement obligatoire",
          message: "vous devez enroller les empreintes du Médecin",
          color: bgColor);
      Future.delayed(Duration(milliseconds: 500));
      showEnrollModal();
      return;
    }

    try {
      Xloading.show(context, "Traitement en cours...");
      await ApiManagerService.doctorRegister(
              nom: textNom.text,
              email: textEmail.text,
              nais: textDateNais.text,
              adresse: textAdresse.text,
              province: textProvince.text,
              sexe: sexe,
              specialite: textSpecialite.text,
              tel: textPhone.text,
              ville: textVille.text,
              empreinte1: finger01,
              empreinte2: finger02,
              empreinte3: finger03)
          .then((res) {
        Xloading.dismiss();
        if (res != null) {
          XDialog.showSuccessMessage(context,
              title: "Succès !",
              message: "Cette opération a été effectuée avec succès");
          cleanField();
        } else {
          XDialog.showSuccessMessage(context,
              title: "Echec !",
              message:
                  "Une erreur est survenue lors de la création du médecin, \n veuillez réessayer plus tard svp !");
        }
      });
    } catch (error) {
      print("error : $error");
      Get.back();
      XDialog.showSuccessMessage(context,
          title: "Echec !",
          message:
              "Une erreur est survenue lors de l'envoi des données dans le serveur, \n veuillez réessayer plus tard svp !");
    }
  }

  bool isFingerOne = false;
  bool isFingerTwo = false;
  bool isFingerThree = false;

  bool isLoading1 = false;
  bool isLoading2 = false;
  bool isLoading3 = false;

  String strB64Image1 = "";
  String strB64Image2 = "";
  String strB64Image3 = "";

  String finger01 = "";
  String finger02 = "";
  String finger03 = "";

  Uint8List byteData;

  void cleanFingerData() {
    setState(() {
      isFingerOne = false;
      isFingerTwo = false;
      isFingerThree = false;

      isLoading1 = false;
      isLoading2 = false;
      isLoading3 = false;

      strB64Image1 = "";
      strB64Image2 = "";
      strB64Image3 = "";

      finger01 = "";
      finger02 = "";
      finger03 = "";
    });
  }

  void showEnrollModal() {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.white12,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Dialog(
                child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 80, left: 20, right: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 30.0,
                                  crossAxisSpacing: 30.0,
                                  childAspectRatio: 0.90),
                          children: [
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return FingerPrintControl(
                                isActive: isFingerOne,
                                isLoading: isLoading1,
                                strImage: strB64Image1,
                                onPressed: () async {
                                  setState(() {
                                    isLoading1 = !isLoading1;
                                    isFingerOne = false;
                                    finger01 = "";
                                  });
                                  try {
                                    if (isLoading1 == true) {
                                      List<dynamic> list = <dynamic>[];

                                      list = await NativeService.platform
                                          .invokeMethod("get_image");

                                      Uint8List data =
                                          Uint8List.fromList(list[0]);
                                      String strByte =
                                          convertToBase64Bytes(list[1]);
                                      String strB64 =
                                          convertToBase64Bytes(data);
                                      if (strB64 != null || strB64.isNotEmpty) {
                                        setState(() {
                                          isLoading1 = false;
                                          isFingerOne = true;
                                          strB64Image1 = strB64;
                                          finger01 = strByte;

                                          byteData = list[1];
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        isLoading1 = true;
                                        isFingerOne = false;
                                        strB64Image1 = "";
                                        finger01 = "";
                                      });

                                      if (isLoading1 == true) {
                                        List<dynamic> list = <dynamic>[];

                                        list = await NativeService.platform
                                            .invokeMethod("get_image");

                                        Uint8List data =
                                            Uint8List.fromList(list[0]);

                                        String strByte =
                                            convertToBase64Bytes(list[1]);

                                        String strB64 =
                                            convertToBase64Bytes(data);
                                        if (strB64 != null ||
                                            strB64.isNotEmpty) {
                                          setState(() {
                                            isLoading1 = false;
                                            isFingerOne = true;
                                            strB64Image1 = strB64;
                                            finger01 = strByte;
                                            byteData = list[1];
                                          });
                                        }
                                      }
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                title: "Empreinte 01",
                              );
                            }),
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return FingerPrintControl(
                                isActive: isFingerTwo,
                                isLoading: isLoading2,
                                strImage: strB64Image2,
                                onPressed: () async {
                                  setState(() {
                                    isLoading2 = !isLoading2;
                                    isFingerTwo = false;
                                    finger02 = "";
                                  });
                                  try {
                                    if (isLoading2 == true) {
                                      List<dynamic> list = <dynamic>[];
                                      list = await NativeService.platform
                                          .invokeMethod("get_image");
                                      Uint8List data =
                                          Uint8List.fromList(list[0]);
                                      String strByte =
                                          convertToBase64Bytes(list[1]);
                                      String strB64 =
                                          convertToBase64Bytes(data);
                                      if (strB64 != null || strB64.isNotEmpty) {
                                        setState(() {
                                          isLoading2 = false;
                                          isFingerTwo = true;
                                          strB64Image2 = strB64;
                                          finger02 = strByte;
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        isLoading2 = true;
                                        isFingerTwo = false;
                                        strB64Image2 = "";
                                        finger02 = "";
                                      });

                                      if (isLoading2 == true) {
                                        List<dynamic> list = <dynamic>[];
                                        list = await NativeService.platform
                                            .invokeMethod("get_image");
                                        Uint8List data =
                                            Uint8List.fromList(list[0]);
                                        String strByte =
                                            convertToBase64Bytes(list[1]);
                                        String strB64 =
                                            convertToBase64Bytes(data);
                                        if (strB64 != null ||
                                            strB64.isNotEmpty) {
                                          setState(() {
                                            isLoading2 = false;
                                            isFingerTwo = true;
                                            strB64Image2 = strB64;
                                            finger02 = strByte;
                                          });
                                        }
                                      }
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                title: "Empreinte 02",
                              );
                            }),
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return FingerPrintControl(
                                isActive: isFingerThree,
                                isLoading: isLoading3,
                                strImage: strB64Image3,
                                onPressed: () async {
                                  setState(() {
                                    isLoading3 = !isLoading3;
                                    isFingerThree = false;
                                    finger03 = "";
                                  });
                                  try {
                                    if (isLoading3 == true) {
                                      List<dynamic> list = <dynamic>[];

                                      list = await NativeService.platform
                                          .invokeMethod("get_image");

                                      Uint8List data =
                                          Uint8List.fromList(list[0]);

                                      String strByte =
                                          convertToBase64Bytes(list[1]);

                                      String strB64 =
                                          convertToBase64Bytes(data);
                                      if (strB64 != null || strB64.isNotEmpty) {
                                        setState(() {
                                          isLoading3 = false;
                                          isFingerThree = true;
                                          strB64Image3 = strB64;
                                          finger03 = strByte;
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        isLoading3 = true;
                                        isFingerThree = false;
                                        strB64Image3 = "";
                                        finger03 = "";
                                      });

                                      if (isLoading3 == true) {
                                        List<dynamic> list = <dynamic>[];

                                        list = await NativeService.platform
                                            .invokeMethod("get_image");

                                        Uint8List data =
                                            Uint8List.fromList(list[0]);

                                        String strByte =
                                            convertToBase64Bytes(list[1]);

                                        String strB64 =
                                            convertToBase64Bytes(data);
                                        if (strB64 != null ||
                                            strB64.isNotEmpty) {
                                          setState(() {
                                            isLoading3 = false;
                                            isFingerThree = true;
                                            strB64Image3 = strB64;
                                            finger03 = strByte;
                                          });
                                        }
                                      }
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                title: "Empreinte 03",
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Dbutton(
                            press: () async {
                              Get.back();
                            },
                            label: "Valider".toUpperCase(),
                            icon: Icons.check,
                            height: 70.0,
                            width: MediaQuery.of(context).size.width,
                          ),
                        )
                      ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                "Enrollement des empreintes de patient",
                                style: GoogleFonts.mulish(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              cleanFingerData();
                              Get.back();
                            },
                          )
                        ],
                      ),
                    ))
              ]),
            )),
          );
        });
  }
}
