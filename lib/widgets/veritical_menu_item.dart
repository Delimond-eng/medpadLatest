import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/constants/style.dart';

class VeriticalMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;
  const VeriticalMenuItem({Key key, this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(
          () => Container(
            color: menuController.isHovering(itemName)
                ? primaryColor.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) ||
                      menuController.isActive(itemName),
                  child: Container(
                    width: 3,
                    height: 80,
                    color: primaryColor,
                  ),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: menuController.returnIconFor(itemName),
                    ),
                    if (!menuController.isActive(itemName))
                      Flexible(
                        child: Text(
                          itemName,
                          style: TextStyle(
                              color: menuController.isHovering(itemName)
                                  ? primaryColor
                                  : lightGrey,
                              fontSize: 12.0),
                        ),
                      )
                    else
                      Flexible(
                        child: Text(
                          itemName,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
