import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/models/consult_antecedent_model.dart';
import 'package:medpad/models/consult_examen_model.dart';
import 'package:medpad/models/consult_prescription_model.dart';
import 'package:medpad/models/consult_waiting_model.dart';
import 'package:medpad/models/consultaion_model.dart';
import 'package:medpad/models/examen_encours_model.dart';
import 'package:medpad/models/story_maladies_model.dart';
import 'package:medpad/pages/consultation/widgets/consultation_card.dart';
import 'package:medpad/pages/consultation/widgets/filter_button.dart';
import 'package:medpad/pages/patient/pages/patient_consultations_page.dart';
import 'package:medpad/services/cryptage_service.dart';

class ConsultationPageView extends StatefulWidget {
  ConsultationPageView({Key key}) : super(key: key);

  @override
  _ConsultationPageViewState createState() => _ConsultationPageViewState();
}

class _ConsultationPageViewState extends State<ConsultationPageView> {
  bool isActiveWait = true;
  bool isActiveDate = false;
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/image3.webp"), fit: BoxFit.fill),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white30],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
                                ? 56
                                : 6,
                            bottom: 5.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 35, left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.accessibility_new_rounded,
                                  color: primaryColor),
                              Text(
                                "${menuController.activeItem.value}",
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
                  )),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(
                      icon: CupertinoIcons.refresh,
                      title: "Consultation en cours...",
                      isActive: isActiveWait,
                      onPressed: () {
                        setState(() {
                          isActiveWait = true;
                          isActiveDate = false;
                        });
                      }),
                  Row(
                    children: [
                      FilterButton(
                          icon: CupertinoIcons.calendar,
                          title: "Trier par date",
                          isActive: isActiveDate,
                          onPressed: () {
                            setState(() {
                              isActiveWait = false;
                              isActiveDate = true;
                            });
                          }),
                      if (isActiveDate == true)
                        SizedBox(
                          width: 8.0,
                        ),
                      if (isActiveDate == true)
                        Container(
                          height: 40.0,
                          width: 250,
                          child: DateTimeField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_today_rounded,
                                  size: 20.0,
                                  color: primaryColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor)),
                                hintText: "Sélectionnez la date",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic)),
                            format: format,
                            onShowPicker: (context, currentValue) {
                              print(currentValue.toString());
                              return showDatePicker(
                                  context: context,
                                  locale: Locale('fr', 'FR'),
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                if(apiController.consultationWaitingList.isEmpty){
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lotties/16656-empty-state.json",
                          alignment: Alignment.center,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                          animate: true,
                        ),
                        Text("Aucune Consultation en cours!",textAlign: TextAlign.center, style: GoogleFonts.mulish(fontWeight: FontWeight.w400, fontSize: 18.0),),
                      ],
                    ),
                  );
                }
                else{
                  return Expanded(
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio:0.95),
                            itemCount:
                            apiController.consultationWaitingList.length,
                            itemBuilder: (context, index) {
                              var list =
                              apiController.consultationWaitingList[index];
                              String patientName =
                              GxdCryptor.decrypt(list.patientNom);
                              return ConsultCard(
                                level: list.completion.toDouble(),
                                patientName: patientName,
                                press: () {
                                  appController.showScan(context, onSuccess: (){
                                    try {
                                      List<ConsultSignesVitaux> signeVitauxList = list.signesVitaux;
                                      List<ConsultAntecedents> antecedentsList = list.antecedents;
                                      List<ConsultExamensLaboratoire> examensLaboList = list.examensLaboratoire;
                                      List<ConsultExamensPhysique> examensPhysicsList = list.examensPhysique;
                                      List<ConsultHistoireMaladie> storyMaladyList = list.histoireMaladie;
                                      List<ConsultPrescriptions> prescriptionsList = list.prescriptions;
                                      var jsonListSigneVitaux = jsonEncode(signeVitauxList);
                                      var jsonListAntecedent = jsonEncode(antecedentsList);
                                      var jsonListExamensLabo = jsonEncode(examensLaboList);
                                      var jsonListExamensPhysics = jsonEncode(examensPhysicsList);
                                      var jsonListStoryMaladie = jsonEncode(storyMaladyList);
                                      var jsonPrescriptionList = jsonEncode(prescriptionsList);
                                      //iterable
                                      Iterable a = jsonDecode(jsonListSigneVitaux);
                                      Iterable b = jsonDecode(jsonListAntecedent);
                                      Iterable c = jsonDecode(jsonListExamensLabo);
                                      Iterable e = jsonDecode(jsonListExamensPhysics);
                                      Iterable f = jsonDecode(jsonListStoryMaladie);
                                      Iterable j = jsonDecode(jsonPrescriptionList);

                                      //parsing data to list
                                      List<ConsultationSignesVitaux> signesVitaux =List<ConsultationSignesVitaux>.from(a.map((model) => ConsultationSignesVitaux.fromJson(model)));
                                      List<Data> storyList = List<Data>.from(f.map((model) => Data.fromJson(model)));
                                      List<Antecedents> antecedents = List<Antecedents>.from(b.map((model) => Antecedents.fromJson(model)));
                                      List<ExamensPhysique> examensPhysiques = List<ExamensPhysique>.from(e.map((model) => ExamensPhysique.fromJson(model)));
                                      List<Examens> examensLabo = List<Examens>.from(c.map((model) => Examens.fromJson(model)));
                                      List<Prescriptions> prescriptions = List<Prescriptions>.from(j.map((model) => Prescriptions.fromJson(model)));

                                      //assignement
                                      apiController.consultationList.value = signesVitaux;
                                      apiController.consultStoryList.value = storyList;
                                      apiController.consultAntecedentList.value = antecedents;
                                      apiController.consultExamensList.value = examensPhysiques;
                                      apiController.examenEcoursList.value = examensLabo;
                                      apiController.consultPrescriptionsList.value = prescriptions;

                                      storage.write(
                                          "consult_id", list.consultationId);
                                      storage.write("patient_name",
                                          GxdCryptor.decrypt(list.patientNom));
                                      storage.write(
                                          "plainte_patient", list.plainte);
                                    } catch (err) {
                                      print(err);
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PatientConsultationsPage()));
                                  });
                                },
                              );
                            },
                          ))
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
