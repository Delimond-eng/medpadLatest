import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/layout.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/auth_input_text_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static const platform = const MethodChannel("com.flutter.medpad");

  final textEmail = TextEditingController();

  final textPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AuthInputText(
              inputController: textEmail,
              hintText: "Entrez votre email",
              icon: Icons.email_outlined,
              keyType: TextInputType.emailAddress,
              isPassWord: false,
            ),
            SizedBox(
              height: 20.0,
            ),
            AuthInputText(
              inputController: textPass,
              hintText: "Entrez votre mot de passe",
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
                  Icons.arrow_right_alt_rounded,
                  color: Colors.white,
                ),
                onPressed: login,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (textEmail.text.isEmpty) {
      Get.snackbar("Avertissement !", "votre adresse email est réquise !",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.redAccent[100],
          backgroundColor: bgColor,
          maxWidth: 500,
          borderRadius: 2);
      return;
    } else if (textPass.text.isEmpty) {
      Get.snackbar("Avertissement", "votre mot de passe est réquis!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.redAccent[100],
          backgroundColor: bgColor,
          maxWidth: 500,
          borderRadius: 2);
      return;
    }

    try {
      Xloading.showLottieLoading(context);
      await ApiManagerService.loginHospital(email: textEmail.text, pwd: textPass.text)
          .then((res) {
        Xloading.dismiss();
        if (res == null) {
          XDialog.showErrorMessage(context,
              title: "Invalide !", message: "Vos identifiants sont erronés!");
        } else {
          ApiManagerService.regDevice();
          Get.offAll(AppLayout());
          apiController.loadData();
        }
      });
    } catch (err) {
      print(err);
      Get.back();
      XDialog.showErrorMessage(context,
          title: "Erreur",
          message:
              "une erreur est survenue lors de la vérification des données dans le serveur!,\nveuillez réessayer ultérieurement!");
    }
  }
}
