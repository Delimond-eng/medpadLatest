
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/patient_tab_pages/premier_soins_view.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/input_text_grey.dart';

class ConsultationPrescription extends StatefulWidget {
  ConsultationPrescription({Key key, this.onEnd}) : super(key: key);
  final Function onEnd;
  @override
  _ConsultationPrescriptionState createState() =>
      _ConsultationPrescriptionState();
}

class _ConsultationPrescriptionState extends State<ConsultationPrescription> {
  final textPrescription = TextEditingController();
  final textDosage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Veuillez prescrire des soins pour cette consultation !", style: GoogleFonts.mulish(fontSize: 16.0),),
        ),
        SizedBox(height: 8.0,),
        Container(
          alignment: Alignment.center,
          width: size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12.0)
              ],),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: InputText(
                  hintText: "Entrez la prescription",
                  icon: Icons.medication,
                  inputController: textPrescription,
                  radius: 5.0,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                child: InputText(
                  hintText: "Entrez le dosage",
                  icon: Icons.medication_outlined,
                  inputController: textDosage,
                  radius: 5.0,
                ),
              ),
              SizedBox(
                width: 5,
              ),

              FlatButton.icon(
                height: 48.0,
                color: Colors.blue[800],
                onPressed: () async{
                  if (textPrescription.text.isEmpty) {
                    XDialog.showErrorMessage(context,
                        color: bgColor,
                        title: "Saisie obligatoire",
                        message: "vous devez entrer la prescription !");
                    return;
                  }

                  if (textDosage.text.isEmpty) {
                    XDialog.showErrorMessage(context,
                        color: bgColor,
                        title: "Saisie obligatoire",
                        message: "vous devez entrer le dosage !");
                    return;
                  }
                  var consultId = storage.read("consult_id");
                  try {
                    Xloading.showLottieLoading(context);
                    await ApiManagerService.consultationPrescription(
                        consultId: consultId,
                        prescription: textPrescription.text,
                        dosage: textDosage.text)
                        .then((result) {
                      Xloading.dismiss();
                      if (result.reponse.status == "success") {
                        XDialog.showSuccessAnimation(context);
                        apiController.consultPrescriptionsList.value =
                            result.reponse.prescriptions;
                        textPrescription.text = "";
                        textDosage.text = "";
                      } else {
                        XDialog.showErrorMessage(
                          context,
                          message:
                          "une erreur est survenue lors de l'envoi de données au serveur,\nveuillez réessayer ultérieurement svp!",
                          title: "Echec",
                        );
                      }
                    });
                  } catch (err) {
                    Xloading.dismiss();
                    print(err);
                    XDialog.showErrorMessage(
                      context,
                      message:
                      "une erreur est survenue lors de l'envoi de données au serveur,\nveuillez réessayer ultérieurement svp!",
                      title: "Echec",
                    );
                  }
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("Ajouter", style: GoogleFonts.mulish(color: Colors.white),),
              )
              // ignore: deprecated_member_us
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(() {
          return Expanded(
            flex: 5,
            child: Container(
              color: Colors.white54,
              margin: EdgeInsets.only(bottom: 10.0),
              child: apiController.consultPrescriptionsList.isEmpty
                  ? Center(
                      child: Container(
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
                              "Aucune prescription disponible !",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                  padding: EdgeInsets.only(top: 8, left: 5.0, right: 5.0),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 3.80,
                  ),
                  itemCount: apiController.consultPrescriptionsList.length,
                  itemBuilder: (context, index) => SoinsCard(
                    dosage: apiController.consultPrescriptionsList[index].dosage,
                    traitement: apiController.consultPrescriptionsList[index].prescription,
                    date:"",
                    isPrescription: true,
                  )
              ) ,
            ),
          );
        }),
      ],
    ));
  }
}
