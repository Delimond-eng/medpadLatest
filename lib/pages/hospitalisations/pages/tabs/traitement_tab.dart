import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/models/hospitalisations_model.dart';
import 'package:medpad/services/api_manager_service.dart';

class TraitementsTab extends StatefulWidget {
  @override
  _TraitementsTabState createState() => _TraitementsTabState();
}

class _TraitementsTabState extends State<TraitementsTab> {
  bool isSelected = false;
  String status = "";
  List<dynamic> prescriptionIds = [];
  var iterable;
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Container(
      width: _size.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (appController.hospitalisationprescriptionsList.isEmpty)
                    return Container(
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Aucune prescription pour ce patient",
                          style: GoogleFonts.mulish(
                              color: Colors.redAccent.withOpacity(.3),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  else
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: appController
                              .hospitalisationprescriptionsList.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 3.0),
                          itemBuilder: (BuildContext context, int index) {
                            var data = appController
                                .hospitalisationprescriptionsList[index];
                            return Card(
                              elevation: 2,
                              color:
                                  data.isSelected ? primaryColor : Colors.white,
                              child: CheckboxListTile(
                                value: data.isSelected,
                                onChanged: (val) {
                                  setState(() {
                                    data.isSelected = val;
                                  });

                                  if (data.isSelected == true) {
                                    prescriptionIds.add(data.prescriptionId);
                                  } else {
                                    prescriptionIds.removeWhere(
                                        (id) => id == data.prescriptionId);
                                  }
                                },
                                title: Text(
                                  "${data.prescription}",
                                  style: GoogleFonts.mulish(
                                      color: data.isSelected
                                          ? Colors.white
                                          : Colors.black87),
                                ),
                                subtitle: Text(
                                  "Dosage : ${data.dosage}",
                                  style: GoogleFonts.mulish(
                                      color: data.isSelected
                                          ? Colors.white
                                          : null),
                                ),
                                activeColor: primaryColor,
                                checkColor: Colors.white,
                              ),
                            );
                          }),
                    );
                }),
                // ignore: deprecated_member_use
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton.icon(
                    onPressed: submittedTraitement,
                    color: Colors.blue[800],
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text("valider",
                        style: GoogleFonts.mulish(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey[200], width: 1.0))),
              child: Text(
                "Traitements effectués",
                style: GoogleFonts.mulish(
                    fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
            ),
            Obx(() {
              if (appController.hospitalisationTraitementsList.isEmpty)
                return Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "Aucun Traitement effectué pour l'instant",
                      style: GoogleFonts.mulish(
                          color: Colors.redAccent.withOpacity(.3),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              else
                return GridView.builder(
                    padding: EdgeInsets.only(top: 8, left: 5.0, right: 5.0),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 3.80,
                    ),
                    itemCount:
                        appController.hospitalisationTraitementsList.length,
                    itemBuilder: (context, index) => SCard(
                        dosage: appController
                            .hospitalisationTraitementsList[index].dosage,
                        traitement: appController
                            .hospitalisationTraitementsList[index].prescription,
                        date: appController
                            .hospitalisationTraitementsList[index]
                            .dateEnregistrement
                            .toString()));
            })
          ],
        ),
      ),
    );
  }

  Future<void> submittedTraitement() async {
    var hospitalisationId = storage.read("hospitalisation_id");
    print(hospitalisationId);
    if (prescriptionIds.isEmpty) {
      XDialog.showErrorMessage(context,
          color: bgColor,
          message: "Vous devez cocher un traitement !",
          title: "Action requise");
      return;
    }

    Xloading.show(context, "Exécution en cours...");
    for (int i = 0; i < prescriptionIds.length; i++) {
      await ApiManagerService.hospitalisationTraitment(
              hospitalizationId: hospitalisationId, prescId: prescriptionIds[i])
          .then((res) {
        if (res == null) {
          XDialog.showErrorMessage(context,
              title: "Echec",
              message:
                  "Une erreur est survenu lors de l'envoi des données dans le serveur,\nveuillez réessayer ultérieurement");
          return;
        } else {
          setState(() {
            iterable = res;
          });
        }
      }).catchError((err) {
        print(err);
        Xloading.dismiss();
      });
    }
    Xloading.dismiss();
    XDialog.showSuccessMessage(context,
        title: "Succès",
        message: "Le traitement a été enregistré avec succès!");
    Iterable i = iterable;
    List<HospitalisationTraitements> traitementsList =
        List<HospitalisationTraitements>.from(
            i.map((model) => HospitalisationTraitements.fromJson(model)));
    appController.hospitalisationTraitementsList.value = traitementsList;
    this.setState(() {});
  }
}

class SCard extends StatelessWidget {
  final String traitement;
  final bool isPrescription;
  final String dosage;
  final String date;

  const SCard(
      {Key key,
      this.traitement,
      this.dosage,
      this.date,
      this.isPrescription = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5.0,
        shadowColor: Colors.black38,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Container(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 10.0, top: 4.0, bottom: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.medical_services_rounded,
                                    size: 12.0,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue[500],
                                  ),
                                ),
                                Text(
                                  (isPrescription)
                                      ? 'Prescription'
                                      : ' Traitement',
                                  style: GoogleFonts.mulish(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0),
                                ),
                              ],
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$traitement'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 2,
                    color: Colors.black12,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 10.0, top: 4.0, bottom: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.medical_services_outlined,
                                    size: 12.0,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue[500],
                                  ),
                                ),
                                Text(
                                  ' Dosage',
                                  style: GoogleFonts.mulish(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$dosage'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (date.isNotEmpty)
                SizedBox(
                  height: 8.0,
                ),
              if (date.isNotEmpty)
                Container(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.deepOrange,
                              size: 15.0,
                            ),
                            Text(
                              ' ${gStrSplitParser(date)[1]}',
                              style: GoogleFonts.mulish(
                                  fontSize: 12.0, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Icon(
                              Icons.access_time_filled_rounded,
                              color: Colors.deepOrange,
                              size: 16.0,
                            ),
                            Text(
                              ' ${gStrSplitParser(date)[0]}',
                              style: GoogleFonts.mulish(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blue[900]),
                            ),
                          ],
                        )))
            ],
          ),
        ),
      ),
    );
  }
}
