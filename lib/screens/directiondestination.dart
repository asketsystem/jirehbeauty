import 'dart:async';

import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:progress_dialog/progress_dialog.dart';

import 'homescreen.dart';

class DirectionDest extends StatefulWidget {
  var salonData;
  DirectionDest(this.salonData);

  @override
  _DirectionDest createState() => new _DirectionDest();
}

class _DirectionDest extends State<DirectionDest> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  late BitmapDescriptor pinLocationIcon;
  Map<MarkerId, Marker> markers = {};
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allmarkers = [];

  String name = "User";
  var salondata1;
  String mondaytime = "";
  String tuesdaytime = "";
  String wednesdaytime = "";
  String thursdaytime = "";
  String fridaytime = "";
  String saturdaytime = "";
  String sundaytime = "";
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  GoogleMapController? mapController;

  // double current_lat ;
  // double current_long ;

  double? salon_lat;
  double? salon_long;
  String distance = " ";
  var day;
  var salontime;
  LatLng? origin;

  // ProgressDialog pr;

  double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  double _destLatitude = 6.849660, _destLongitude = 3.648190;
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();

    origin = new LatLng(AppConstant.currentlat, AppConstant.currentlong);
    salon_lat = double.parse(widget.salonData.latitude);
    salon_long = double.parse(widget.salonData.longitude);
    assert(salon_lat is double);
    assert(salon_long is double);

    double distanceInMeters = Geolocator.distanceBetween(AppConstant.currentlat,
        AppConstant.currentlong, salon_lat!, salon_long!);
    double distanceinkm = distanceInMeters / 1000;
    print("current_distanceInMeters:$distanceInMeters");
    print("current_distanceinkm:$distanceinkm");
    String str = distanceinkm.toString();
    var distance12 = str.split('.');
    distance = distance12[0];
    print("AppConst_salon_distance:$distance");

    print("AppConst_salon_lat:$salon_lat");
    print("AppConst_salon_long:$salon_long");
    // origin.longitude = AppConstant.currentlong;

    print("AppConst_lat:${AppConstant.currentlat}");
    print("AppConst_long:${AppConstant.currentlong}");

    // setCustomMapPin();
    day = DateFormat('EEEE').format(DateTime.now());
    print("Todayis:$day");
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'images/location_black.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });

    setState(() {
      AppConstant.currentlatlong()
          .whenComplete(() => AppConstant.currentlatlong().then((value) {
                origin = value;
                print("origin123:$origin");

                if (origin != null && salon_lat != null && salon_long != null) {
                  print("origin123 not null");

                  _getPolyline(origin!, salon_lat!, salon_long!);
                } else {
                  print("origin123 null");
                }

                /* allmarkers.add(



          Marker(
            markerId: MarkerId("your location"),
            position: LatLng(origin.latitude,origin.longitude),
            // position: LatLng(22.3039, 70.8022),
            icon: BitmapDescriptor.defaultMarkerWithHue(90),
            infoWindow: InfoWindow(title: "your location",),

          ),);

        allmarkers.add(Marker(
          markerId: MarkerId("your location"),
          position: LatLng(salon_lat,salon_long),
          // position: LatLng(22.3039, 70.8022),
          icon: BitmapDescriptor.defaultMarkerWithHue(90),
          infoWindow: InfoWindow(title: "your location",),

        ),
        );
        print("allmarker");*/
              }));
    });

    PreferenceUtils.init();
    name = PreferenceUtils.getString(AppConstant.username);

    // _addMarker(LatLng(22.3045233, 70.80102499999998), "origin",
    //     pinLocationIcon);
    //
    // /// destination marker
    // _addMarker(LatLng(31.31099859450927, 34.849441210937506), "destination",
    //     pinLocationIcon);

    salondata1 = widget.salonData;
    PreferenceUtils.init();
    // AppConstant.CheckNetwork().whenComplete(() =>   pr.show());
    // AppConstant.CheckNetwork().whenComplete(() =>  CallApiforBannerDetail() );

    if (day == "Sunday") {
      if (widget.salonData.sunday.open == null &&
          widget.salonData.sunday.close == null) {
        salontime = "Close";
        print(salontime);
      } else {
        salontime = widget.salonData.sunday.open +
            "am" +
            " to " +
            widget.salonData.sunday.close +
            "pm";
        print(salontime);
      }
    }
    day = DateFormat('EEEE').format(DateTime.now());
    if (day == "Saturday") {
      if (widget.salonData.saturday.open == null &&
          widget.salonData.saturday.close == null) {
        salontime = "Close";
        print(salontime);
      } else {
        salontime = widget.salonData.saturday.open +
            "am" +
            " to " +
            widget.salonData.saturday.close +
            "pm";
        print(salontime);
      }
    }

    if (day == "Friday") {
      if (widget.salonData.friday.open == null &&
          widget.salonData.friday.close == null) {
        salontime = "Close";
        print(salontime);
      } else {
        salontime = widget.salonData.friday.open +
            "am" +
            " to " +
            widget.salonData.friday.close +
            "pm";
        print(salontime);
      }
    }

    if (day == "Thursday") {
      if (widget.salonData.thursday.open == null &&
          widget.salonData.thursday.close == null) {
        salontime = "Close";
        print(salontime);
      } else {
        salontime = widget.salonData.thursday.open +
            "am" +
            " to " +
            widget.salonData.thursday.close +
            "pm";
        print(salontime);
      }
    }

    if (day == "Wednesday") {
      if (widget.salonData.wednesday.open == null &&
          widget.salonData.wednesday.close == null) {
        salontime = "Close";
        print(salontime);
      } else {
        salontime = widget.salonData.wednesday.open +
            "am" +
            " to " +
            widget.salonData.wednesday.close +
            "pm";
        print(salontime);
      }
    }

    if (day == "Tuesday") {
      if (widget.salonData.tuesday.open == null &&
          widget.salonData.tuesday.close == null) {
        salontime = "Close";
        print(salontime);
      } else {
        salontime = widget.salonData.tuesday.open +
            "am" +
            " to " +
            widget.salonData.tuesday.close +
            "pm";
        print(salontime);
      }
    }
    if (day == "Monday") {
      if (widget.salonData.monday.open == null &&
          widget.salonData.monday.close == null) {
        salontime = "Close";
        print(salontime);
      } else {
        salontime = widget.salonData.monday.open +
            "am" +
            " to " +
            widget.salonData.monday.close +
            "pm";
        print(salontime);
      }
    }
  }

  void setCustomMapPin() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'images/marker.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  // void setCustomMapPin() async {
  //   pinLocationIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 2.5),
  //       'images/marker.png');
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    LatLng pinPosition = LatLng(22.3039, 70.8022);

    // these are the minimum required values to set
    // the camera position
    CameraPosition initialLocation =
        CameraPosition(zoom: 11, bearing: 30, target: pinPosition);

    return new SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(left: 0),
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Destination Direction",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => new HomeScreen(0)));

                // do something
              },
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,

        //second scaffold
        key: _drawerscaffoldkey,
        // drawer: new DrawerOnly(name),

        body: Container(
            child: ListView(
          children: <Widget>[
            Container(
                height: screenHeight * 0.62,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(origin!.latitude, origin!.longitude),
                      zoom: 1),
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                  markers: Set.from(allmarkers),
                  polylines: Set<Polyline>.of(polylines.values),
                )),
            Container(
              height: screenHeight * 0.07,
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 5),
                child: Text(
                  "Your Destination",
                  style: TextStyle(
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.17,
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 1, left: 1, right: 10, bottom: 15),
              child: Container(

                  // width: 210,

                  child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10),

                // margin: EdgeInsets.only(left: 5,right: 5,bottom: 0.0),

                child: Container(
                  alignment: Alignment.topCenter,
                  height: 150,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFf1f1f1), width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: <Widget>[
                      new Container(
                        height: 80,
                        width: screenwidth * .20,
                        margin: EdgeInsets.only(left: 10),
                        // color: Colors.black,
                        alignment: Alignment.topLeft,

                        child: CachedNetworkImage(
                          imageUrl: widget.salonData.imagePath +
                              widget.salonData.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => SpinKitFadingCircle(
                              color: Color(AppConstant.pinkcolor)),
                          errorWidget: (context, url, error) =>
                              Image.asset("images/no_image.png"),
                        ),
                      ),
                      IntrinsicWidth(
                          // height: 100,
                          // width: MediaQuery
                          //     .of(context)
                          //     .size
                          //     .width * 1,
                          // margin: EdgeInsets.only(left: 10,top:20),
                          // color: Colors.grey,
                          // alignment: Alignment.topLeft,

                          child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 9,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5, left: 5, right: 5),
                                  width: screenwidth * .65,
                                  child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 15.0, left: 5),
                                        child: Text(
                                          widget.salonData.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 5.0, left: 5),
                                        child: Text(
                                          widget.salonData.address,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: Color(0xFFb9b9b9),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 1),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 2, left: 5),
                                                child: SvgPicture.asset(
                                                  "images/star.svg",
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 2, left: 2),
                                                child: Text(
                                                    widget.salonData.rate
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFFffc107),
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            'Montserrat')),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, top: 2),
                                              child: Text(
                                                salontime,
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF00d14d),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Montserrat'),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, left: 5),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 2),
                                                            child: SvgPicture
                                                                .asset(
                                                              "images/distance.svg",
                                                              width: 14,
                                                              height: 14,
                                                            )),
                                                      ),
                                                      TextSpan(
                                                          text: distance + "km",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'Montserrat')),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

