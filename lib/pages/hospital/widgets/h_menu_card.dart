import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class HospitalMenuCard extends StatelessWidget {
  final String title;
  final String icon;
  final Function press;

  const HospitalMenuCard({Key key, this.title, this.press, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      shadowColor: Colors.grey[200],
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: primaryColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          splashColor: Colors.blue[200],
          onTap: press,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        icon,
                        alignment: Alignment.center,
                        color: Colors.white,
                        fit: BoxFit.cover,
                        height: 70.0,
                        width: 70.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(title,
                          style: GoogleFonts.mulish(
                              color: Colors.white, fontSize: 16.0)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
