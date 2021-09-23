import 'package:flutter/material.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/routing/router.dart';
import 'package:medpad/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: DashBoardPageRoute,
      onGenerateRoute: generateRoute,
    );
