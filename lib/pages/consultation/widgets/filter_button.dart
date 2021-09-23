import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class FilterButton extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final String title;
  final Function onPressed;
  const FilterButton(
      {Key key, this.isActive = false, this.icon, this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: isActive == false ? Colors.transparent : primaryColor,
          borderRadius: BorderRadius.circular(25.0)),
      // ignore: deprecated_member_use
      child: OutlineButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          borderSide: BorderSide(width: 1, color: primaryColor),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive == false ? primaryColor : Colors.white,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: GoogleFonts.mulish(
                    color: isActive == false ? primaryColor : Colors.white,
                    fontWeight: isActive == false
                        ? FontWeight.normal
                        : FontWeight.w600, fontSize: 13.0),
              )
            ],
          ),
          onPressed: onPressed),
    );
  }
}
