import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/auth/authenticate_page_route.dart';
import 'package:medpad/routing/routes.dart';
import 'package:medpad/widgets/app_title.dart';
import 'package:medpad/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      color: bgColor,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context) ||
              ResponsiveWidget.isCustomScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: _width / 48,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.circle,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    Flexible(child: AppTitle()),
                    SizedBox(
                      width: _width / 48,
                    )
                  ],
                ),
              ],
            ),
          SizedBox(
            height: 20.0,
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((itemName) => SideMenuItem(
                        itemName: itemName == StrAuthenticationPageRoute
                            ? "Deconnexion"
                            : itemName,
                        onTap: () {
                          if (itemName == StrAuthenticationPageRoute) {
                            XDialog.show(
                                context: context,
                                content:
                                    "Etes-vous sûr \n de vouloir vous deconnecter de votre compte ?",
                                title: "Deconnection",
                                icon: Icons.person,
                                onValidate: () {
                                  storage.remove("isLoggedIn");
                                  Get.offAll(AuthenticationPageRoute());
                                  menuController
                                      .changeActiveitemTo(DashBoardPageRoute);
                                });
                          }
                          if (!menuController.isActive(itemName)) {
                            menuController.changeActiveitemTo(itemName);

                            if (ResponsiveWidget.isCustomScreen(context) ||
                                ResponsiveWidget.isCustomScreen(context))
                              Get.back();

                            navigationController.navigateTo(itemName);
                          }
                          if (itemName == StrScanning) {
                            apiController.loadFingers(type: "patient");
                            appController.showScan(context);
                          }

                          if (itemName == strHospitalisation) {
                            apiController.loadFingers(type: "medecin");
                          }

                          if (itemName == ConsultationPageRoute) {
                            apiController.loadFingers(type: "medecin");
                          }
                          if (itemName != StrScanning) {
                            appController.closeUsbDevice();
                          }
                          apiController.cleanData();
                          apiController.loadData();
                          appController.loadDatas();
                        },
                      ))
                  .toList())
        ],
      ),
    );
  }
}
