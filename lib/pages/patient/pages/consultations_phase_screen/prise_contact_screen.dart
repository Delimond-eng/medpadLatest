import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/services/api_manager_service.dart';

class ConsultPriseContactScreen extends StatefulWidget {
  final Function onCreate;
  ConsultPriseContactScreen({Key key, this.onCreate}) : super(key: key);

  @override
  _ConsultPriseContactScreenState createState() =>
      _ConsultPriseContactScreenState();
}

class _ConsultPriseContactScreenState extends State<ConsultPriseContactScreen> {
  final textNom = TextEditingController();
  final textPlainte = TextEditingController();
  final String currentPatient = storage.read("patient_name") ?? "";
  final String plainte = storage.read("plainte_patient");

  @override
  void initState() {
    super.initState();
    if (plainte.isNotEmpty) {
      textPlainte.text = plainte;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 8),
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (currentPatient.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            shape: BoxShape.circle
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            CupertinoIcons.person,
                            color: Colors.blue[900],
                          ),
                        ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width / 1.17,
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Text(
                          currentPatient.isNotEmpty ? currentPatient : "",
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Plainte *", style: GoogleFonts.mulish(fontSize: 18.0),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: textPlainte.text.isNotEmpty ? Colors.blue[50] : Colors.white,
                        border: Border.all(color: Colors.blue[200], width: 1),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextFormField(
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      readOnly: textPlainte.text.isNotEmpty ? true : false,
                      controller: textPlainte,
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          hintText: "Veuillez saisir la plainte du patient...",
                          hintStyle: GoogleFonts.mulish(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                          contentPadding: EdgeInsets.all(8.0),
                          border: InputBorder.none,
                          fillColor: Colors.blue[50]),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (plainte.isEmpty || plainte == null)
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: FlatButton.icon(
                          color: Colors.blue[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: patientRegister,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Enregistrer",
                            style: GoogleFonts.mulish(color: Colors.white),
                          )),
                    )
                ],
              ))
        ],
      ),
    );
  }

  void cleanFields() {
    textPlainte.text = "";
  }

  void patientRegister() async {
    if (textPlainte.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Avertissement!",
          message:
              "vous devez renseigner tous les champs requis,\npour effectuer cette opération !");
      return;
    }

    try {
      Xloading.showLottieLoading(context);
      var patientId = storage.read("patient_id");

      await ApiManagerService.patientPriseContact(
              plainte: textPlainte.text, patientId: patientId)
          .then((res) {
        Xloading.dismiss();
        if (res != null) {
          var consultId = res["reponse"]["consultation_id"];
          storage.write("consult_id", consultId);
          XDialog.showSuccessAnimation(context);
          cleanFields();
          apiController.loadData();
          widget.onCreate();
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

