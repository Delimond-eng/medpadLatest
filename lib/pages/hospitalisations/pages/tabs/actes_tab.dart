import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/models/hospitalisations_model.dart';
import 'package:medpad/services/api_manager_service.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ActesTab extends StatefulWidget {
  @override
  _ActesTabState createState() => _ActesTabState();
}

class _ActesTabState extends State<ActesTab> {
  final _controller = TextEditingController();

  SpeechToText stt = SpeechToText();
  bool isListening = false;
  String text = '';
  double accurancy = 1.0;
  
  @override
  void initState() {
    super.initState();
    initializeAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Text(
                "Acte médical *",
                style:
                    GoogleFonts.mulish(color: Colors.blue[900], fontSize: 18.0),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: primaryColor.withOpacity(.5), width: 1),
                    borderRadius: BorderRadius.circular(5.0)),
                child: TextFormField(
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _controller,
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      hintText: "Veuillez saisir l'acte médical...",
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
              FlatButton.icon(
                color: Colors.blue[900],
                height: 50.0,
                minWidth: 200.0,
                onPressed: () async {
                  var hospitalisationId = storage.read("hospitalisation_id");
                  if (_controller.text.isEmpty) {
                    XDialog.showErrorMessage(context,
                        title: "Information requise",
                        message: "vous devez entrer l'acte médical !");
                    return;
                  }

                  Xloading.show(context, "Exécution en cours...");

                  await ApiManagerService.hospitalisationActes(
                          hospitalizationId: hospitalisationId,
                          acte: _controller.text)
                      .then((res) {
                    Xloading.dismiss();
                    if (res != null) {
                      XDialog.showSuccessMessage(context,
                          title: "Succès",
                          message: "Votre acte a été enregistré avec succès!");
                      _controller.text = "";
                      Iterable i = res;
                      List<HospitalisationActes> actesList =
                          List<HospitalisationActes>.from(i.map(
                              (model) => HospitalisationActes.fromJson(model)));
                      appController.hospitalisationActesList.value = actesList;
                    }
                  }).catchError((err) {
                    Xloading.dismiss();
                    print(err);
                  });
                },
                icon: Icon(Icons.check, color: Colors.white),
                label: Text("valider",
                    style: GoogleFonts.mulish(color: Colors.white)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.only(bottom: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey[200], width: 1.0))),
                child: Text(
                  "Actes médicaux",
                  style: GoogleFonts.mulish(
                      fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Obx(() {
                if (appController.hospitalisationActesList.isEmpty)
                  return Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Text(
                      "Aucun acte médical !",
                      style: GoogleFonts.mulish(fontSize: 18.0),
                    ),
                  );
                else
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appController.hospitalisationActesList.length,
                      itemBuilder: (context, index) {
                        var list =
                            appController.hospitalisationActesList[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          margin: EdgeInsets.only(bottom: 5.0),
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            "Acte médical",
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue[900]),
                                          )),
                                      Text(
                                        "${list.acte}",
                                        textAlign: TextAlign.justify,
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
                                                    ' ${gStrSplitParser(list.dateEnregistrement.toString())[1]}',
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
                                                    ' ${gStrSplitParser(list.dateEnregistrement.toString())[0]}',
                                                    style: GoogleFonts.mulish(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w800,
                                                        color: Colors.blue[900]),
                                                  ),
                                                ],
                                              )))
                                    ],
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0))),
                                height: 3,
                              ),
                            ],
                          ),
                        );
                      });
              })
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        glowColor: Colors.blue[800],
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 1000),
        repeat: true,
        child: FloatingActionButton(onPressed: _listen,
          backgroundColor: Colors.blue[800],
          child: Icon(isListening ? CupertinoIcons.mic_solid : CupertinoIcons.mic),
        ),
      ),
    );


  }


  void _listen() async {
    if(stt.isAvailable){
      if(!isListening){
        setState(() {
          isListening = true;
        });
        stt.listen(
            listenMode: ListenMode.dictation,
            onResult: (result){
              setState(() {
                accurancy = result.confidence;
                text = result.recognizedWords;
                if(text.isNotEmpty){
                  _controller.text = text;
                }
              });
            }
        );
      }
      else{
        setState(() {
          isListening = false;
          stt.stop();
        });
      }
    }
    else{
      print("permission as denied!");
    }
  }

  void initializeAudio() async {
    stt.initialize();
  }

}
