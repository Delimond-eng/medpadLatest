import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/pages/hospitalisations/pages/tabs/actes_tab.dart';
import 'package:medpad/pages/hospitalisations/pages/tabs/observations_tab.dart';
import 'package:medpad/pages/hospitalisations/pages/tabs/signes_vitaux_tab.dart';
import 'package:medpad/pages/hospitalisations/pages/tabs/traitement_tab.dart';
import 'package:medpad/pages/patient/widgets/tab_widget.dart';

class HospitalisationTabs extends StatefulWidget {
  @override
  _HospitalisationTabsState createState() => _HospitalisationTabsState();
}

class _HospitalisationTabsState extends State<HospitalisationTabs> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    List<Widget> _widgets = [
      SigneVitauxTab(),
      TraitementsTab(),
      ActesTab(),
      ObservationTab()
    ];

    List<Tab> _tabs = [
      Tab(
        icon: Icon(Icons.accessibility_new_rounded),
        text: "Signes vitaux",
        height: 60.0,
      ),
      Tab(
        icon: Icon(Icons.medical_services_rounded),
        text: "Traitements",
        height: 60.0,
      ),
      Tab(
        icon: Icon(CupertinoIcons.doc_on_clipboard_fill),
        text: "Actes",
        height: 60.0,
      ),
      Tab(
        icon: Icon(CupertinoIcons.doc_text_fill),
        text: "Observation",
        height: 60.0,
      ),
    ];


    return Container(
      width: _size.width,
      child: Column(
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

          Expanded(
            child: TabBarWidget(
              childs: _widgets,
              tabs: _tabs,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ],
      ),
    );
  }
}
