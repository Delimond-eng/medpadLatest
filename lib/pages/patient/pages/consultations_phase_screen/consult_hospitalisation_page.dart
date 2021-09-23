import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/services/api_manager_service.dart';

class ConsultationHospitalisationPage extends StatefulWidget {
  ConsultationHospitalisationPage({Key key}) : super(key: key);

  @override
  _ConsultationHospitalisationPageState createState() =>
      _ConsultationHospitalisationPageState();
}

class _ConsultationHospitalisationPageState
    extends State<ConsultationHospitalisationPage> {
  bool isHospitalisation = false;
  bool isAmbulatory = false;
  bool isOther = false;

  bool hasSelected = false;
  String litId = "";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 10.0),
      width: size.width,
      decoration: BoxDecoration(color: Colors.white.withOpacity(.9)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 80.0,
              width: size.width,
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    childAspectRatio: 4.15),
                children: [
                  Card(
                    elevation: 2,
                    color: primaryColor,
                    margin: EdgeInsets.all(8),
                    child: CheckboxListTile(
                      value: isHospitalisation,
                      onChanged: (val) {
                        setState(() {
                          isHospitalisation = val;
                          isAmbulatory = false;
                          isOther = false;
                        });
                      },
                      title: Text(
                        "Hospitalisation",
                        style: GoogleFonts.mulish(color: Colors.white),
                      ),
                      activeColor: primaryColor,
                      checkColor: Colors.white,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    color: Colors.purple,
                    margin: EdgeInsets.all(8),
                    child: CheckboxListTile(
                      value: isAmbulatory,
                      onChanged: (val) {
                        setState(() {
                          isAmbulatory = val;
                          isOther = false;
                          isHospitalisation = false;
                        });
                      },
                      title: Text("Ambulatoire",
                          style: GoogleFonts.mulish(color: Colors.white)),
                      activeColor: Colors.purple,
                      checkColor: Colors.white,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(8),
                    color: Colors.blueGrey,
                    child: CheckboxListTile(
                      value: isOther,
                      onChanged: (val) {
                        setState(() {
                          isOther = val;
                          isHospitalisation = false;
                          isAmbulatory = false;
                        });
                      },
                      title: Text("Autres",
                          style: GoogleFonts.mulish(color: Colors.white)),
                      activeColor: Colors.blueGrey,
                      checkColor: Colors.white,
                    ),
                  )
                ],
              )),
          if (!isHospitalisation && !isAmbulatory && !isOther)
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text(
                "Veuiller sélectionner un mode de traitement !",
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                    color: Colors.black87,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          if (isHospitalisation) hospitalisationWidget()
        ],
      ),
    );
  }

  Widget hospitalisationWidget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(.9)),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Les lits disponibles",
              style: GoogleFonts.mulish(
                  color: Colors.blue[900], fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(child: Obx(() {
              return Container(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2.0),
                  itemCount: apiController.hospitalBedsList.length,
                  itemBuilder: (context, index) {
                    var list = apiController.hospitalBedsList[index];
                    return Card(
                      color: list.isChecked == true
                          ? Colors.blue[800]
                          : Colors.white,
                      elevation: 2,
                      margin: EdgeInsets.all(8),
                      child: CheckboxListTile(
                        value: list.isChecked,
                        onChanged: (val) {
                          setState(() {
                            for(var i = 0; i<apiController.hospitalBedsList.length; i++){
                              if(val == true){
                                apiController.hospitalBedsList[i].isChecked =  false;
                              }
                            }
                            list.isChecked = val;
                            litId = list.litId;
                          });
                        },
                        title: Stack(
                          // ignore: deprecated_member_use
                          overflow: Overflow.visible,
                          children: [
                            Container(
                              margin: EdgeInsets.all(25.0),
                              child: SvgPicture.asset(
                                "assets/svg/bed4.svg",
                                alignment: Alignment.center,
                                color: list.isChecked == true
                                    ? Colors.white
                                    : Colors.blue[800],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Text(
                                list.designation,
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    color: list.isChecked == true
                                        ? Colors.white
                                        : Colors.black87),
                              ),
                            )
                          ],
                        ),
                        activeColor: Colors.blue[800],
                        checkColor: Colors.white,
                      ),
                    );
                  },
                ),
              );
            })),
            SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: FlatButton.icon(
                height: 40.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: primaryColor,
                label: Text(
                  "valider hospitalisation",
                  style: GoogleFonts.mulish(color: Colors.white),
                ),
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (litId == "") {
                    XDialog.showErrorMessage(context,
                        color: bgColor,
                        title: "Sélection obligatoire du lit",
                        message:
                            "vous devez sélectionner le lit pour hospitaliser ce patient");
                    return;
                  }

                  Xloading.showLottieLoading(context);

                  try {
                    var consultId = storage.read("consult_id");
                    await ApiManagerService.hospitaliser(
                            consultId: consultId, litId: litId)
                        .then((status) {
                      Xloading.dismiss();
                      if (status == "success") {
                        XDialog.showSuccessAnimation(context);
                        this.setState(() {});
                      } else {
                        XDialog.showSuccessMessage(context,
                            title: "Echec",
                            message:
                                "Une erreur est survenue lors de l'envoi des informations dans le serveur!\nVeuillez réessayer SVP !");
                      }
                    });
                  } catch (err) {
                    Xloading.dismiss();
                    print(err);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LCard extends StatelessWidget {
  final bool isActived;
  const LCard({
    Key key,
    this.isActived = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isActived ? Colors.blue[800] : Colors.white,
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: CheckboxListTile(
        value: isActived,
        onChanged: (val) {},
        title: Stack(
          // ignore: deprecated_member_use
          overflow: Overflow.visible,
          children: [
            Container(
              margin: EdgeInsets.all(25.0),
              child: SvgPicture.asset(
                "assets/svg/bed4.svg",
                alignment: Alignment.center,
                color: Colors.blue[800],
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Text(
                "Lit 0001",
                style: GoogleFonts.mulish(fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
        activeColor: Colors.blue[800],
        checkColor: Colors.white,
      ),
    );
  }
}
