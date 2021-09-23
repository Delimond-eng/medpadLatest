import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/routing/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = DashBoardPageRoute.obs;
  var hoverItem = "".obs;

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case DashBoardPageRoute:
        return _customIcon(Icons.dashboard_rounded, itemName);
      case ConsultationPageRoute:
        return _customIcon(Icons.accessibility_new_rounded, itemName);
      case PersonalManagementPageRoute:
        return _customIcon(CupertinoIcons.person_fill, itemName);
      case StrScanning:
        return _customIcon(Icons.person_search, itemName);
      case MapPathologyPageRoute:
        return _customIcon(CupertinoIcons.map_pin_ellipse, itemName);
      case strHospitalisation:
        return _customIcon(Icons.medical_services_rounded, itemName);

      case StrHospitalPageRoute:
        return _customIcon(Icons.medical_services_outlined, itemName);
      case StatisticPathologyPageRoute:
        return _customIcon(Icons.trending_down_rounded, itemName);
      case LaboratoryPageRoute:
        return _customIcon(Icons.biotech, itemName);
      case StrPrivacy:
        return _customIcon(CupertinoIcons.info_circle, itemName);
      case StrAuthenticationPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName))
      return Icon(
        icon,
        size: 22,
        color: primaryColor,
      );
    return Icon(
      icon,
      color: isHovering(itemName) ? primaryColor : lightGrey,
    );
  }
}
