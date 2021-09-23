import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/models/hospitalisations_model.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/input_text_grey.dart';

class SigneVitauxTab extends StatefulWidget {
  @override
  _SigneVitauxTabState createState() => _SigneVitauxTabState();
}

class _SigneVitauxTabState extends State<SigneVitauxTab> {
  String signeId;
  final textSignValue = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20),
          margin: EdgeInsets.only(top: 10.0),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sélectionner un signe vital *",
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
                                  .nextInt(Colors.primaries.length)].shade900,
                              width: 2.0
                            )
                          )),
                      child: DropdownButton<String>(
                        menuMaxHeight: 300,
                        dropdownColor: Colors.white,
                        value: signeId,
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
                                            .nextInt(Colors.primaries.length)],
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
                            signeId = value;
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
                      inputController: textSignValue),
                  SizedBox(height: 20.0),
                  // ignore: deprecated_member_use
                  FlatButton.icon(
                    color: Colors.blue[800],

                    onPressed: submitted,
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text("valider",
                        style: GoogleFonts.mulish(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.only(bottom: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey[200], width: 1.0))),
                child: Text(
                  "Signes vitaux prélevés",
                  style: GoogleFonts.mulish(
                      fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Obx((){
                if(appController.hospitalisationSignesVitauxList.isEmpty)
                  return Center(
                    child: Text("Aucun signe vital !"),
                  );
                else
                  return GridView.builder(
                      itemCount: appController.hospitalisationSignesVitauxList.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 2.40),
                      itemBuilder: (BuildContext context, int index) {
                        var data = appController.hospitalisationSignesVitauxList[index];
                        return Card(
                          elevation: 2,
                          color: Colors.blue[900],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                          ),
                                          child: Icon(Icons.accessibility_sharp, color: Colors.blue[800],),
                                        ),
                                        SizedBox(width: 5.0,),
                                        Text(
                                          "${data.titre}",
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600, color: Colors.white),
                                        ),
                                      ],
                                    )),
                                SizedBox(height: 10,),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.deepPurpleAccent
                                        ),
                                        child: Icon(Icons.accessibility_sharp, color: Colors.white,),
                                      ),
                                      SizedBox(width: 5.0,),
                                      Text(
                                        "${data.signeVitalValeur}",
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w800, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white12,
                                            borderRadius: BorderRadius.circular(20.0)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_rounded,
                                              color: Colors.yellowAccent,
                                              size: 15.0,
                                            ),
                                            Text(
                                              ' ${gStrSplitParser(data.dateEnregistrement)[1].replaceAll("-", "/")}',
                                              style: GoogleFonts.mulish(
                                                  fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Icon(
                                              Icons.access_time_filled,
                                              color: Colors.yellowAccent,
                                              size: 15.0,
                                            ),
                                            Text(
                                              ' ${gStrSplitParser(data.dateEnregistrement)[0]}',
                                              style: GoogleFonts.mulish(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )))
                              ],
                            ),
                          ),
                        );
                      });
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitted() async {
    try {
      var hospitalisationId = storage.read("hospitalisation_id");
      print(hospitalisationId);
      if (hospitalisationId == null || hospitalisationId == "") {
        XDialog.showErrorMessage(context,
            color: bgColor,
            title: "Info requise",
            message: "vous devez sélectionner une hospitalisation !");
        return;
      }
      if (signeId == null || signeId == "") {
        XDialog.showErrorMessage(context,
            color: bgColor,
            title: "Information requise",
            message: "vous devez sélectionner un signe vital !");
        return;
      }
      if (textSignValue.text.isEmpty) {
        XDialog.showErrorMessage(context,
            color: bgColor,
            title: "Information requise",
            message: "vous devez entrer la valeur du signe vital!");
        return;
      }

      Xloading.show(context, "Exécution en cours...");

      await ApiManagerService.hospitalisationSignesVitaux(hospitalizationId: hospitalisationId, signeVitalId: signeId, value: textSignValue.text).then((res) {
        Xloading.dismiss();
        if (res != null) {
          XDialog.showSuccessMessage(context, title: "Succès", message: "le signe vital a été prélevé !");
          textSignValue.text ="";
          Iterable i = res;
          List<HospitalisationSignesVitaux> signesVitauxList = List<HospitalisationSignesVitaux>.from(i.map((model) => HospitalisationSignesVitaux.fromJson(model)));
          appController.hospitalisationSignesVitauxList.value = signesVitauxList;
        }
      }).catchError((err) {
        print(err);
        Xloading.dismiss();
      });
    } catch (err) {
      print(err);
    }
  }
}
