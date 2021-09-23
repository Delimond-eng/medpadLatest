import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/patient/pages/patient_tab_page.dart';
import 'package:medpad/pages/patient/patient_tab_pages/pdfs/pdf_viewer_page.dart';
import 'package:ota_update/ota_update.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StatisticsPageView extends StatefulWidget {
  @override
  _StatisticsPageViewState createState() => _StatisticsPageViewState();
}

class _StatisticsPageViewState extends State<StatisticsPageView> {
  var hospitalName = storage.read("hospital_name");
  OtaEvent currentEvent;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: Container(
                    margin: EdgeInsets.only(top: 35, left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.trending_down_rounded, color: primaryColor),
                        Text(
                          "${menuController.activeItem.value}",
                          style: GoogleFonts.mulish(
                              color: primaryColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
        Center(
            child: FlatButton(
                color: Colors.blue[900],
                onPressed: () {
                  appController.singlePatientDocList.value = [
                    "Gaston Delimond",
                    "Developper",
                    "M",
                    "Lorem ipsum",
                    "Lorem ipsum"
                  ];
                  menuController.activeItem.value = "Dossier médical";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientTabPage()));
                },
                child: Text("Medical Docs",
                    style: TextStyle(color: Colors.white)))),
        SizedBox(
          height: 10.0,
        ),
        Center(
            child: FlatButton(
                color: Colors.blue[900],
                onPressed: buildPdf,
                child: Text(
                  "Pdf creating",
                  style: TextStyle(color: Colors.white),
                ))),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Future<void> buildPdf() async {
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
        _contentPatientIdentity(context),
        pw.SizedBox(height: 10.0),
        _contentTable(context),
      ],
    ));
    List<int> bytes = await pdf.save();
    final file = await saveAndLaunchFile(bytes, 'doc.pdf');
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
                          idItem(label: "Nom", value: "Gaston delimond"),
                          idItem(
                              label: "Date de naissance", value: "20/12/1994"),
                          idItem(label: "Lieu de naissance", value: "Kinshasa"),
                          idItem(label: "Sexe", value: "M"),
                        ]),
                    pw.SizedBox(width: 10.0),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          idItem(
                              label: "Téléphone", value: "(+243) 81 371 99 44"),
                          idItem(
                              label: "Adresse",
                              value: "30. av. kimbangu, Q.Kauka, Kalamu"),
                          idItem(label: "Province", value: "Kinshasa"),
                          idItem(label: "Ville", value: "Kinshasa"),
                        ])
                  ])
            ]));
  }

  pw.Widget _contentTable(pw.Context context) {
    final lorem = pw.LoremText();

    final Signs = <Sign>[
      Sign(lorem.sentence(4), lorem.sentence(4)),
      Sign(lorem.sentence(4), lorem.sentence(4)),
      Sign(lorem.sentence(4), lorem.sentence(4)),
      Sign(lorem.sentence(4), lorem.sentence(4)),
      Sign(lorem.sentence(4), lorem.sentence(4)),
      Sign(lorem.sentence(4), lorem.sentence(4)),
      Sign(lorem.sentence(4), lorem.sentence(4)),
      Sign(lorem.sentence(4), lorem.sentence(4)),
    ];
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
                  pw.BorderSide(color: PdfColors.blue50, width: 1.0),
              verticalInside:
                  pw.BorderSide(color: PdfColors.blue50, width: 1.0),
              left: pw.BorderSide(color: PdfColors.blue50, width: 1.0),
              right: pw.BorderSide(color: PdfColors.blue50, width: 1.0),
              bottom: pw.BorderSide(color: PdfColors.blue50, width: 1.0),
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              color: PdfColors.blue50,
            ),
            headerHeight: 25,
            cellHeight: 30,
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
              Signs.length,
              (row) => List<String>.generate(
                tableHeaders.length,
                (col) => Signs[row].getIndex(col),
              ),
            ),
          )
        ]);
  }

  pw.Widget contentTitle({String title}) {
    return pw.Container(
        decoration: pw.BoxDecoration(
            color: PdfColors.blue50,
            border: pw.Border(
              left: pw.BorderSide(color: PdfColors.blue900, width: 2.0),
            )),
        width: 500.0,
        padding: pw.EdgeInsets.all(8.0),
        margin: pw.EdgeInsets.only(bottom: 10.0),
        child: pw.Text("${title.toUpperCase()}",
            style: pw.TextStyle(
                color: PdfColors.black,
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
                top: pw.BorderSide(width: 0.5, color: PdfColors.grey))),
        child: pw.Stack(children: [
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

class Sign {
  const Sign(this.signName, this.signValue);

  final String signName;
  final String signValue;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return signName;
      case 1:
        return signValue;
    }
    return '';
  }
}
