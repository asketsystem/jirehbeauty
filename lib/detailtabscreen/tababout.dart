import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:barber_app/detailtabscreen/website.dart';
import 'package:barber_app/screens/directiondestination.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:barber_app/separator/separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: new TabAbout(),
  ));
}

class TabAbout extends StatefulWidget {
  var salonData;
  int? catId;
  String distance;

  TabAbout(this.salonData, this.catId, this.distance);

  // var salondata;
  // TabAbout(this.salondata);

  @override
  _TabAbout createState() => new _TabAbout();
}

class _TabAbout extends State<TabAbout> {
  var salondata1;
  String? mondaytime = "";
  String? tuesdaytime = "";
  String? wednesdaytime = "";
  String? thursdaytime = "";
  String? fridaytime = "";
  String? saturdaytime = "";
  String? sundaytime = "";

  double? current_lat;
  double? current_long;
  String distance = " ";
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    distance = widget.distance;

    if (mounted) {
      setState(() {
        double salon_lat = double.parse(widget.salonData.latitude);
        double salon_long = double.parse(widget.salonData.longitude);
        assert(salon_lat is double);
        assert(salon_long is double);

        double distanceInMeters = Geolocator.distanceBetween(
            AppConstant.currentlat,
            AppConstant.currentlong,
            salon_lat,
            salon_long);
        double distanceinkm = distanceInMeters / 1000;
        print("current_distanceInMeters:$distanceInMeters");
        print("current_distanceinkm:$distanceinkm");

        String str = distanceinkm.toString();
        var distance12 = str.split('.');

        distance = distance12[0];
        print("km123:$distance");

        // AppConstant.getDistance(salon_lat, salon_long).whenComplete(() => AppConstant.getDistance(salon_lat,salon_long).then((value){
        //   distance = value;
        //   print("Distance123896:$distance");
        //
        //
        // }));
      });
    }
    checkpermission();
    salondata1 = widget.salonData;
    // distance = widget.distance;


    PreferenceUtils.init();

    // AppConstant.CheckNetwork()
    //     .whenComplete(() => AppConstant.onLoading(context));
    // AppConstant.CheckNetwork().whenComplete(() =>  CallApiforBannerDetail() );

    if (widget.salonData.sunday.open == null &&
        widget.salonData.sunday.close == null) {
      sundaytime = "Close";
    } else {
      sundaytime = widget.salonData.sunday.open +
          "am" +
          " to " +
          widget.salonData.sunday.close +
          "pm";
    }

    if (widget.salonData.monday.open == null &&
        widget.salonData.monday.close == null) {
      mondaytime = "Close";
    } else {
      mondaytime = widget.salonData.monday.open +
          "am" +
          " to " +
          widget.salonData.monday.close +
          "pm";
    }

    if (widget.salonData.tuesday.open == null &&
        widget.salonData.tuesday.close == null) {
      tuesdaytime = "Close";
    } else {
      tuesdaytime = widget.salonData.tuesday.open +
          "am" +
          " to " +
          widget.salonData.tuesday.close +
          "pm";
    }

    if (widget.salonData.wednesday.open == null &&
        widget.salonData.wednesday.close == null) {
      wednesdaytime = "Close";
    } else {
      wednesdaytime = widget.salonData.wednesday.open +
          "am" +
          " to " +
          widget.salonData.wednesday.close +
          "pm";
    }

    if (widget.salonData.thursday.open == null &&
        widget.salonData.thursday.close == null) {
      thursdaytime = "Close";
    } else {
      thursdaytime = widget.salonData.thursday.open +
          "am" +
          " to " +
          widget.salonData.thursday.close +
          "pm";
    }

    if (widget.salonData.friday.open == null &&
        widget.salonData.friday.close == null) {
      fridaytime = "Close";
    } else {
      fridaytime = widget.salonData.friday.open +
          "am" +
          " to " +
          widget.salonData.friday.close +
          "pm";
    }

