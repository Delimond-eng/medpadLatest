import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/patient_tab_pages/pdfs/pdf_viewer_page.dart';
import 'package:medpad/pages/patient/patient_tab_pages/widgets/examen_widget.dart';
import 'package:medpad/pages/patient/patient_tab_pages/widgets/labo_widget.dart';
import 'package:medpad/pages/patient/patient_tab_pages/widgets/prescription_widget.dart';
import 'package:medpad/pages/patient/patient_tab_pages/widgets/sign_widget.dart';
import 'package:medpad/pages/patient/patient_tab_pages/widgets/story_card.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TabConsultations extends StatefulWidget {
  @override
  _TabConsultationsState createState() => _TabConsultationsState();
}

class _TabConsultationsState extends State<TabConsultations> {
  var hospitalName = storage.read("hospital_name");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                child: Container(
                  margin: EdgeInsets.only(top: 35, left: 10),
                  child: Row(
                    children: [
                      Icon(
                          Icons.list,
                          color: primaryColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Détail Consultation",
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
          ),
          Expanded(
            child: ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: Colors.blue,
                useInkWell: true,
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1, //appController.consultationList,
                itemBuilder: (__, _) {
                  //var list = appController.consultationList[index];
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 6),
                            color: lightGrey.withOpacity(.1),
                            blurRadius: 12.0)
                      ],
                    ),
                    child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 100.0,
                                margin: EdgeInsets.only(bottom: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 6),
                                        color: Colors.black38,
                                        blurRadius: 12.0)
                                  ],
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.blue[900], width: 3)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Plainte :",
                                              style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                  color: Colors.grey[800]),
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text("  ${appController.strPlainte}",
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18.0,
                                                    color: Colors.blue[900])),
                                            Align(
                                                alignment: Alignment.bottomRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Icon(Icons.calendar_today_rounded,
                                                          color: Colors.blue[900],
                                                          size: 18.0),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                          "${appController.strDateDoc.split(",")[0]}",
                                                          style: GoogleFonts.mulish(
                                                              fontWeight:
                                                                  FontWeight.w700)),
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      Icon(
                                                        Icons.access_time_filled_rounded,
                                                        color: Colors.blue[900],
                                                        size: 18.0,
                                                      ),
                                                      Text(
                                                          "${appController.strDateDoc.split(",")[1]}",
                                                          style: GoogleFonts.mulish(
                                                              fontWeight:
                                                                  FontWeight.w700)),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Row(
                                            children: [
                                              FlatButton.icon(
                                                  color: Colors.white,
                                                  icon: Icon(
                                                      Icons.picture_as_pdf_rounded),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(20.0)),
                                                  onPressed: buildPdf,
                                                  label: Text("Exporter en pdf")),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              FlatButton(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(20.0)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Retour")),
                                            ],
                                          ))
                                    ],
                                  ),
                                )),
                            GAccordion(
                              title: "Signes vitaux",
                              primaryColorIndex: 5,
                              icon: Icons.accessibility_new_rounded,
                              child: Container(
                                height: 150.0,
                                child: (appController.signeVitauxList.isEmpty)
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 50.0),
                                        child: Center(
                                          child: Text(
                                            "Aucun signe vital!",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(
                                                color: Colors.redAccent,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: appController.signeVitauxList.length,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.all(5.0),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return SignCard(
                                            title: appController
                                                .signeVitauxList[index].titre,
                                            value: appController.signeVitauxList[index]
                                                .signeVitalValeur,
                                          );
                                        },
                                      ),
                              ),
                            ),
                            GAccordion(
                              title: "Histoire maladie",
                              primaryColorIndex: 10,
                              icon: Icons.pending_actions_rounded,
                              child: Container(
                                height: 210.0,
                                child: (appController.histoireMaladieList.isEmpty)
                                    ? Container(
                                  alignment: Alignment.center,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 50.0),
                                        child: Center(
                                          child: Text(
                                            "Aucune histoire maladie!",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(
                                                color: Colors.redAccent,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            appController.histoireMaladieList.length,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.all(5.0),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return StoryCard(
                                            question: appController
                                                .histoireMaladieList[index].question,
                                            reponse: appController
                                                .histoireMaladieList[index].reponse,
                                          );
                                        },
                                      ),
                              ),
                            ),
                            GAccordion(
                              primaryColorIndex: 7,
                              title: "Examens physiques",
                              icon: Icons.accessibility_sharp,
                              child: Container(
                                height: 150.0,
                                child: (appController.examensPhysiqueList.isEmpty)
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 50.0),
                                        child: Center(
                                          child: Text(
                                            "Aucun Examen physique!",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(
                                                color: Colors.redAccent,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            appController.examensPhysiqueList.length,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.all(5.0),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return ExamenCard(
                                            examenTitle: appController
                                                .examensPhysiqueList[index].donneeLabel,
                                            examenValue: appController
                                                .examensPhysiqueList[index]
                                                .donneeValeur,
                                          );
                                        },
                                      ),
                              ),
                            ),
                            GAccordion(
                              primaryColorIndex: 2,
                              title: "Examens Laboratoire",
                              icon: Icons.biotech,
                              child: Container(
                                height: 100.0,
                                child: (appController.examensLaboList.isEmpty)
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 50.0),
                                        child: Center(
                                          child: Text(
                                            "Aucun Examen Labo!",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(
                                                color: Colors.redAccent,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: appController.examensLaboList.length,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.all(5.0),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return LaboCard(
                                            examTitle: appController
                                                .examensLaboList[index].examen,
                                          );
                                        },
                                      ),
                              ),
                            ),
                            GAccordion(
                              primaryColorIndex: 4,
                              title: "Prescriptions médicales",
                              icon: Icons.medical_services_outlined,
                              child: Container(
                                height: 150.0,
                                child: (appController.prescriptionsList.isEmpty)
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 50.0),
                                        child: Center(
                                          child: Text(
                                            "Aucune prescription!",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(
                                                color: Colors.redAccent,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            appController.prescriptionsList.length,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.all(5.0),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return PrescCard(
                                            prescription: appController
                                                .prescriptionsList[index].prescription,
                                            dosage: appController
                                                .prescriptionsList[index].dosage,
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> buildPdf() async {
    Xloading.show(context, "Chargement...");
    final pdf = pw.Document();
    final fontRegulars = await PdfGoogleFonts.openSansRegular();
    final fontBolds = await PdfGoogleFonts.openSansBold();
    final fontItalics = await PdfGoogleFonts.openSansItalic();

    pdf.addPage(
        // ignore: missing_required_param
        pw.MultiPage(
      header: pageHeader,
      footer: pageFooter,
      pageFormat: PdfPageFormat.a4,
      theme: pw.ThemeData.withFont(
        base: fontRegulars,
        bold: fontBolds,
        italic: fontItalics,
      ),
      build: (context) => [
        pw.Container(
            alignment: pw.Alignment.center,
            margin: pw.EdgeInsets.all(10.0),
            child: pw.Text("Fiche médicale du patient".toUpperCase(),
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 14.0,
                    fontWeight: pw.FontWeight.bold,
                    letterSpacing: 1.0))),
        pw.Center(
          child: pw.Container(
              alignment: pw.Alignment.center,
              color: PdfColors.black,
              width: 225.0,
              height: 1.50),
        ),
        pw.Container(
            width: 500,
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    bottom:
                        pw.BorderSide(width: 1.0, color: PdfColors.black))),
            alignment: pw.Alignment.centerLeft,
            padding: pw.EdgeInsets.all(10.0),
            margin: pw.EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: pw.Text(
                "${'Plainte'.toUpperCase()} : ${appController.strPlainte.toLowerCase()}",
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                    fontSize: 12.0,
                    fontWeight: pw.FontWeight.normal,
                    letterSpacing: 0.5))),
        _contentPatientIdentity(context),
        pw.SizedBox(height: 20.0),
        if (appController.signeVitauxList.isNotEmpty)
          _contentTableSignesVitaux(context),
        pw.SizedBox(height: 20.0),
        if (appController.histoireMaladieList.isNotEmpty)
          _contentTableHistoireMaladie(context),
        pw.SizedBox(height: 20.0),
        if (appController.examensPhysiqueList.isNotEmpty)
          _contentTableExamensPhysics(context),
        pw.SizedBox(height: 20.0),
        if (appController.examensLaboList.isNotEmpty)
          _contentTableExamensLabo(context),
        pw.SizedBox(height: 20.0),
        if (appController.prescriptionsList.isNotEmpty)
          _contentTablePrescriptions(context)
      ],
    ));
    List<int> bytes = await pdf.save();
    final file = await saveAndLaunchFile(bytes, 'doc.pdf');
    Xloading.dismiss();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PdfViewerPage(
                  file: file,
                  bytes: bytes,
                )));
  }

  pw.Widget _contentPatientIdentity(pw.Context context) {
    return pw.Container(
        padding: pw.EdgeInsets.only(bottom: 10.0),
        child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              contentTitle(title: "Identité du patient"),
              pw.SizedBox(height: 8.0),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          idItem(
                              label: "Nom",
                              value: appController.singlePatientDocList[0]),
                          idItem(
                              label: "Date de naissance",
                              value: appController.singlePatientDocList[1]),
                          idItem(label: "Lieu de naissance", value: "Kinshasa"),
                          idItem(
                              label: "Sexe",
                              value: appController.singlePatientDocList[3]),
                        ]),
                    pw.SizedBox(width: 10.0),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          idItem(
                              label: "Téléphone",
                              value: appController.singlePatientDocList[4]),
                          idItem(
                              label: "Adresse",
                              value: "30. av. kimbangu, Q.Kauka, Kalamu"),
                          idItem(label: "Province", value: "Kinshasa"),
                          idItem(label: "Ville", value: "Kinshasa"),
                        ])
                  ])
            ]));
  }

  pw.Widget _contentTableSignesVitaux(pw.Context context) {
    const tableHeaders = [
      'titre',
      'Valeur',
    ];
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          contentTitle(title: "Signes Vitaux"),
          pw.Table.fromTextArray(
            border: pw.TableBorder(
              horizontalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              verticalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              left: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              right: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              bottom: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              color: PdfColors.blue300,
            ),
            headerHeight: 30,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
            },
            headerStyle: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                letterSpacing: 2.0),
            cellStyle: const pw.TextStyle(
              color: PdfColors.black,
              fontSize: 10,
            ),
            headers: List<String>.generate(
              tableHeaders.length,
              (col) => tableHeaders[col].toUpperCase(),
            ),
            data: List<List<String>>.generate(
              appController.signeVitauxList.length,
              (row) => List<String>.generate(
                tableHeaders.length,
                (col) => appController.signeVitauxList[row].getIndex(col),
              ),
            ),
          )
        ]);
  }

  pw.Widget _contentTableHistoireMaladie(pw.Context context) {
    const tableHeaders = [
      'Question',
      'Reponse',
    ];
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          contentTitle(title: "Histoire maladie"),
          pw.Table.fromTextArray(
            border: pw.TableBorder(
              horizontalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              verticalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              left: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              right: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              bottom: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              color: PdfColors.blue300,
            ),
            headerHeight: 30,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
            },
            headerStyle: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                letterSpacing: 2.0),
            cellStyle: const pw.TextStyle(
              color: PdfColors.black,
              fontSize: 10,
            ),
            headers: List<String>.generate(
              tableHeaders.length,
              (col) => tableHeaders[col].toUpperCase(),
            ),
            data: List<List<String>>.generate(
              appController.histoireMaladieList.length,
              (row) => List<String>.generate(
                tableHeaders.length,
                (col) => appController.histoireMaladieList[row].getIndex(col),
              ),
            ),
          )
        ]);
  }

  pw.Widget _contentTableExamensPhysics(pw.Context context) {
    const tableHeaders = [
      'Designation',
      'Valeur',
    ];
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          contentTitle(title: "Examens physiques"),
          pw.Table.fromTextArray(
            border: pw.TableBorder(
              horizontalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              verticalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              left: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              right: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              bottom: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              color: PdfColors.blue300,
            ),
            headerHeight: 30,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
            },
            headerStyle: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                letterSpacing: 2.0),
            cellStyle: const pw.TextStyle(
              color: PdfColors.black,
              fontSize: 10,
            ),
            headers: List<String>.generate(
              tableHeaders.length,
              (col) => tableHeaders[col].toUpperCase(),
            ),
            data: List<List<String>>.generate(
              appController.examensPhysiqueList.length,
              (row) => List<String>.generate(
                tableHeaders.length,
                (col) => appController.examensPhysiqueList[row].getIndex(col),
              ),
            ),
          )
        ]);
  }

  pw.Widget _contentTableExamensLabo(pw.Context context) {
    const tableHeaders = [
      'Examen',
      'Résultat',
    ];
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          contentTitle(title: "Examens Labo"),
          pw.Table.fromTextArray(
            border: pw.TableBorder(
              horizontalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              verticalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              left: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              right: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              bottom: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              color: PdfColors.blue300,
            ),
            headerHeight: 30,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
            },
            headerStyle: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                letterSpacing: 2.0),
            cellStyle: const pw.TextStyle(
              color: PdfColors.black,
              fontSize: 10,
            ),
            headers: List<String>.generate(
              tableHeaders.length,
              (col) => tableHeaders[col].toUpperCase(),
            ),
            data: List<List<String>>.generate(
              appController.examensLaboList.length,
              (row) => List<String>.generate(
                tableHeaders.length,
                (col) => appController.examensLaboList[row].getIndex(col),
              ),
            ),
          )
        ]);
  }

  pw.Widget _contentTablePrescriptions(pw.Context context) {
    const tableHeaders = [
      'Médicament',
      'Dosage',
    ];
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          contentTitle(title: "Prescriptions"),
          pw.Table.fromTextArray(
            border: pw.TableBorder(
              horizontalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              verticalInside:
                  pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              left: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              right: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
              bottom: pw.BorderSide(color: PdfColors.blue300, width: 1.0),
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              color: PdfColors.blue300,
            ),
            headerHeight: 30,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
            },
            headerStyle: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                letterSpacing: 2.0),
            cellStyle: const pw.TextStyle(
              color: PdfColors.black,
              fontSize: 10,
            ),
            headers: List<String>.generate(
              tableHeaders.length,
              (col) => tableHeaders[col].toUpperCase(),
            ),
            data: List<List<String>>.generate(
              appController.prescriptionsList.length,
              (row) => List<String>.generate(
                tableHeaders.length,
                (col) => appController.prescriptionsList[row].getIndex(col),
              ),
            ),
          )
        ]);
  }

  pw.Widget contentTitle({String title}) {
    return pw.Container(
        decoration: pw.BoxDecoration(color: PdfColors.black),
        width: 500.0,
        padding: pw.EdgeInsets.all(8.0),
        margin: pw.EdgeInsets.only(bottom: 10.0),
        child: pw.Text("${title.toUpperCase()}",
            style: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
                letterSpacing: 2.0,
                fontSize: 10.0)));
  }

  pw.Widget idItem({String label, String value}) {
    return pw.Container(
        padding: pw.EdgeInsets.all(4.0),
        margin: pw.EdgeInsets.only(bottom: 2),
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('${label.toUpperCase()} : ',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                      fontSize: 11.0)),
              pw.Text('$value',
                  style:
                      pw.TextStyle(color: PdfColors.grey900, fontSize: 11.0)),
            ]));
  }

  pw.Widget pageHeader(pw.Context context) {
    if (context.pageNumber == 1) {
      return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          decoration: const pw.BoxDecoration(
              border: pw.Border(
                  bottom: pw.BorderSide(width: 2.0, color: PdfColors.red800))),
          child: pw.Column(
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Container(
                          height: 50,
                          padding: const pw.EdgeInsets.only(left: 20),
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '$hospitalName',
                            style: pw.TextStyle(
                              color: PdfColors.red800,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Text('Date: ${formatDate(DateTime.now())}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.normal))
                ],
              ),
            ],
          ));
    } else {
      return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          decoration: const pw.BoxDecoration(
              border: pw.Border(
                  bottom: pw.BorderSide(width: 0.5, color: PdfColors.grey))),
          child: pw.Text('Dossier médical du patient',
              style: pw.Theme.of(context)
                  .defaultTextStyle
                  .copyWith(color: PdfColors.grey)));
    }
  }

  pw.Widget pageFooter(pw.Context context) {
    return pw.Container(
        decoration: pw.BoxDecoration(
            border: pw.Border(
                top: pw.BorderSide(width: 0.30, color: PdfColors.black))),
        child: pw.Stack(children: [
          pw.Container(
            height: 50,
            width: 100,
            alignment: pw.Alignment.bottomLeft,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.BarcodeWidget(
              barcode: pw.Barcode.pdf417(),
              data: 'fiche# 12345',
              drawText: false,
            ),
          ),
          pw.Container(
              alignment: pw.Alignment.topLeft,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text('Produit par Rapidos Technology Group. RDC',
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                      color: PdfColors.grey,
                      fontStyle: pw.FontStyle.normal,
                      fontSize: 10.0))),
          pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text(
                  'Page ${context.pageNumber} sur ${context.pagesCount}',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.black, fontSize: 10.0)))
        ]));
  }

  String formatDate(DateTime date) {
    final format = DateFormat.yMMMd('fr_FR');
    return format.format(date);
  }
}

