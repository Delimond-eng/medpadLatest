import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/controllers/api_controller.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/d_button_widget.dart';
import 'package:medpad/widgets/input_text_grey.dart';
import 'package:medpad/widgets/subPageHeader.dart';

class InfirmierCreatePage extends StatefulWidget {
  InfirmierCreatePage({Key key}) : super(key: key);

  @override
  _InfirmierCreatePageState createState() => _InfirmierCreatePageState();
}

class _InfirmierCreatePageState extends State<InfirmierCreatePage> {
  String sexe = "";
  bool isMale = false, isFemale = false;
  final textNom = TextEditingController();
  final textDateNais = TextEditingController();
  final textEmail = TextEditingController();
  final textVille = TextEditingController();
  final textAdresse = TextEditingController();
  final textPhone = TextEditingController();
  final textProvince = TextEditingController();

  ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
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
                  icon: CupertinoIcons.person_badge_plus_fill,
                ),
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
                        hintText: "Entrez le nom de l'infirmier",
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
                      InputText(
                        inputController: textDateNais,
                        icon: Icons.calendar_today_outlined,
                        keyType: TextInputType.datetime,
                        title: "Date de naissance ",
                        isRequired: true,
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
                              "Entrez le n° de téléphone de l'infirmier",
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
                                hintText: "Entrez l'adresse mail de l'infirmier",
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
                          hintText: "Entrez l'adresse  de l'infirmier",
                          icon: Icons.location_on,
                          keyType: TextInputType.text,
                          isRequired: true),
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
                                icon: Icons.location_city_outlined,
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
                              icon: Icons.account_balance_outlined,
                              inputController: textProvince,
                              keyType: TextInputType.text,
                              isRequired: true,
                            ),
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
                                press: (){},
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
                                press: infirmerRegister,
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
    textProvince.text = "";
    sexe = "";
  }

  void infirmerRegister() async {
    List<String> fieldArr = [
      textNom.text,
      textEmail.text,
      textAdresse.text,
      textDateNais.text,
      textPhone.text,
      textVille.text,
      textProvince.text,
      textPhone.text,
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

    try {
      Xloading.show(context, "Traitement en cours...");

      await ApiManagerService.infirmerRegister(
              nom: textNom.text,
              email: textEmail.text,
              province: textProvince.text,
              adresse: textAdresse.text,
              nais: textDateNais.text,
              sexe: sexe,
              tel: textPhone.text,
              ville: textVille.text)
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
                  "Une erreur est survenue lors de la création de l'infirmier, \nveuillez réessayer plus tard svp !");
        }
      });
    } catch (err) {
      print("error : $err");
      Get.back();
      XDialog.showErrorMessage(context,
          title: "Echec !",
          message:
              "Une erreur est survenue lors de l'envoi des données dans le serveur, \n veuillez réessayer plus tard svp !");
    }
  }
}
