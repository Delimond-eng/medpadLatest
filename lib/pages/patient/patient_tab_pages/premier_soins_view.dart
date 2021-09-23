import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';

class PremierSoinsView extends StatefulWidget {
  @override
  _PremierSoinsViewState createState() => _PremierSoinsViewState();
}

class _PremierSoinsViewState extends State<PremierSoinsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => Container(
            child: appController.premiersoinsList.isEmpty
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
                          "Aucun premier soin répertorié !",
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
                    padding: EdgeInsets.only(top: 8, left: 5.0, right: 5.0),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 3.80,
                    ),
                    itemCount: appController.premiersoinsList.length,
                    itemBuilder: (context, index) => SoinsCard(
                          dosage: appController.premiersoinsList[index].dosage,
                          traitement:
                              appController.premiersoinsList[index].traitement,
                          date: appController
                              .premiersoinsList[index].dateEnregistrement,
                        ))),
      ),
    );
  }
}

class SoinsCard extends StatelessWidget {
  final String traitement;
  final bool isPrescription;
  final String dosage;
  final String date;

  const SoinsCard({Key key, this.traitement, this.dosage, this.date, this.isPrescription=false})
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
                                  (isPrescription) ?'Prescription' : ' Traitement',
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
                              ' ${date.split('|')[0]}',
                              style: GoogleFonts.mulish(
                                  fontSize: 12.0, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Icon(
                              Icons.access_time,
                              color: Colors.deepOrange,
                              size: 15.0,
                            ),
                            Text(
                              ' ${date.split('|')[1]}',
                              style: GoogleFonts.mulish(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
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
