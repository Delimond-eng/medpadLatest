import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class DashCardSmall extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  final IconData icon;
  final bool isActive;
  final Function press;

  const DashCardSmall(
      {Key key,
      this.title,
      this.value,
      this.topColor,
      this.icon,
      this.isActive = false,
      this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          onTap: press,
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isActive ? primaryColor : lightGrey,
                width: .5
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                  style: GoogleFonts.mulish(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    color: isActive ? primaryColor : lightGrey
                  ),
                ),
                Text(title,
                  style: GoogleFonts.mulish(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: isActive ? primaryColor : lightGrey
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
