import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medpad/constants/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:avatar_glow/avatar_glow.dart';

class FingerPrintControl extends StatelessWidget {
  final bool isActive;
  final Function onPressed;
  final String title;
  final String strImage;
  final bool isLoading;

  const FingerPrintControl(
      {Key key,
      this.isActive = false,
      this.onPressed,
      this.title,
      this.isLoading = false,
      this.strImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(
                color: isActive ? Colors.green[700] : Colors.purple,
                width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(30),
                child: (isLoading == true && isActive == false)
                    ? SpinKitCircle(
                        color: Colors.purple,
                        size: 70.0,
                      )
                    : (isLoading == false && isActive == true)
                        ? Center(child: imageFromBase64String(strImage))
                        : Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Lottie.asset(
                                "assets/lotties/4771-finger-print.json",
                                width: 150.0,
                                height: 150.0,
                                fit: BoxFit.cover,
                                animate: true),
                          ),
              ),
            ),
            SizedBox(height: 8.0,),
            FlatButton(
              minWidth: 200.0,
              height: 40.0,
              onPressed: onPressed,
              color: (isLoading == true && isActive == false)
                  ? Colors.brown
                  : (isLoading == false && isActive == true)
                  ? Colors.green[700]
                  : Colors.blue[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Text(title.toUpperCase(), style: GoogleFonts.mulish(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: Colors.white
              ),),
            )
          ],
        ));
  }
}
