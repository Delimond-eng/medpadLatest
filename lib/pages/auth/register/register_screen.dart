import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/auth_input_text_widget.dart';

class RegisterScreen extends StatefulWidget {
  final Function onSuccess;
  RegisterScreen({Key key, this.onSuccess}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final textNom = TextEditingController();

  final textEmail = TextEditingController();

  final textPhone = TextEditingController();

  final textProvince = TextEditingController();

  final textVille = TextEditingController();

  final textAdresse = TextEditingController();

  final textPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              AuthInputText(
                inputController: textNom,
                hintText: "Entrez le nom de votre hôpital",
                icon: Icons.assignment_ind,
                keyType: TextInputType.emailAddress,
                isPassWord: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              AuthInputText(
                inputController: textEmail,
                hintText: "Entrez l'adresse mail de votre hôpital",
                keyType: TextInputType.emailAddress,
                icon: Icons.mail,
                isPassWord: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              AuthInputText(
                inputController: textPhone,
                hintText: "Entrez le n° de téléphone de votre hôpital",
                keyType: TextInputType.phone,
                icon: Icons.phone_sharp,
                isPassWord: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: AuthInputText(
                      inputController: textProvince,
                      hintText: "Province",
                      keyType: TextInputType.text,
                      icon: Icons.account_balance_outlined,
                      isPassWord: false,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: AuthInputText(
                      inputController: textVille,
                      hintText: "Ville",
                      keyType: TextInputType.text,
                      icon: Icons.location_city,
                      isPassWord: false,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              AuthInputText(
                inputController: textAdresse,
                hintText: "Entrez l'adresse de votre hopital",
                keyType: TextInputType.text,
                icon: Icons.location_on,
                isPassWord: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              AuthInputText(
                inputController: textPwd,
                hintText: "Entrez le mot de passe",
                keyType: TextInputType.text,
                isPassWord: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                // ignore: deprecated_member_use
                child: FlatButton(
                  color: primaryColor,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: register,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> register() async {
    List<String> fieldList = [
      textNom.text,
      textEmail.text,
      textAdresse.text,
      textProvince.text,
      textPwd.text,
      textVille.text,
      textPhone.text
    ];

    for (int i = 0; i < fieldList.length; i++) {
      if (fieldList[i].isEmpty) {
        Get.snackbar("", "",
            icon: Icon(
              Icons.error_outline_outlined,
              color: Colors.redAccent[100],
              size: 35,
            ),
            backgroundColor: bgColor,
            maxWidth: 500,
            titleText: Text(
              "Avertissement !",
              style: GoogleFonts.mulish(
                color: Colors.redAccent[100],
                fontWeight: FontWeight.w800,
              ),
            ),
            messageText: Text(
              "vous devez entrer toutes les informations réquises !",
              style: GoogleFonts.mulish(
                color: Colors.redAccent[100],
                fontWeight: FontWeight.w400,
              ),
            ),
            borderRadius: 5,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }
    Xloading.showLottieLoading(context);
    try {
      ApiManagerService.createHospitalAccount(
              adresse: textAdresse.text,
              email: textEmail.text,
              nom: textNom.text,
              province: textProvince.text,
              pwd: textPwd.text,
              ville: textVille.text,
              tel: textPhone.text)
          .then((res) {
        print(res);
        Xloading.dismiss();
        if (res != null) {
          XDialog.showSuccessMessage(context,
              title: "Felicitation !",
              message:
                  "Votre souscription a été effectuée avec succès,\n Veuillez vous connecter à votre compte à présent ");
          widget.onSuccess();
        } else {
          XDialog.showErrorMessage(context,
              title: "Echec !",
              message:
                  "Un problème est survenu lors de la souscription, \n Veuillez réessayer svp !");
          widget.onSuccess();
        }
      });
    } catch (err) {
      print(err);
      Get.back();
      XDialog.showErrorMessage(context,
          title: "Echec !",
          message:
              "Une erreur est survenue lors de l'envoi des données dans le serveur,\nVeuillez réessayer ultérieurement !");
      widget.onSuccess();
    }
  }
}
