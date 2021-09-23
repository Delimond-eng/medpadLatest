import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/widgets/custom_screen.dart';
import 'package:medpad/widgets/large_screen.dart';
import 'package:medpad/widgets/side_menu.dart';
import 'package:medpad/widgets/small_screen.dart';
import 'package:medpad/widgets/top_nav.dart';

import 'constants/style.dart';

class AppLayout extends StatefulWidget {
  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  StreamSubscription<DataConnectionStatus> listener;
  @override
  void initState() {
    super.initState();
    checkDataConnection();
  }

  Future<void> checkDataConnection() async {
    listener = DataConnectionChecker().onStatusChange.listen((status) async {
      if (status == DataConnectionStatus.disconnected) {
        XDialog.showErrorMessage(context,
            color: bgColor,
            title: "Pas d'internet !",
            message:
                "Pour medpad afribio,\nactivez les données mobiles ou connectez-vous au wifi");
        await Future.delayed(Duration(seconds: 5), () {
          exit(0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: Drawer(
          child: SideMenu(),
        ),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
              content: Text(
            'Cliquez encore pour quitter !!',
            textAlign: TextAlign.center,
          )),
          child: ResponsiveWidget(
            largeScreen: LargeScreen(),
            mediumScreen: CostumScreen(),
            smallScreen: SmallScreen(),
          ),
        ));
  }
}
