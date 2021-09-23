import 'package:flutter/material.dart';
import 'package:medpad/helpers/responsiveness.dart';
import 'package:medpad/widgets/horizontal_menu_item.dart';
import 'package:medpad/widgets/veritical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;
  const SideMenuItem({Key key, this.itemName, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*if (ResponsiveWidget.isCustomScreen(context))
      
    return HorizontalMenuItem(
      itemName: itemName,
      onTap: onTap,
    );*/ ///
    return VeriticalMenuItem(
      itemName: itemName,
      onTap: onTap,
    );
  }
}
