import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/common/common_view.dart';
import 'package:barber_app/common/inndicator.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/detailtabscreen/galleryview.dart';
import 'package:barber_app/detailtabscreen/reviewtab.dart';
import 'package:barber_app/detailtabscreen/servicetab.dart';
import 'package:barber_app/detailtabscreen/tababout.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:progress_dialog/progress_dialog.dart';

import 'homescreen.dart';

class DetailBarber extends StatefulWidget {
  int? catId;
  DetailBarber(this.catId);

  @override
  _DetailBarber createState() => new _DetailBarber();
}

class _DetailBarber extends State<DetailBarber>
    with SingleTickerProviderStateMixin {
  int index = 0;
  List<Data> categorydataList = <Data>[];
  List<Gallery> galleydataList = <Gallery>[];
  List<Category> categorylist = <Category>[];
  List<Review> reviewlist = <Review>[];
  var salonData;

  var salonId;
  String? salonName = "The Barber";
  String? salonaddress = "No Address found";
  bool datavisible = false;
  bool nodatavisible = true;
  bool _loading = false;
  String name = "User";
  String distance = "0";
  var salontime;
  String openlable = "OPEN";
  var day;
  String rating = "0";

  TabController? _controller;
  @override
  void initState() {
    super.initState();

    if (mounted) {
      var day = DateFormat('EEEE').format(DateTime.now());
      print("Todayis:$day");

      setState(() {
        _controller = new TabController(length: 4, vsync: this);
        int? catidd = widget.catId;
        print("catidd:$catidd");
        PreferenceUtils.init();

        AppConstant.CheckNetwork().whenComplete(() => CallApiforBarberDetail());
        name = PreferenceUtils.getString(AppConstant.username);
      });
    }
  }

  void CallApiforBarberDetail() {
    // pr.hide();
    // AppConstant.hideDialog(context);
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).salondetail().then((response) {
      setState(() {
        _loading = false;
        print(response.success);

        if (response.success = true) {
          print("detailResponse:${response.msg}");

          datavisible = true;
          nodatavisible = false;
          print(response.data!.category!.length);

          salonId = response.data!.salon!.salonId;
          salonName = response.data!.salon!.name;
          salonaddress = response.data!.salon!.address;
          rating = response.data!.salon!.rate.toString();

          if (day == "Sunday") {
            if (response.data!.salon!.sunday!.open == null &&
                response.data!.salon!.sunday!.close == null) {
              salontime = "Close";
              openlable = "CLOSE";
              print(salontime);
            } else {
              salontime = response.data!.salon!.sunday!.open! +
                  "am" +
                  " to " +
                  response.data!.salon!.sunday!.close! +
                  "pm";
              openlable = "OPEN";

              print(salontime);
            }
          }
          day = DateFormat('EEEE').format(DateTime.now());
          if (day == "Saturday") {
            if (response.data!.salon!.saturday!.open == null &&
                response.data!.salon!.saturday!.close == null) {
              salontime = "Close";
              openlable = "CLOSE";
              print(salontime);
            } else {
              salontime = response.data!.salon!.saturday!.open! +
                  "am" +
                  " to " +
                  response.data!.salon!.saturday!.close! +
                  "pm";
              openlable = "OPEN";
              print(salontime);
            }
          }

          if (day == "Friday") {
            if (response.data!.salon!.friday!.open == null &&
                response.data!.salon!.friday!.close == null) {
              salontime = "Close";
              openlable = "CLOSE";
              print(salontime);
            } else {
              salontime = response.data!.salon!.friday!.open! +
                  "am" +
                  " to " +
                  response.data!.salon!.friday!.close! +
                  "pm";
              openlable = "OPEN";
              print(salontime);
            }
          }

          if (day == "Thursday") {
            if (response.data!.salon!.thursday!.open == null &&
                response.data!.salon!.thursday!.close == null) {
              salontime = "Close";
              openlable = "CLOSE";
              print(salontime);
            } else {
              salontime = response.data!.salon!.thursday!.open! +
                  "am" +
                  " to " +
                  response.data!.salon!.thursday!.close! +
                  "pm";
              openlable = "OPEN";
              print(salontime);
            }
          }

          if (day == "Wednesday") {
            if (response.data!.salon!.wednesday!.open == null &&
                response.data!.salon!.wednesday!.close == null) {
              salontime = "Close";
              openlable = "CLOSE";
              print(salontime);
            } else {
              salontime = response.data!.salon!.wednesday!.open! +
                  "am" +
                  " to " +
                  response.data!.salon!.wednesday!.close! +
                  "pm";
              openlable = "OPEN";
              print(salontime);
            }
          }

          if (day == "Tuesday") {
            if (response.data!.salon!.tuesday!.open == null &&
                response.data!.salon!.tuesday!.close == null) {
              salontime = "Close";
              openlable = "CLOSE";
              print(salontime);
            } else {
              salontime = response.data!.salon!.tuesday!.open! +
                  "am" +
                  " to " +
                  response.data!.salon!.tuesday!.close! +
                  "pm";
              openlable = "OPEN";
              print(salontime);
            }
          }
          if (day == "Monday") {
            if (response.data!.salon!.monday!.open == null &&
                response.data!.salon!.monday!.close == null) {
              salontime = "Close";
              openlable = "CLOSE";
              print(salontime);
            } else {
              salontime = response.data!.salon!.monday!.open! +
                  "am" +
                  " to " +
                  response.data!.salon!.monday!.close! +
                  "pm";
              openlable = "OPEN";
              print(salontime);
            }
          }

          double salon_lat = double.parse(response.data!.salon!.latitude!);
          double salon_long = double.parse(response.data!.salon!.longitude!);
          assert(salon_lat is double);
          assert(salon_long is double);

          AppConstant.getDistance(salon_lat, salon_long).whenComplete(() =>
              AppConstant.getDistance(salon_lat, salon_long).then((value) {
                distance = value;
                print("Detail_Distance123896:$distance");
              }));

          print("SalonId:$salonId");

          if (response.data!.gallery!.length > 0) {
            galleydataList.clear();
            galleydataList.addAll(response.data!.gallery!);
          }

          if (response.data!.category!.length > 0) {
            categorylist.clear();
            categorylist.addAll(response.data!.category!);
          }

          if (response.data!.review!.length > 0) {
            reviewlist.clear();
            reviewlist.addAll(response.data!.review!);
          }

          salonData = response.data!.salon;

          int catsize = categorylist.length;
          print("catsize:$catsize");

        } else {
          datavisible = false;
          nodatavisible = true;

          toastMessage("No Data");
        }
      });
    }).catchError((Object obj) {

      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      toastMessage("Internal Server Error");
    });
  }

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      // color: Colors.white,
      // debugShowCheckedModeBanner: false,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        opacity: 1.0,
        color: Colors.transparent.withOpacity(0.2),
        progressIndicator: SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appbar(context, salonName!, _drawerscaffoldkey, false)
                as PreferredSizeWidget?,
            body: Scaffold(
                resizeToAvoidBottomInset: true,
                key: _drawerscaffoldkey,
                //set gobal key defined above

                drawer: new DrawerOnly(name),
                body: new Stack(
                  children: <Widget>[
                    Visibility(
                      visible: datavisible,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Stack(
                            clipBehavior: Clip.none, children: <Widget>[
                              Container(
                                // color: Colors.amber,
                                height: 200,
                                width: double.infinity,
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  "images/loginbg.png",
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Container(
                                      height: 70,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 50, left: 15),
                                                child: Text(
                                                  salonName!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, left: 5),
                                                padding: EdgeInsets.all(1),

                                                child: Image.asset(
                                                  "images/rightarow.png",
                                                  width: 20,
                                                  height: 20,
                                                  color: Colors.white,
                                                ),
                                                // child: Icon(Icons.,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Container(
                                    height: 15,
                                    color: Colors.transparent,
                                    margin: EdgeInsets.only(
                                        top: 8, left: 15, right: 5),
                                    child: Text(
                                      salonaddress!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(3),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    3),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    3),
                                                            topRight:
                                                                Radius.circular(
                                                                    3)),
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors.green,
                                                        style:
                                                            BorderStyle.solid)),

                                                height: 20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.12,
                                                alignment: Alignment.center,
                                                // color: Colors.transparent,

                                                margin: EdgeInsets.only(
                                                    top: 10, left: 15),

                                                child: Text(
                                                  openlable,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Container(
                                                height: 20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                alignment: Alignment.centerLeft,
                                                color: Colors.transparent,
                                                margin: EdgeInsets.only(
                                                    top: 10, left: 5),
                                                child: Text(
                                                  "Till " + salontime.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Container(
                                                height: 20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                alignment: Alignment.topLeft,
                                                color: Colors.transparent,
                                                margin: EdgeInsets.only(
                                                    top: 5, left: 0, bottom: 2),
                                                child: Text(
                                                  ".",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              // child: Row(
                                              //   mainAxisAlignment: MainAxisAlignment.start,
                                              //   children: <Widget>[
                                              child: Container(
                                                  height: 20,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  alignment: Alignment.center,
                                                  color: Colors.transparent,
                                                  margin: EdgeInsets.only(
                                                      top: 5,
                                                      left: 10,
                                                      bottom: 0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          margin: EdgeInsets.only(
                                                              left: 0, top: 5),
                                                          child: SvgPicture.asset(
                                                            "images/star.svg",
                                                            width: 10,
                                                            height: 10,
                                                          )),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5, top: 5),
                                                        child: Text(
                                                          rating.toString() +
                                                              " Rating",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                    ],
                                                  )

                                                  // child: SvgPicture.asset("images/star.svg",width: 10,height: 10,
                                                  // ),
                                                  ),

                                              //   ],
                                              //
                                              //
                                              //
                                              // ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Positioned(
                                right: 0,
                                left: 0,
                                bottom: 10,
                                child: Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  width: double.infinity,
                                  height: 50,
                                  // color: Colors.grey,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),

                                  child: TabBar(
                                    controller: _controller,
                                    tabs: [
                                      new Tab(
                                        text: 'About',
                                      ),
                                      new Tab(
                                        text: 'Gallery',
                                      ),
                                      new Tab(
                                        text: 'Service',
                                      ),
                                      new Tab(
                                        text: 'Review',
                                      ),
                                    ],
                                    labelColor: Color(AppConstant.pinkcolor),
                                    unselectedLabelColor: Colors.grey,
                                    labelStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat'),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorPadding: EdgeInsets.all(0.0),
                                    indicatorColor: Color(AppConstant.pinkcolor),
                                    indicatorWeight: 5.0,
                                    indicator: MD2Indicator(
                                      indicatorSize: MD2IndicatorSize.full,
                                      indicatorHeight: 8.0,
                                      indicatorColor:
                                          Color(AppConstant.pinkcolor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              color: Colors.white,
                              child: new TabBarView(
                                controller: _controller,
                                children: <Widget>[
                                  TabAbout(salonData, widget.catId, distance),
                                  // TabGallery(salonData,widget.catId),
                                  // TabAbout(salonData,widget.catId),
                                  GalleryView(galleydataList),

                                  // Container(

                                  // transform: Matrix4.translationValues(),
                                  ServiceTab(categorylist, salonId, salonData),
                                  ReViewTab(reviewlist),

                                  // ),

                                  //

                                  // TabAbout(),
                                  /*   Container(
                                      margin: EdgeInsets.only(top: 30,left: 10,right: 10,bottom: 45),




                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 30,left: 10,right: 10,bottom: 45),


                                      child:
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30,left: 0,right: 0,bottom: 50),


                                    child:

                                  ),*/

                                  // Container(
                                  //
                                  //   child: Center(
                                  //     child: Text('Review',style: TextStyle(color:Colors.black,fontSize: 15),),
                                  //
                                  //   ),
                                  // ),

                                  // EditProfile(),
                                  // EditProfile(),
                                  // EditProfile(),
                                  // EditProfile(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: nodatavisible,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 60),

                        // child: Text("Hello"),

                        child: Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.75,
                              alignment: Alignment.center,
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Image.asset(
                                    "images/nodata.png",
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 100,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(
                                          color: Color(0xFFa3a3a3),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    new Container(child: Body())
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);

    return (await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => new HomeScreen(0)))) ??
        false;
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: CustomView(),
      ),
    );
  }
}
