import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bottombar.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomeScreen(1),
  ));
}

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  int index;
  HomeScreen(this.index);

  @override
  _HomeScreen createState() => new _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String? name = "User";

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    PreferenceUtils.init();

    name = PreferenceUtils.getString(AppConstant.username);
    print("UserName:$name");

    if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
      CallProfileapi();
      AppConstant.CheckNetwork().whenComplete(() => CallApiforBarberDetail());
    }
  }

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //or set color with: Color(0xFF0000FF)
    ));
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

    return new SafeArea(

        // debugShowCheckedModeBanner: false,

        // backgroundColor: Colors.white,
        // appBar: appbar(context, 'Home',_drawerscaffoldkey),
        child: Scaffold(
      resizeToAvoidBottomInset: true,

      //second scaffold
      key: _drawerscaffoldkey,

      //set gobal key defined above

      drawer: DrawerOnly(name),

      bottomNavigationBar: new BottomBar(widget.index),
    ));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text("YES"),
          ),
        ],
      ),
    ).then((value) => value as bool);
  }

  void CallApiforBarberDetail() {
    // pr.hide();
    RestClient(Retro_Api().Dio_Data()).salondetail().then((response) {
      setState(() {
        print(response.success);

        if (response.success = true) {
          print("detailResponse:${response.msg}");

          print(response.data!.category!.length);

/*          double salon_lat  = double.parse(response.data.salon.latitude);
          double salon_long  = double.parse(response.data.salon.longitude);
          assert(salon_lat is double);
          assert(salon_long is double);

          AppConstant.getDistance(salon_lat, salon_long).whenComplete(() => AppConstant.getDistance(salon_lat,salon_long).then((value) {
            distance = value;
            print("Detail_Distance123896:$distance");
          }));*/

          PreferenceUtils.setString(
              AppConstant.singlesalonName, response.data!.salon!.name!);
          PreferenceUtils.setString(
              AppConstant.salonAddress, response.data!.salon!.address!);
          PreferenceUtils.setString(
              AppConstant.salonRating, response.data!.salon!.rate.toString());
          PreferenceUtils.setString(AppConstant.salonImage,
              response.data!.salon!.imagePath! + response.data!.salon!.logo!);
        }
      });
    }).catchError((Object obj) {
      print("error:$obj");
      print(obj.runtimeType);
    });
  }

  void CallProfileapi() {
    RestClient(Retro_Api().Dio_Data()).profile().then((response) {
      if (mounted) {
        setState(() {
          if (response.success = true) {
            name = response.data!.name;
            PreferenceUtils.setString(
                AppConstant.username, response.data!.name!);
          } else {
            AppConstant.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      print("error:$obj");
      print(obj.runtimeType);
      //AppConstant.toastMessage("Internal Server Error__123");
    });
  }
}
