import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/auth/login/login_screen.dart';
import 'package:medpad/pages/auth/register/register_screen.dart';

class AuthenticationPageRoute extends StatefulWidget {
  AuthenticationPageRoute({Key key}) : super(key: key);

  @override
  _AuthenticationPageRouteState createState() =>
      _AuthenticationPageRouteState();
}

class _AuthenticationPageRouteState extends State<AuthenticationPageRoute> {
  bool isSignUpScreen = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _size.height,
        width: _size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.cover,
                image: AssetImage("assets/images/authbg.png"))),
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LogoTitle(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: isSignUpScreen ? _size.width / 1.50 : _size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 6),
                          color: bgColor.withOpacity(.1),
                          blurRadius: 12.0)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: isSignUpScreen ? _size.width / 1.50 : _size.width / 2,
                        height: 50.0,
                        child: Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignUpScreen = false;
                                  });
                                },
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: isSignUpScreen == false
                                          ? Colors.transparent
                                          : secondaryColor.withOpacity(.5),
                                      border: Border(
                                          top: BorderSide(
                                              color: isSignUpScreen == false
                                                  ? primaryColor
                                                  : Colors.transparent,
                                              width: 3))),
                                  child: Center(
                                    child: Text(
                                      'Connexion'.toUpperCase(),
                                      style: GoogleFonts.mulish(
                                          color: isSignUpScreen == false
                                              ? Colors.blue[900]
                                              : Colors.white,
                                          fontWeight: isSignUpScreen == false
                                              ? FontWeight.w600
                                              : FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignUpScreen = true;
                                  });
                                },
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: isSignUpScreen == true
                                          ? Colors.transparent
                                          : secondaryColor.withOpacity(.5),
                                      border: Border(
                                          top: BorderSide(
                                              color: isSignUpScreen == true
                                                  ? primaryColor
                                                  : Colors.transparent,
                                              width: 3))),
                                  child: Center(
                                      child: Text('Souscription'.toUpperCase(),
                                          style: GoogleFonts.mulish(
                                              color: isSignUpScreen == true
                                                  ? Colors.blue[900]
                                                  : Colors.white,
                                              fontWeight: isSignUpScreen == true
                                                  ? FontWeight.w600
                                                  : FontWeight.w400))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: (isSignUpScreen == false)
                            ? LoginScreen()
                            : RegisterScreen(
                                onSuccess: () {
                                  setState(() {
                                    isSignUpScreen = false;
                                  });
                                },
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoTitle extends StatelessWidget {
  const LogoTitle({
    Key key,
  }) : super(key: key);

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
                color: Colors.white,
                fontSize: 35.0,
                letterSpacing: .1,
                shadows: [
                  Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 2),
                      blurRadius: 10)
                ])),
        Text("Pad",
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.w900,
                color: Colors.pink,
                fontSize: 35.0,
                letterSpacing: .1,
                shadows: [
                  Shadow(
                      color: Colors.black, offset: Offset(0, 2), blurRadius: 10)
                ])),
      ],
    );
  }
}
