import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gson/gson.dart';
// import 'package:progress_dialog/progress_dialog.dart';

class AppConstant {
  static final String oneSignalAppKey = "29561882-aa25-43ef-b277-83a677b09524";

  static final String username = "username";
  static final String userid = "userid";
  static final String fcmtoken = "fcmtoken";
  static final String headertoken = "headertoken";
  static final String useremail = "useremail";
  static final String userphone = "userphone";
  static final String userotp = "userotp";
  static final String userphonecode = "userphonecode";
  static final String userimage = "userimage";
  static final String imagePath = "imagePath";
  static final String isLoggedIn = "isLoggedIn";
  static final String stripekey = "stripekey";
  static final String rozarkey = "rozarkey";
  static double currentlat = 0;
  static double currentlong = 0;

  static final String singlesalonName = "singlesalonName";
  static final String salonAddress = "salonAddress";
  static final String salonRating = "salonRating";
  static final String salonImage = "salonImage";

  static final String salonName = "salonName";
  static final String role = "role";
  static final int pinkcolor = 0xFFe06287;

  static Future<String> cuttentlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places.isNotEmpty) {
      final Placemark place = places.first;
      print(place.locality);
      print(place.thoroughfare);
      final current_address = place.thoroughfare! + "," + place.locality!;

      AppConstant.currentlong = position.longitude;
      AppConstant.currentlat = position.latitude;

      return current_address;
    }
    return "No address available";
  }

  static Future<LatLng?> currentlatlong() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      print(place.locality);
      print(place.thoroughfare);
      final current_address = place.thoroughfare! + "," + place.locality!;

      return LatLng(position.latitude, position.longitude);
    }
    return null;
  }

  static Future<String> getDistance(double lat, double long) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position == null
        ? 'Unknown'
        : position.latitude.toString() + ', ' + position.longitude.toString());

    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      double salon_lat = lat;
      double salon_long = long;
      assert(salon_lat is double);
      assert(salon_long is double);
      // double distanceInMeters = Geolocator.distanceBetween( current_lat,  current_long, current_lat, current_long);
      double distanceInMeters = Geolocator.distanceBetween(
          position.latitude, position.longitude, salon_lat, salon_long);

      double distanceinkm = distanceInMeters / 1000;

      print("current_distanceInMeters:$distanceInMeters");
      print("current_distanceinkm:$distanceinkm");

      String str = distanceinkm.toString();

      var distance12 = str.split('.');

      String distance = distance12[0];
      print("km123:$distance");
      return distance;
    } else {
      return "0";
    }
  }

  static void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // timeInSecForIos: 1,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }

  static Future<bool> CheckNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      AppConstant.toastMessage("No Internet Connection");
      return false;
    }
  }

  // static onLoading(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.1,
  //           padding: EdgeInsets.all(20),
  //           child: new Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
  //               SizedBox(width: 20),
  //               Text("Loading..."),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // static hideDialog(BuildContext context) {
  //   Navigator.pop(context);
  // }
}
