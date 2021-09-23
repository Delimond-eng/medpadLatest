import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/widgets/page_title.dart';

class SubPageHeader extends StatelessWidget {
  final IconData icon;
  final Function onClose;
  SubPageHeader({Key key, this.icon, this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, bottom: 10),
      child: Row(
        children: [
          Obx(() => PageTitle(
                icon: icon,
                title: "${menuController.activeItem.value}",
              ))
        ],
      ),
    );
  }
}
