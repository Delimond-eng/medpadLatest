import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image3.webp"), fit: BoxFit.fill),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(.9)),
          child: Container(
            child: Column(
              children: [
                Obx(() => Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: ResponsiveWidget.isSmallScreen(context)
                                  ? 56
                                  : 6),
                          child: Container(
                            margin: EdgeInsets.only(top: 35, left: 10),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.doc_fill,
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
                Expanded(
                  child: Container(
                    child: SfPdfViewer.asset("assets/docs/privacy.pdf"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            label: Text(
              "Imprimer",
              style: GoogleFonts.mulish(color: Colors.white),
            ),
            icon: Icon(Icons.print),
            backgroundColor: Colors.blue[800],
            onPressed: () async {
              try {
                //await FlutterPdfPrinter.printFile(widget.file.path);
              } catch (err) {
                // ignore: avoid_print
                print("error from ******$err");
              }
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          FloatingActionButton.extended(
            label: Text(
              "Retour    ",
              style: GoogleFonts.mulish(color: Colors.white),
            ),
            icon: Icon(CupertinoIcons.return_icon),
            backgroundColor: Colors.blue[800],
            onPressed: () {
              Navigator.pop(context);
              menuController.activeItem.value = "";
            },
          ),
        ],
      ),
    );
  }
}
