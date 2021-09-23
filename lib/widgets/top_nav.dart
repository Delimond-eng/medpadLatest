import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/auth/authenticate_page_route.dart';
import 'package:medpad/widgets/app_title.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  var _storage = GetStorage();

  return AppBar(
    leading: ResponsiveWidget.isLargeScreen(context)
        ? Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.circle, color: primaryColor, size: 20))
            ],
          )
        : ResponsiveWidget.isCustomScreen(context)
            ? IconButton(
                onPressed: () {
                  key.currentState.openDrawer();
                },
                icon: Icon(Icons.menu_rounded))
            : IconButton(
                onPressed: () {
                  key.currentState.openDrawer();
                },
                icon: Icon(Icons.menu_rounded)),
    elevation: 0,
    title: Row(
      children: [
        Visibility(
          child: Obx(() => Text(
                "${menuController.activeItem.value}",
                style: GoogleFonts.mulish(
                    color: Colors.grey[100],
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0),
              )),
        ),
        Expanded(
          child: Container(),
          flex: 5,
        ),
        Container(
          width: 1,
          height: 22,
          color: lightGrey,
        ),
        SizedBox(
          width: 24,
        ),
        Text(
          _storage.read("hospital_name") ?? "Hospital admin",
          style: TextStyle(
              color: lightGrey, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.all(2),
          child: CircleAvatar(
              backgroundColor: light,
              child: popMenu(context, icon: Icons.more_vert_rounded)),
        )
      ],
    ),
    iconTheme: IconThemeData(color: light),
    backgroundColor: ResponsiveWidget.isLargeScreen(context)
        ? Colors.transparent
        : ResponsiveWidget.isMediumScreen(context)
            ? bgColor
            : bgColor,
  );
}

void logout(context) {
  XDialog.show(
      context: context,
      icon: CupertinoIcons.question,
      content:
          "Etes-vous sûr de vouloir vous\ndeconnectez de votre compte medpad ?",
      title: "Déconnexion",
      onValidate: () {
        storage.remove("isLoggedIn");
        Get.offAll(AuthenticationPageRoute());
      });
}

void exitApp(context) {
  XDialog.show(
      context: context,
      icon: CupertinoIcons.question,
      content: "voulez-vous vraiment quitter cette application ?",
      title: "Fermeture",
      onValidate: () {
        exit(0);
      });
}

Widget popMenu(BuildContext context, {IconData icon}) {
  return PopupMenuButton(
      icon: Icon(
        icon,
        color: darker,
        size: 20,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onSelected: (value) {
        switch (value) {
          case 1:
            logout(context);
            break;
          case 2:
            exitApp(context);
            break;
          default:
            print("not selected");
        }
      },
      itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(
                        Icons.exit_to_app,
                        size: 20,
                        color: darker,
                      ),
                    ),
                    Text(
                      'Déconnexion',
                      style: GoogleFonts.mulish(color: darker, fontSize: 14.0),
                    )
                  ],
                )),
            PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: darker,
                      ),
                    ),
                    Text(
                      "Quitter",
                      style: GoogleFonts.mulish(color: darker, fontSize: 14.0),
                    )
                  ],
                )),
          ]);
}
