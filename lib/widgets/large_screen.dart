import 'package:flutter/material.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/local_navigator.dart';
import 'package:medpad/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SideMenu()),
        Expanded(
            flex: 5,
            child: Container(
                decoration: BoxDecoration(
                  color: light,
                ),
                child: localNavigator()))
      ],
    );
  }
}
