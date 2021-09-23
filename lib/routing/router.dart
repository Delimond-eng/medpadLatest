import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medpad/pages/consultation/consultation_page_view.dart';
import 'package:medpad/pages/dashboard/dashboard_page.dart';
import 'package:medpad/pages/hospital/hospital_page.dart';
import 'package:medpad/pages/hospitalisations/hospitalisation_page_view.dart';
import 'package:medpad/pages/labo/labo_page.dart';
import 'package:medpad/pages/maps/maps_page.dart';
import 'package:medpad/pages/personal/personal_page.dart';
import 'package:medpad/pages/privacy/info_page.dart';
import 'package:medpad/pages/statistics/statistic_page.dart';
import 'package:medpad/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashBoardPageRoute:
      return _getPageRoute(DashBoardPageView());
    case ConsultationPageRoute:
      return _getPageRoute(ConsultationPageView());
    case PersonalManagementPageRoute:
      return _getPageRoute(PersonalManagerPageView());
    case MapPathologyPageRoute:
      return _getPageRoute(MapsPageView());
    case strHospitalisation:
      return _getPageRoute(HospitalisationPageView());
    case StrHospitalPageRoute:
      return _getPageRoute(HospitalManagerPageView());
    case LaboratoryPageRoute:
      return _getPageRoute(LaboratoryPageView());
    case StatisticPathologyPageRoute:
      return _getPageRoute(StatisticsPageView());
    case StrPrivacy:
      return _getPageRoute(InfoPage());
    default:
      return _getPageRoute(DashBoardPageView());
  }
}

PageRoute _getPageRoute(Widget child) {
  return SlideRightRoute(page: child);
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
