import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/layout.dart';
import 'package:medpad/pages/auth/authenticate_page_route.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = storage.read("isLoggedIn");

  @override
  void initState() {
    super.initState();
    loadDataEndGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.cover,
                image: AssetImage("assets/images/splash.png"))),
        child: Container(
          margin: EdgeInsets.only(top: 200.0),
          alignment: Alignment.center,
          child: Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
              size: 80.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadDataEndGo() async {
    await appController.loadDatas();
    await apiController.loadData();

    if (isLoggedIn == false || isLoggedIn == null) {
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthenticationPageRoute()));
    } else {
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AppLayout()));
    }
  }
}

/*(isLoggedIn == false || isLoggedIn == null)
? AuthenticationPageRoute()
    : AppLayout()
);*/
