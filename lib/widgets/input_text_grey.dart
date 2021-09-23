import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/date_formater.dart';

class InputText extends StatelessWidget {
  final inputController;
  final String hintText;
  final IconData icon;
  final TextInputType keyType;
  final String title;
  final bool isRequired;
  final bool readOnly;
  final double radius;

  InputText({
    Key key,
    this.inputController,
    this.hintText,
    this.icon,
    this.keyType,
    this.title,
    this.isRequired = false,
    this.readOnly = false,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Text(
                "$title",
                style: TextStyle(color: bgColor, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 5,
              ),
              if (isRequired == true)
                Text(
                  "*",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0),
                ),
            ],
          ),
        if (title != null)
          SizedBox(
            height: 10,
          ),
        Container(
          padding: EdgeInsets.all(10),
          height: 50.0,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                bottom: BorderSide(
                    color: primaryColor,
                    width: 2
                )
              )),
          child: keyType != TextInputType.datetime
              ? TextField(
                  readOnly: readOnly,
                  focusNode: FocusNode(),
                  controller: inputController,
                  style: TextStyle(fontSize: 14.0),
                  keyboardType: keyType == null ? TextInputType.text : keyType,
                  decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                    hintStyle: TextStyle(color: Colors.black38),
                    icon: Container(
                      padding: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.grey[300], width: 2))),
                      child: Icon(
                        icon,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                )
              : TextField(
                  // maxLength: 10,
                  keyboardType: TextInputType.datetime,
                  controller: inputController,
                  decoration: InputDecoration(
                    hintText: 'JJ / MM / YYYY',
                    hintStyle: TextStyle(color: Colors.black38),
                    contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                    icon: Icon(
                      icon,
                      color: primaryColor,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  inputFormatters: [
                    // ignore: deprecated_member_use
                    WhitelistingTextInputFormatter(RegExp("[0-9/]")),
                    LengthLimitingTextInputFormatter(10),
                    DateFormatter(),
                  ],
                ),
        ),
      ],
    );
  }
}
