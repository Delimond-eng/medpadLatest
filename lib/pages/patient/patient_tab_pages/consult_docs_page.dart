import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';

class ConsultDocsPage extends StatefulWidget {
  final Function onNavigate;

  const ConsultDocsPage({Key key, this.onNavigate}) : super(key: key);
  @override
  _ConsultDocsPageState createState() => _ConsultDocsPageState();
}

class _ConsultDocsPageState extends State<ConsultDocsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() => Container(
            width: size.width,
            child: (appController.consultationList.isEmpty)
                ? Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Column(
                      children: [
                        Lottie.asset(
                          "assets/lotties/16656-empty-state.json",
                          alignment: Alignment.center,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          animate: true,
                        ),
                        Text(
                          "Aucune consultation disponible!",
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
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1.20,
                    ),
                    itemCount: appController.consultationList.length,
                    itemBuilder: (context, index) {
                      var list = appController.consultationList[index];
                      return DocCard(
                          plainte: list.plainte,
                          date: list.dateEnregistrement,
                          callback: () {
                            appController.signeVitauxList.value =
                                list.signesVitaux;
                            appController.histoireMaladieList.value =
                                list.histoireMaladie;
                            appController.examensLaboList.value =
                                list.examensLaboratoire;
                            appController.examensPhysiqueList.value =
                                list.examensPhysique;
                            appController.prescriptionsList.value =
                                list.prescriptions;
                            appController.strPlainte.value = list.plainte;
                            appController.strDateDoc.value =
                                list.dateEnregistrement;
                            appController.showScan(context, onSuccess: (){
                              widget.onNavigate();
                            });
                          });
                    }),
          )),
    );
  }
}

class DocCard extends StatelessWidget {
  final String plainte;
  final String date;
  final Function callback;

  const DocCard({Key key, this.plainte, this.date, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          color: Colors.blue[100],
          shadowColor: Colors.black38,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.blue[50], shape: BoxShape.circle),
                          padding: EdgeInsets.all(9.0),
                          child: Image.asset("assets/icons/folder3.png"),
                        ),
                        SizedBox(height: 5.0,),
                        Text("PLAINTE", style: GoogleFonts.mulish(fontWeight: FontWeight.w700),),
                        SizedBox(height: 5.0,),
                        Text("${truncateString(plainte, 25)}")
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -24,
                    right: 10,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              color: Colors.redAccent, size: 15.0),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("${date.split(",")[0]}",
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[600],
                                  fontSize: 12)),
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(
                            Icons.access_time_filled_rounded,
                            color: Colors.redAccent,
                            size: 16.0,
                          ),
                          SizedBox(width: 3,),
                          Text("${date.split(",")[1]}",
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[600],
                                  fontSize: 12)
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.bottomRight,
                  height: 55,
                  color: Colors.blue[800],
                  child:  FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      color: Colors.blue[50],
                      onPressed:callback,
                      icon: Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Colors.blue[900],
                      ),
                      label: Text(
                        "Détail",
                        style: GoogleFonts.mulish(
                            color: Colors.blue[900]),
                      ))
              )
            ],
          ),
        ));
  }
}
