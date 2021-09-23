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
import 'package:medpad/models/consultaion_model.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/d_button_widget.dart';
import 'package:medpad/widgets/input_text_grey.dart';
import 'dart:math';

class ConsultSigneVitauxScreen extends StatefulWidget {
  ConsultSigneVitauxScreen({Key key}) : super(key: key);

  @override
  _ConsultSigneVitauxScreenState createState() =>
      _ConsultSigneVitauxScreenState();
}

class _ConsultSigneVitauxScreenState extends State<ConsultSigneVitauxScreen> {
  final textSignValue = TextEditingController();
  String signeVitalId;
  bool isDropped = false;
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
                    "Prélèvement des signes vitaux du patient",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          if (isDropped == true)
            Container(
                width: size.width,
                padding: EdgeInsets.all(20),
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sélectionner le signe vital",
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Obx(() {
                        return Container(
                          height: 50,
                          width: size.width / 2,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.primaries[Random()
                                      .nextInt(
                                      Colors.primaries.length)].shade900,
                                  width: 2.0
                                )
                              )),
                          child: DropdownButton<String>(
                            menuMaxHeight: 300,
                            dropdownColor: Colors.white,
                            value: signeVitalId,
                            underline: SizedBox(),
                            hint: Text(
                              "Sélectionnez le signe vital",
                              style: GoogleFonts.mulish(
                                  color: Colors.grey[400],
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic),
                            ),
                            isExpanded: true,
                            items: apiController.signVitauxList.map((e) {
                              return DropdownMenuItem<String>(
                                  value: e.signeVitalId,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: Colors.primaries[Random()
                                                .nextInt(
                                                Colors.primaries.length)],
                                            shape: BoxShape.circle),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${e.titre.toLowerCase()}",
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                signeVitalId = value;
                                print(signeVitalId);
                              });
                            },
                          ),
                        );
                      }),
                      SizedBox(
                        height: 20.0,
                      ),
                      InputText(
                        icon: Icons.accessibility,
                        hintText: "Entrez la valeur du signe vital",
                        isRequired: true,
                        title: "Valeur du signe vital",
                        keyType: TextInputType.text,
                        inputController: textSignValue,
                      ),
                      SizedBox(
                        height: 20.0,
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
                                onPressed: saveSign,
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Enregistrer",
                                  style: GoogleFonts.mulish(color: Colors.white),
                                )),
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
                                  shape: BoxShape.circle,
                                  color: Colors.black45),
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
                )),
          SizedBox(
            height: 20,
          ),
          Obx(() {
            return Container(
                width: size.width,
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(bottom: 10),
                child: apiController.consultationList.isEmpty
                    ? Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
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
                        "Aucun signe vital prélevé !",
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
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 2.60),
                  itemCount: apiController.consultationList.length,
                  itemBuilder: (context, index) {
                    var list = apiController.consultationList[index];
                    return SignCard(
                      title: list.titre,
                      value: list.signeVitalValeur,
                    );
                  },
                ));
          })
        ],
      ),
    );
  }
  Future<void> saveSign() async{
    var consultId = storage.read("consult_id");
    if (textSignValue.text.isEmpty ||
        signeVitalId == "") {
      XDialog.showErrorMessage(context,
          title: "Avertissement",
          message:
          "vous devez remplir tous les champs requises,\npour effectuer cette opération");
      return;
    }

    if (consultId.toString() == "" ||
        consultId.toString().isEmpty ||
        consultId == null) {
      XDialog.showErrorMessage(context,
          title: "Désolé !",
          message:
          "vous devez commencer par l'enregistrement du patient,\npour effectuer cette opération");
      return;
    }

    try {
      Xloading.showLottieLoading(context);
      await ApiManagerService.consultationSigneVitaux(
          consultationId: "$consultId",
          signeVitalId: signeVitalId,
          signeVitalValue: textSignValue.text)
          .then((res) {
        print(res.reponse.status);
        Xloading.dismiss();
        if (res.reponse.status == "success") {
          XDialog.showSuccessAnimation(context);
          apiController.consultationList.value =
              res.reponse.signesVitaux;
          textSignValue.text = "";
        } else {
          XDialog.showErrorMessage(context,
              title: "Echec",
              color: secondaryColor,
              message:
              "cette consultation a été déjà effectuée !,\nveuillez réessayer une autre !");
          apiController.loadData();
        }
      });
    } catch (err) {
      Xloading.dismiss();
      XDialog.showErrorMessage(context,
          title: "Echec",
          message:
          "Une erreur est survenu lors de l'envoi des données dans le serveur,\nveuillez réessayer ultérieurement");
      print(err);
    }
  }
}

class SignCard extends StatelessWidget {
  final String title;
  final String value;
  const SignCard({
    Key key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        elevation: 2,
        color: Colors.blue[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Signe vital",
                style: GoogleFonts.mulish(
                    color: Colors.yellowAccent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                title.toLowerCase(),
                style: GoogleFonts.mulish(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width),
              SizedBox(
                height: 5,
              ),
              Text(
                "Valeur",
                style: GoogleFonts.mulish(
                    color: Colors.yellowAccent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                value.toLowerCase(),
                style: GoogleFonts.mulish(
                    color: Colors.white, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
