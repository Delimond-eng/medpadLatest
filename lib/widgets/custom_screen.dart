import 'package:flutter/material.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/local_navigator.dart';

class CostumScreen extends StatelessWidget {
  const CostumScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