class GAccordion extends StatelessWidget {
  final Widget child;
  final String title;
  final IconData icon;
  final int primaryColorIndex;

  const GAccordion({Key key, this.title, this.icon, this.child, this.primaryColorIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
      child: ScrollOnExpand(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5.0,
              shadowColor: Colors.black26,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      fadeCurve: Curves.bounceIn,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: false,
                    ),
                    header: Container(
                      width: MediaQuery.of(context).size.width,
                      
                      decoration: BoxDecoration(
                        color: Colors
                            .primaries[primaryColorIndex]
                            .shade900,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: Text(
                                  title.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: CupertinoIcons.chevron_down,
                                collapseIcon: CupertinoIcons.chevron_up,
                                iconColor: Colors.white,
                                iconSize: 20.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    collapsed: Container(),
                    expanded: child,
                  ),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors
                        .primaries[primaryColorIndex]
                        .shade900,
                  )
                ],
              ),
            ),
            Positioned(
              top: -20,
              left: 10,
              child: Container(
                height: 70.0,
                width: 70.0,
                child: Card(
                  color: Colors
                      .primaries[primaryColorIndex]
                      .shade800,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 10,
                  shadowColor: Colors.black54,
                  child: Icon(icon, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

/*Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    margin: EdgeInsets.zero,
    child: ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1, //appController.consultationList,
      itemBuilder: (__, _) {
        //var list = appController.consultationList[index];
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 6),
                  color: lightGrey.withOpacity(.1),
                  blurRadius: 12.0)
            ],
          ),
          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 6),
                          color: lightGrey.withOpacity(.1),
                          blurRadius: 12.0)
                    ],
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.blue[900], width: 1)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Plainte de la consultation :",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Colors.grey[800]),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("${appController.strPlainte}",
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0,
                                      color: Colors.blue[800])),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                        "${appController.strDateDoc}",
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.0,
                                            color: Colors.grey[800])),
                                  )),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Row(
                              children: [
                                FlatButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20.0)),
                                    onPressed: buildPdf,
                                    child: Text("Exporter en pdf")),
                                SizedBox(
                                  width: 8.0,
                                ),
                                FlatButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Retour")),
                              ],
                            ))
                      ],
                    ),
                  )),
              CTitle(
                title: "Signes vitaux",
              ),
              Container(
                height: 150.0,
                child: ListView.builder(
                  itemCount: appController.signeVitauxList.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(5.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SignCard(
                      title: appController.signeVitauxList[index].titre,
                      value: appController
                          .signeVitauxList[index].signeVitalValeur,
                    );
                  },
                ),
              ),
              CTitle(
                title: "Histoire maladie",
              ),
              Container(
                height: 180.0,
                child: ListView.builder(
                  itemCount: appController.histoireMaladieList.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(5.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return StoryCard(
                      question: appController
                          .histoireMaladieList[index].question,
                      reponse: appController
                          .histoireMaladieList[index].reponse,
                    );
                  },
                ),
              ),
              CTitle(
                title: "Examens physiques",
              ),
              Container(
                height: 150.0,
                child: ListView.builder(
                  itemCount: appController.examensPhysiqueList.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(5.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ExamenCard(
                      examenTitle: appController
                          .examensPhysiqueList[index].donneeLabel,
                      examenValue: appController
                          .examensPhysiqueList[index].donneeValeur,
                    );
                  },
                ),
              ),
              CTitle(
                title: "Examens Laboratoires",
              ),
              Container(
                height: 100.0,
                child: ListView.builder(
                  itemCount: appController.examensLaboList.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(5.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return LaboCard(
                      examTitle:
                      appController.examensLaboList[index].examen,
                    );
                  },
                ),
              ),
              CTitle(
                title: "Prescriptions",
              ),
              Container(
                height: 150.0,
                child: ListView.builder(
                  itemCount: appController.prescriptionsList.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(5.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PrescCard(
                      prescription: appController
                          .prescriptionsList[index].prescription,
                      dosage:
                      appController.prescriptionsList[index].dosage,
                    );
                  },
                ),
              ),
            ],
          )),
        );
      },
    ),
  );
}
 */