    if (widget.salonData.saturday.open == null &&
        widget.salonData.saturday.close == null) {
      saturdaytime = "Close";
    } else {
      saturdaytime = widget.salonData.saturday.open +
          "am" +
          " to " +
          widget.salonData.saturday.close +
          "pm";
    }
  }

  void checkpermission() async {
    // setState(() {
    //   _loading = true;
    // });
    LocationPermission permission = await Geolocator.requestPermission();

    permission = await Geolocator.checkPermission();
    print("permissionresult:$permission");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("denied");
    } else if (permission == LocationPermission.whileInUse) {
      print("whileInUse56362");

      setState(() {
        double salon_lat = double.parse(widget.salonData.latitude);
        double salon_long = double.parse(widget.salonData.longitude);
        assert(salon_lat is double);
        assert(salon_long is double);

        AppConstant.getDistance(salon_lat, salon_long).whenComplete(
            () => AppConstant.getDistance(salon_lat, salon_long).then((value) {
                  distance = value;
                  print("Distance123:$distance");


                }));
      });
      // getCurrentLocation();

    } else if (permission == LocationPermission.always) {
      print("always");
      setState(() {
        double salon_lat = double.parse(widget.salonData.latitude);
        double salon_long = double.parse(widget.salonData.longitude);
        assert(salon_lat is double);
        assert(salon_long is double);

        AppConstant.getDistance(salon_lat, salon_long).whenComplete(
            () => AppConstant.getDistance(salon_lat, salon_long).then((value) {
                  distance = value;
                  print("Distance123:$distance");

                }));
      });
      // getCurrentLocation();

    }
  }

  // Future<void> getCurrentLocation() async {
  //
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
  //
  //   var places = await placemarkFromCoordinates(
  //     position.latitude,
  //     position.longitude,
  //   );
  //   if (places != null && places.isNotEmpty) {
  //
  //
  //     current_lat = position.latitude;
  //     current_long= position.longitude;
  //
  //
  //
  //
  //
  //
  //     double salon_lat  = double.parse(widget.salonData.latitude);
  //     double salon_long  = double.parse(widget.salonData.longitude);
  //     assert(salon_lat is double);
  //     assert(salon_long is double);
  //     // double distanceInMeters = Geolocator.distanceBetween( current_lat,  current_long, current_lat, current_long);
  //     double distanceInMeters = Geolocator.distanceBetween(current_lat, current_long, salon_lat, salon_long);
  //
  //     double distanceinkm = distanceInMeters / 1000;
  //
  //
  //     print("current_distanceInMeters:$distanceInMeters");
  //     print("current_distanceinkm:$distanceinkm");
  //
  //     String str =distanceinkm.toString();
  //
  //
  //     var distance12 = str.split('.');
  //
  //     distance = distance12[0];
  //     print("km123:$distance");
  //
  //
  //
  //
  //   }
  //
  // }
  //
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator:
          SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Padding(
              padding: EdgeInsets.only(top: 0, left: 20, right: 15, bottom: 50),

              // padding: EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 1),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "About " + " " + salondata1.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 10, right: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      salondata1.desc,
                      style: TextStyle(
                          color: const Color(0xFF999999),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Service on Days',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 0, top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Sunday',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          child: Text(
                            sundaytime!,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Monday',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          child: Text(
                            mondaytime!,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Tuesday',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          child: Text(
                            tuesdaytime!,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Wednesday',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          child: Text(
                            wednesdaytime!,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Thursday',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          child: Text(
                            thursdaytime!,
                            style: TextStyle(
                                fontSize: 14,
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Friday',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          child: Text(
                            fridaytime!,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Saturday',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          child: Text(
                            saturdaytime!,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 00, top: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Location',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 00, right: 10),
                    width: double.infinity,
                    height: 110,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Container(
                          height: 70,
                          width: 70,
                          //  margin: EdgeInsets.only(left: 10),
                          // color: Colors.black,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage("images/maplocation.jpg"),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, left: 10, right: 20),
                                  alignment: Alignment.topLeft,
                                  // width: MediaQuery.of(context).size *widget ,

                                  child: Text(
                                    widget.salonData.address,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: const Color(0xFF999999),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 2,
                                      // color: Colors.black,

                                      child: MySeparator(),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5, left: 10, right: 00),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 1),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 2, left: 0),
                                                child: SvgPicture.asset(
                                                  "images/location_icon.svg",
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 2, left: 5),
                                                child: Text(distance + " km",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFF999999),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            'Montserrat')),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      new DirectionDest(
                                                          widget.salonData)));
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(top: 2),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 2, left: 5),
                                                  child: SvgPicture.asset(
                                                    "images/direction.svg",
                                                    width: 10,
                                                    height: 10,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 2, left: 5),
                                                  child: Text(
                                                      "See the direction",
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xFF4a92ff),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              'Montserrat')),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Contact Information',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.white,
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 0),
                                  child: SvgPicture.asset(
                                    "images/website.svg",
                                    width: 12,
                                    height: 12,
                                  ),
                                ),
                              ),
                              Container(
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 5),
                                  child: Text("Website",
                                      style: TextStyle(
                                          color: Color(AppConstant.pinkcolor),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat')),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: GestureDetector(
                          onTap: () {
                            if (widget.salonData.website != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => new WebSite()));
                            } else {
                              AppConstant.toastMessage(
                                  'Website not available.');
                            }
                          },
                          child: Text(
                            'Visit the Website',
                            style: TextStyle(
                                color: const Color(0xFF4a92ff),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.white,
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 0),
                                  child: SvgPicture.asset(
                                    "images/phone.svg",
                                    width: 12,
                                    height: 12,
                                  ),
                                ),
                              ),
                              Container(
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 5),
                                  child: Text("Call",
                                      style: TextStyle(
                                          color: Color(AppConstant.pinkcolor),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat')),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              // UrlLauncher.launch('tel:+${p.phone.toString()}');
                              // launch(('tel://${item.mobile_no}'))
                              launch(('tel://' + widget.salonData.phone));
                            },
                            child: Text(
                              widget.salonData.phone.toString(),
                              style: TextStyle(
                                  color: const Color(0xFF4a92ff),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(

          // child: CustomView(),

          ),
    );
  }
}
