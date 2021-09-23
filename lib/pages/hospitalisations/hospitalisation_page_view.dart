
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/pages/hospitalisations/pages/hospitalisation_tabs.dart';
import 'package:medpad/pages/hospitalisations/widgets/hospitalisation_card_widget.dart';
import 'package:medpad/services/cryptage_service.dart';

class HospitalisationPageView extends StatefulWidget {
  @override
  _HospitalisationPageViewState createState() => _HospitalisationPageViewState();
}

class _HospitalisationPageViewState extends State<HospitalisationPageView> {
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
            color: Colors.white.withOpacity(.9)),
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
                          Icon(Icons.medical_services_sharp,
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
              SizedBox(height: 20.0,),
              Expanded(
                  child: Obx((){
                    if(appController.hospitalisationsList.isEmpty){
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
                            Text("Aucune hospitalisation disponible pour l'instant",textAlign: TextAlign.center, style: GoogleFonts.mulish(fontWeight: FontWeight.w400, fontSize: 18.0),),
                          ],
                        ),
                      );
                    }
                    else{
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.90),
                        itemCount:appController.hospitalisationsList.length,
                        itemBuilder: (context, index) {
                          var list = appController.hospitalisationsList[index];
                          String patientNom = GxdCryptor.decrypt(list.nomPatient);
                          return HospitalisationViewCard(
                            patientName: patientNom ?? "",
                            litDesign: list.lit,
                            onNavigate: (){
                              appController.showScan(context, onSuccess: (){
                                storage.write("hospitalisation_id", list.hospitalisationId);
                                appController.hospitalisationSignesVitauxList.value = list.signesVitaux;
                                appController.hospitalisationTraitementsList.value = list.traitements;
                                appController.hospitalisationprescriptionsList.value = list.prescriptions;
                                appController.hospitalisationObservationsList.value = list.observations;
                                appController.hospitalisationActesList.value = list.actes;
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HospitalisationTabs()));
                              });
                            },
                          );
                        },
                      );
                    }

                  })
              )
            ],
          ),
        ),
      ),
    );
  }
}
