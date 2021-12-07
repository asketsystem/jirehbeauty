import 'dart:async';
import 'package:barber_app/screens/homescreen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// import 'package:barber_app/screens/loginscreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:flutter/material.dart';

import 'constant/preferenceutils.dart';

Future<void> main() async {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new HomeScreen(1),
      // '/HomeScreen': (BuildContext context) => new EditProfileInformation()
      // '/LoginScreen': (BuildContext context) => new LoginScreen()
    },
  ));
  //for stripe
  Stripe.publishableKey = "demo";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => new HomeScreen(0)));
    // Navigator.of(context).pushReplacementNamed('/HomeScreen');

    // bool login = PreferenceUtils.getlogin(AppConstant.isLoggedIn);
    //  print("loginStatus:$login");
    //
    //
    //
    //
    //
    //  if(login == true){
    //
    //
    //  }else if(login == false){
    //
    //    Navigator.of(context).pushReplacementNamed('/LoginScreen');
    //
    //  }else if(login == null){
    //
    //    Navigator.of(context).pushReplacementNamed('/LoginScreen');
    //  }

    //
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    PreferenceUtils.init();
    initPlatformState();

// For each of the above functions, you can also pass in a
// reference to a function as well:

    checkforpermission();
  }

  void checkforpermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // permission = await Geolocator.requestPermission();
      print("denied");
      startTime();
    } else if (permission == LocationPermission.whileInUse) {
      print("whileInUse56362");

      startTime();
    } else if (permission == LocationPermission.always) {
      print("always");

      startTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        body: new Container(
          padding: EdgeInsets.only(bottom: 50),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('images/splash.png'),
              fit: BoxFit.fill,
            ),
          ),
          /* child: Stack(
          children: <Widget>[

            // Expanded(

                // child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 45.0,left: 70.0),
                        alignment: FractionalOffset.bottomLeft,

                        child: Text("The",
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w500,fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ],
                ),

            // ),

            // Expanded(
            //     child:
                Container(
                  margin: const EdgeInsets.only(top: 1.0,left: 110.0),


                  alignment: FractionalOffset.bottomLeft,
                  child: Text("BARBER.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.w700,fontFamily: 'Montserrat'),
                  ), )
            // )





          ],


        )*/
        ),
      ),
    );
  }

  Future<void> savetoken(String token) async {
    PreferenceUtils.setString(AppConstant.fcmtoken, token);

/*
    var preferences = await SharedPreferences.getInstance();// Save a value
    preferences.setString('fcmtoken', token);// Retrieve value later*/
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    //
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    //
    // // OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
    //
    // var settings = {
    //   OSiOSSettings.autoPrompt: false,
    //   OSiOSSettings.promptBeforeOpeningPushUrl: true
    // };
    //
    //
    // // NOTE: Replace with your own app ID from https://www.onesignal.com
    // await OneSignal.shared
    //     .init("29561882-aa25-43ef-b277-83a677b09524", iOSSettings: settings);
    //
    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared.consentGranted(true);
    await OneSignal.shared.setAppId(AppConstant.oneSignalAppKey);
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared.promptLocationPermission();
    var status = await OneSignal.shared.getDeviceState();
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    // var status = await OneSignal.shared.getPermissionSubscriptionState();
    var pushtoken = status!.userId!;
    print("pushtoken123456:$pushtoken");
    PreferenceUtils.setString(AppConstant.fcmtoken, pushtoken);
  }
}
