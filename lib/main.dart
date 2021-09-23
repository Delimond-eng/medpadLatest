import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/controllers/api_controller.dart';
import 'package:medpad/controllers/app_controller.dart';
import 'package:medpad/controllers/menu_controller.dart';
import 'package:medpad/controllers/navigation_controller.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medpad/pages/splash_screen.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants/style.dart';
import 'services/api_manager_service.dart';

void main() async {
  await GetStorage.init();
  // You can request multiple permissions at once.
  await grantedPermission();
  await checkDevice();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
  Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(ApiController());
  Get.put(AppController());
  //await checkAppVersionAndUpdate();
  runApp(MyApp());
}

Future<void> checkDevice() async {
  var device = storage.read("device_id");
  if (device == null || device == "") {
    await ApiManagerService.checkDevice();
  }
}

Future<void> grantedPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.speech,
    Permission.microphone,
    Permission.storage,
    Permission.mediaLibrary,
    Permission.manageExternalStorage,
    Permission.phone
  ].request();

  print(statuses[Permission.speech]);
}

//// all process for updating app without using play store ////
OtaEvent currentEvent;
Future<void> tryOtaUpdate(String link) async {
  try {
    //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
    OtaUpdate()
        .execute('$link', destinationFilename: 'medpad.apk'
            //FOR NOW ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
            //sha256checksum: 'd6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478',
            )
        .listen(
      (OtaEvent event) {
        currentEvent = event;
      },
    );
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    print('ota update failed');
  }
}

Stream<int> startTasks(Duration interval) async* {
  final PackageInfo info = await PackageInfo.fromPlatform();
  int version = int.parse(info.buildNumber);
  // ignore: close_sinks
  var controller = StreamController<int>();
  int appVersion = version;
  void tick(Timer timer) {
    controller.add(appVersion); // Ask stream to send counter values as event.
  }

  Timer.periodic(interval, tick); // BAD: Starts before it has subscribers.
  yield* controller.stream;
}

Future<void> checkAppVersionAndUpdate() async {
  var liveCheckVersion = startTasks(const Duration(seconds: 60));
  liveCheckVersion.listen((int appVersion) async {
    await ApiManagerService.checkAppVersion(versionCode: appVersion)
        .then((jsonResult) {
      var status = jsonResult["update"]["status"];
      if (status == "pending") {
        print("version $appVersion");
        String apk = jsonResult["update"]['apk'];
        tryOtaUpdate(apk);
      } else {
        print("current version $status $appVersion");
      }
    });
  });
}
//// End process for updating ////

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        defaultTransition: Transition.fade,
        popGesture: Get.isPopGestureEnable,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('fr'), // French
        ],
        title: "medPad",
        theme: ThemeData(
                scaffoldBackgroundColor: light,
                textTheme: GoogleFonts.mulishTextTheme(Theme.of(context)
                        .textTheme
                        .apply(bodyColor: Colors.black)) ??
                    Theme.of(context).textTheme.apply(bodyColor: Colors.black),
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
                }),
                primaryColor: Colors.blue)
            .copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        home: SplashScreen());
  }
}