/*
                                        Container(
                                          width: screenwidth * .20,
                                          margin: EdgeInsets.only(top: 12),

                                          child:Column(



                                            children: <Widget>[

                                              Visibility(
                                                visible:false,
                                                child: Container(
                                                  child: FlatButton(
                                                    minWidth: screenwidth * .22,
                                                    height: 30,
                                                    onPressed: (){

                                                      // Navigator.push(context,
                            //new MaterialPageRoute(builder: (ctxt) => new DetailBarber(catsalondataList[index].salonId)));

                                                    },
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                        side: BorderSide(color:  Color(AppConstant.pinkcolor),width: 2)
                                                    ),


                                                    child: Text('Book',
                                                      style: TextStyle(color:  Color(AppConstant.pinkcolor),fontFamily: 'Montserrat',fontWeight: FontWeight.w600,fontSize: 12),

                                                    ),
                                                  ),





                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [

                                                        WidgetSpan(
                                                          child: Container(
                                                              margin:EdgeInsets.only(right: 2),
                                                              child: SvgPicture.asset("images/distance.svg",width: 14,height: 14,)),
                                                        ),
                                                        TextSpan(
                                                            text: distance + "km",
                                                            style: TextStyle(color: Colors.grey,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w600,fontFamily: 'Montserrat')
                                                        ),



                                                      ],
                                                    ),
                                                  )






                                              ),









                                            ],


                                          ),




                                        ),


*/
                              ],
                            ),
                          ),

                          // Container(
                          //
                          //   child: Divider(color: Colors.grey,),
                          // )
                        ],
                      )),
                    ],
                  ),
                ),
              )
                  // ],

                  ),
            )
          ],
        )),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    setState(() {
      if (origin != null) {
        allmarkers.add(
          Marker(
            markerId: MarkerId('markar1'),
            position: LatLng(origin!.latitude, origin!.longitude),
            icon: pinLocationIcon,
            infoWindow: InfoWindow(
              title: "Your Location",
            ),
          ),
        );
      } else {
        print("origin null");
      }

      if (salon_long != null && salon_lat != null) {
        allmarkers.add(
          Marker(
            markerId: MarkerId("your location"),
            position: LatLng(salon_lat!, salon_long!),
            // position: LatLng(22.3039, 70.8022),
            icon: pinLocationIcon,
            infoWindow: InfoWindow(
              title: "Barber",
            ),
          ),
        );
      } else {
        print("salon lat null");
      }

      // allmarkers.add(
      //   Marker(
      //     markerId: MarkerId('markar2'),
      //     position: LatLng(22.2432,70.8000),
      //     icon: pinLocationIcon,
      //     infoWindow: InfoWindow(title: "Barberque",)  ,
      //     onTap: () async{
      //       LocationPermission permission = await Geolocator.requestPermission();
      //       print("permission:$permission");
      //       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //       print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
      //
      //       // _getAddressFromLatLng(position);
      //
      //       },
      //   ),
      // );
    });
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 10);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(LatLng origin, double salon_lat, double salon_long) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDvivYcq13YuQqAde0UKwtnVflecI-7XEk",
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(salon_lat, salon_long));
    print(result.points);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
