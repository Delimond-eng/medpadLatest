import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/input_text_grey.dart';
import 'package:medpad/widgets/modal_input_widget.dart';

class HLitPage extends StatefulWidget {
  HLitPage({Key key}) : super(key: key);

  @override
  _HLitPageState createState() => _HLitPageState();
}

class _HLitPageState extends State<HLitPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/consult2.jpg"), fit: BoxFit.fill),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(.9)),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top:
                              ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                      child: Container(
                        margin: EdgeInsets.only(top: 35, left: 10),
                        child: Row(
                          children: [
                            Icon(Icons.local_hospital_rounded,
                                color: primaryColor),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Gestion Hôpital : Configuration Lits",
                              style: GoogleFonts.mulish(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 40,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: Colors.blue[900])),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(child: Container(child: Obx(() {
                          if (apiController.hospitalBedsList.isEmpty)
                            return Center(
                              child: Text(
                                  "Aucun Lit dans la liste pour l'instant !"),
                            );
                          else
                            return GridView.builder(
                              padding:
                                  EdgeInsets.only(right: 20, left: 20, top: 5),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 1.50),
                              itemCount: apiController.hospitalBedsList.length,
                              itemBuilder: (context, index) {
                                var list =
                                    apiController.hospitalBedsList[index];
                                return LitCard(
                                  title: list.designation,
                                );
                              },
                            );
                        }))),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          alignment: Alignment.bottomRight,
                          // ignore: deprecated_member_use
                          child: FlatButton.icon(
                              color: Colors.blue[900],
                              onPressed: showModal,
                              icon: Icon(Icons.add, color: Colors.white),
                              label: Text(
                                "Ajouter lit",
                                style: GoogleFonts.mulish(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  final textDesignLit = TextEditingController();

  void showModal() {
    Modal.show(context,
        height: 250,
        title: "Ajout Lit",
        modalContent: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10.0),
              child: Text("Désignation du Lit"),
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: ModalInputText(
                hintText: "Entrez la designation du lit",
                icon: Icons.swap_horizontal_circle_outlined,
                controller: textDesignLit,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blue[900],
                  onPressed: () async {
                    if (textDesignLit.text == "") {
                      XDialog.showErrorMessage(context,
                          title: "Saisie obligatoire",
                          message: "Vous devez entrez la désignation du Lit !");
                      return;
                    }
                    Xloading.show(context, "Traitement en cours...");
                    try {
                      await ApiManagerService.addHospitalBed(
                          design: textDesignLit.text)
                          .then((result) {
                        Xloading.dismiss();
                        if (result == "success") {
                          XDialog.showSuccessMessage(context,
                              title: "Succès",
                              message: "Opération effectuée avec succès !");
                          textDesignLit.text = "";
                          apiController.loadData();
                          Future.delayed(Duration(seconds: 2), () {
                            Get.back();
                          });
                        } else {
                          XDialog.showErrorMessage(context,
                              title: "Echec !",
                              message:
                              "Une erreur est survenue lors de l'envoi des données au serveur !");
                        }
                      });
                    } catch (e) {
                      Xloading.dismiss();
                      print(e);
                    }
                  },
                label: Text("Ajouter", style: GoogleFonts.mulish(color: Colors.white),),
                icon: Icon(Icons.add, color: Colors.white,),
                  ),
            )
          ],
        ));
  }
}

class LitCard extends StatelessWidget {
  final String title;
  const LitCard({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Lit : $title",
              style: GoogleFonts.mulish(
                  color: Colors.blue[900], fontWeight: FontWeight.w700),
            ),
          ),
          Center(
              child: SvgPicture.asset(
            "assets/svg/bed4.svg",
            alignment: Alignment.center,
            color: Colors.blue[900],
            height: 70,
            width: 70,
          )),
        ],
      ),
    );
  }
}
