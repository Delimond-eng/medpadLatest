
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  final File file;
  final List<int> bytes;

  const PdfViewerPage({Key key, this.file, this.bytes}) : super(key: key);
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {

  Directory selectedDirectory;

  Future<void> _pickDirectory(BuildContext context) async {
    Directory directory = selectedDirectory;
    if (directory == null) {
      directory = Directory(FolderPicker.ROOTPATH);
    }
    else if(directory != null){
      directory = Directory(FolderPicker.ROOTPATH);
    }

    Directory newDirectory = await FolderPicker.pick(
      allowFolderCreation: true,
      context: context,
      barrierDismissible: false,
      rootDirectory: directory
    );
    setState(() {
      selectedDirectory = newDirectory;
    });

    XDialog.show(context: context,
        title: "Dossier ${selectedDirectory.path}",
        content: "Voulez vraiment enregistrer ce fichier dans le dossier sélectionné ?",
        icon: Icons.folder_open,
        onValidate: () async{
          final path = selectedDirectory.path;
          final file = File('$path/Fiche_${appController.singlePatientDocList[0]}_${DateTime.now()}.pdf');
          await file.writeAsBytes(widget.bytes, flush: true);
          Get.back(); 
          XDialog.showSuccessAnimation(context);
        }
    );
  }

  /*Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    Uint8List bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }*/

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
                                color: Colors.blue[900]),
                            Text(
                              "${menuController.activeItem.value}",
                              style: GoogleFonts.mulish(
                                  color: Colors.blue[900],
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
                    child: SfPdfViewer.file(widget.file),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(CupertinoIcons.arrow_down_doc_fill),
            onPressed: () async{
              try{
                _pickDirectory(context);
              }
              catch(err){
                // ignore: avoid_print
                print("error from ******$err");
              }
            },
          ),
          SizedBox(width: 5.0,),
          FloatingActionButton(
            child: Icon(CupertinoIcons.back, size: 15.0,),
            onPressed: (){
              Navigator.pop(context);
              menuController.activeItem.value ="";
            },
          ),
        ],
      ),
    );
  }
}
