import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/widgets/simpleQR_card.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:medpad/widgets/input_text_grey.dart';

class ConsultationHistoireMaladie extends StatefulWidget {
  ConsultationHistoireMaladie({Key key}) : super(key: key);

  @override
  _ConsultationHistoireMaladieState createState() =>
      _ConsultationHistoireMaladieState();
}

class _ConsultationHistoireMaladieState
    extends State<ConsultationHistoireMaladie> {
  final textQuestion = TextEditingController();
  final textResponse = TextEditingController();

  bool isQR = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            if (isQR == false)
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
                          isQR = true;
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
                      "Consulter histoire maladie",
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            if (isQR == true) questionResponseWidget(),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              if (apiController.consultStoryList.isEmpty)
                return Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
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
                        "Aucune histoire maladie!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                );
              else
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: apiController.consultStoryList.length,
                  itemBuilder: (context, index) {
                    var list = apiController.consultStoryList[index];
                    return SimpleQRCard(
                      question: list.question,
                      reponse: list.reponse,
                    );
                  },
                );
            })
          ],
        ),
      ),
    );
  }

  Future<void> saveStories() async {
    if (textQuestion.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          message: "vous devez entrer la question !",
          color: bgColor);
      return;
    } else if (textResponse.text.isEmpty) {
      XDialog.showErrorMessage(context,
          title: "Saisie obligatoire",
          message: "vous devez entrer la reponse !",
          color: bgColor);
      return;
    }
    try {
      var consultId = storage.read("consult_id");
      print("consult id : $consultId");

      Xloading.showLottieLoading(context);

      ApiManagerService.consultationHistoireMaladie(
              consultId: consultId,
              question: textQuestion.text,
              reponse: textResponse.text)
          .then((result) {
        Xloading.dismiss();
        if (result.reponse.status == "success") {
          print(result.reponse.status);
          XDialog.showSuccessAnimation(context);
          apiController.consultStoryList.value = result.reponse.data;
          apiController.loadData();
          textQuestion.text = "";
          textResponse.text = "";
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
  }

  Widget questionResponseWidget() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: primaryColor.withOpacity(.5), width: 1)),
        color: Colors.white54,
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
          Text(
            "Histoire maladie du patient",
            style: GoogleFonts.mulish(color: Colors.blue[900], fontSize: 16.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          InputText(
              hintText: "Entrez une question...",
              icon: CupertinoIcons.question_circle_fill,
              inputController: textQuestion,
              title: "Question",
              isRequired: true),
          SizedBox(
            height: 15,
          ),
          InputText(
            hintText: "Entrez la reponse...",
            icon: CupertinoIcons.pencil_ellipsis_rectangle,
            inputController: textResponse,
            title: "Reponse",
            isRequired: true,
          ),
          SizedBox(
            height: 15.0,
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
                    onPressed: saveStories,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Enregistrer",
                      style: GoogleFonts.mulish(color: Colors.white),
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                splashColor: Colors.grey,
                onTap: () {
                  setState(() {
                    isQR = false;
                  });
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black45),
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
    );
  }
}
