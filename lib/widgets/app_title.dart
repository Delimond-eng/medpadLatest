import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle extends StatefulWidget {
  AppTitle({Key key}) : super(key: key);

  @override
  _AppTitleState createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Med",
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.w900,
                color: Color(0xFF2697FF),
                fontSize: 18.0,
                letterSpacing: .1,
                shadows: [
                  Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 2),
                      blurRadius: 1)
                ])),
        Text("Pad",
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 18.0,
                letterSpacing: .1,
                shadows: [
                  Shadow(
                      color: Colors.black, offset: Offset(0, 2), blurRadius: 1)
                ])),
      ],
    );
  }
}
