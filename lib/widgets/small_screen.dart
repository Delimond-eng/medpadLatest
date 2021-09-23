import 'package:flutter/material.dart';
import 'package:medpad/helpers/local_navigator.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: localNavigator()
    );
  }
}
