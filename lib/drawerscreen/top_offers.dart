import 'package:barber_app/ResponseModel/bannerResponse.dart';
import 'package:barber_app/ResponseModel/offerResponse.dart';
import 'package:barber_app/ResponseModel/offerbannerResppose.dart';
import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/screens/confirmbooking.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/common/common_view.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TopOffers extends StatefulWidget {
  int code;
  double? totalprice;
  List<int>? selecteServices = <int>[];

  int? salonId;
  var date;

  var time;
  int? selectedempid;
  List? _totalprice = [];

  List<String>? _selecteServicesName = <String>[];

  var salonData;

  TopOffers(
    this.code,
    this.selectedempid,
    this.time,
    this.date,
    this.totalprice,
    this.selecteServices,
    this.salonId,
    this._selecteServicesName,
    this._totalprice,
    this.salonData,
  );

  @override
  _TopOffers createState() => new _TopOffers();
}

class _TopOffers extends State<TopOffers> {
  List<Data> offerdataList = <Data>[];
  List<Offerbanner> banner_image = <Offerbanner>[];
  List<String> image12 = <String>[];
  bool _loading = false;
  int index = 0;
  int? code;
  String name = "User";

  @override
  void initState() {
    super.initState();

    code = widget.code;
    PreferenceUtils.init();
    AppConstant.CheckNetwork().whenComplete(() => CallApiforBanner());
    AppConstant.CheckNetwork().whenComplete(() => CallApiforOfferData());
    name = PreferenceUtils.getString(AppConstant.username);
  }

  void CallApiforBanner() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).offersbanner().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.data!.length);
            banner_image.addAll(response.data!);
            image12.clear();
            for (int i = 0; i < banner_image.length; i++) {
              image12.add(banner_image[i].imagePath! + banner_image[i].image!);
            }
            int length123 = image12.length;
            print("StringlistSize:$length123");
          } else {
            toastMessage("No Data");
          }
        });
      } else {
        if (response.success = true) {
          print(response.data!.length);
          banner_image.addAll(response.data!);
          image12.clear();
          for (int i = 0; i < banner_image.length; i++) {
            image12.add(banner_image[i].imagePath! + banner_image[i].image!);
          }
          int length123 = image12.length;
          print("StringlistSize:$length123");
        } else {
          toastMessage("No Data");
        }
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      toastMessage("Internal Server Error");
    });
  }

  void CallApiforOfferData() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).coupon().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.data!.length);
            offerdataList.addAll(response.data!);
            int size = offerdataList.length;
            print("offersize:$size");
          } else {
            toastMessage("No Data");
          }
        });
      } else {
        _loading = false;
        if (response.success = true) {
          print(response.data!.length);
          offerdataList.addAll(response.data!);
          int size = offerdataList.length;
          print("offersize:$size");
        } else {
          toastMessage("No Data");
        }
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      toastMessage("Internal Server Error");
    });
  }

  CarouselSlider? carouselSlider;

  int _current = 0;

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  void CallApiforApplycoupon(String? code) {
    print(code);
    setState(() {
      _loading = true;
    });

    RestClient(Retro_Api().Dio_Data()).checkcoupon(code).then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success == true) {
          print("sucess");

          int discount = response.data!.discount!;
          toastMessage(response.msg!);

          double totalprice = widget.totalprice! - discount;
          print("newtotalprice:$totalprice");
          print("oldtotalprice:${widget.totalprice}");

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmBooking(
                    widget.selectedempid,
                    widget.time,
                    widget.date,
                    totalprice,
                    widget.selecteServices,
                    widget.salonId,
                    widget._selecteServicesName,
                    widget._totalprice,
                    widget.salonData,
                    true,
                    false)),
          );
        } else {
          toastMessage(response.msg!);
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response!;

          var responsecode = res.statusCode;
          var msg = res.statusMessage;

          if (responsecode == 401) {
            toastMessage("Invalid Data");
            print(responsecode);
            print(res.statusMessage);
          } else if (responsecode == 422) {
            toastMessage("Invalid Email");
            print("code:$responsecode");
            print("msg:$msg");
          }

          break;
        default:
      }
    });
  }

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,

      // color: Colors.white,
      // debugShowCheckedModeBanner: false,

      child: ModalProgressHUD(
        inAsyncCall: _loading,
        opacity: 1.0,
        color: Colors.transparent.withOpacity(0.2),
        progressIndicator:
            SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
        child: new SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appbar(context, 'Top Offers', _drawerscaffoldkey, false)
                as PreferredSizeWidget?,
            body: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                key: _drawerscaffoldkey,
                //set gobal key defined above

                drawer: new DrawerOnly(name),
                body: new Stack(
                  children: <Widget>[
                    new SingleChildScrollView(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 400,
                            height: screenHeight * 0.25,
                            alignment: Alignment.topCenter,
                            color: Colors.transparent,
                            margin:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: Card(
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        height: 180,
                                        viewportFraction: 1.0,
                                        onPageChanged: (index, index1) {
                                          setState(() {
                                            _current = index;
                                          });
                                        },
                                      ),
                                      items: image12.map((imgUrl) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                                child: Stack(
                                              children: <Widget>[
                                                Material(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  elevation: 2.0,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  type:
                                                      MaterialType.transparency,
                                                  child: CachedNetworkImage(
                                                    imageUrl: imgUrl,
                                                    height: 200,
                                                    width: 500,
                                                    fit: BoxFit.fitWidth,
                                                    placeholder: (context,
                                                            url) =>
                                                        SpinKitFadingCircle(
                                                            color: Color(
                                                                AppConstant
                                                                    .pinkcolor)),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "images/no_image.png"),
                                                  ),

                                                  /*  child: Image.network( imgUrl,

                                                  height: 200,
                                                  width: 550,
                                                  fit: BoxFit.fitWidth,
                                                ),*/
                                                ),

                                                Center(
                                                  // child:Row(
                                                  // children: map<Widget>(banner_image, (index, url) {
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          banner_image[_current]
                                                              .title!,
                                                          style:
                                                              // child:  Text("The Massive Discount upto ",style:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontFamily:
                                                                      'Montserrat'),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          banner_image[_current]
                                                                  .discount
                                                                  .toString() +
                                                              "%",
                                                          style:
                                                              // child:  Text('50'+ "%",style:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontFamily:
                                                                      'Montserrat'),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10, bottom: 5),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'Is Coming Soon',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontFamily:
                                                                  'Montserrat'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  // }),
                                                ),

                                                /*   child:Column(


                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(top: 20),

                                                      alignment: Alignment.center,
                                                      child:  Text(banner_image[index].title,style:
                                                      TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w800,fontFamily: 'Montserrat'),),


                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 10),

                                                      alignment: Alignment.center,
                                                      child:  Text(banner_image[index].discount.toString()+ "%",style:
                                                      TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.w800,fontFamily: 'Montserrat'),),


                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 10,bottom: 5),

                                                      alignment: Alignment.center,
                                                      child:  Text('Is Coming Soon',style:
                                                      TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w800,fontFamily: 'Montserrat'),),


                                                    ),
                                                  ],

                                                ),
                                             */

                                                // )
                                              ],
                                            ));
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            image12.length,
                                            (index) => Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  width: 9.0,
                                                  height: 9.0,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 2.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _current == index
                                                        ? Color(AppConstant
                                                            .pinkcolor)
                                                        : Color(0xFFffffff),
                                                  ),
                                                ))
                                        //     map<Widget>(image12, (index, url) {
                                        //   return Container(
                                        //     alignment: Alignment.bottomCenter,
                                        //     width: 9.0,
                                        //     height: 9.0,
                                        //     margin: EdgeInsets.symmetric(
                                        //         vertical: 10.0, horizontal: 2.0),
                                        //     decoration: BoxDecoration(
                                        //       shape: BoxShape.circle,
                                        //       color: _current == index
                                        //           ? Color(AppConstant.pinkcolor)
                                        //           : Color(0xFFffffff),
                                        //     ),
                                        //   );
                                        // }) as List<Widget>,
                                        ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          /*Container(

                        margin: EdgeInsets.only(top: 5.0,left: 10,right: 10,bottom: 60),
                        color: Colors.white,


                        child:ListView.builder(

                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: offerdataList.length,
                          itemBuilder: (BuildContext context, int index) {

                            Color light_color;
                            Color dark_color;

                            int disc = offerdataList[index].discount;
                            if(disc >= 50){
                              light_color = const Color(0xFFc8caff);
                              dark_color = const Color(0xFFb5b8ff);
                            }else if(disc >= 30){

                              light_color = const Color(0xFFffc8c8);
                              dark_color = const Color(0xFFffb5b5);

                            }else{

                              light_color = const Color(0xFFffc8de);
                              dark_color = const Color(0xFFffb5cc);
                            }

                            String type = offerdataList[index].type;
                            String type1 = "";


                            if(type == "Percentage"){

                              type1 = "%";

                            }else if(type == "Amount"){

                              type1 = "Rs.";



                            }




                            return new Container(
                                color: Colors.white,
                                // width: 210,

                                child: Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.all(10.0),
                                  width: screenwidth,
                                  decoration: BoxDecoration(
                                    color: light_color,
                                    borderRadius: BorderRadius.circular(15),

                                  ),

                                  // margin: EdgeInsets.only(left: 5,right: 5,bottom: 0.0),
                                  child: Container(
                                    child: new Row(
                                      children: <Widget>[
                                        Container(
                                            height: 75,
                                            // width: 70.0,

                                            width:screenwidth * .22,
                                            alignment: Alignment.topLeft,

                                            decoration: BoxDecoration(
                                                color: dark_color,
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15),)),
                                            child: new Center(
                                              child: new Text(offerdataList[index].discount.toString() + type1,
                                                style: TextStyle(fontSize: 24, color: Color(0xFF213640),fontWeight: FontWeight.w700,fontFamily: 'Montserrat'),
                                                textAlign: TextAlign.center,),
                                            )
                                        ),

                                        Container(
                                            width: screenwidth * .41,
                                            margin: EdgeInsets.only(left: 1.0,right: 10.0),

                                            alignment: Alignment.topLeft,
                                            child: ListView(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              children: <Widget>[
                                                Container(
                                                  transform: Matrix4.translationValues(5.0, 0.0, 0.0),
                                                  child: Text(offerdataList[index].code,style: TextStyle(color: Color(0xFFfff9fb),fontSize: 14,fontWeight: FontWeight.w800,  fontFamily: 'Montserrat'),),

                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 5),

                                                  child: Text(offerdataList[index].desc,style: TextStyle(color: Color(0xFFfff9fb),fontSize: 11,fontWeight: FontWeight.w600,  fontFamily: 'Montserrat'),),

                                                ),

                                              ],

                                            )
                                        ),

                                        GestureDetector(


                                          child: Container(
                                              width: screenwidth * .20,
                                              height: 35,

                                              margin: EdgeInsets.only(left: 1.0),
                                              alignment: Alignment.topCenter,

                                              child:   FlatButton(
                                                onPressed: () {



                                                    setState(() {

                                                      print("code123:$code");

                                                      if(code == -1){

                                                        AppConstant.toastMessage("First Book Appointment from Home");
                                                        print("not apply");
                                                      }else if(code == 1){



                                                        AppConstant.CheckNetwork().whenComplete(() =>   pr.show());
                                                        AppConstant.CheckNetwork().whenComplete(() =>  CallApiforApplycoupon(offerdataList[index].code));


                                                      }

                                                    });






                                                },
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(7)),
                                                child: Text("Apply",style: TextStyle(color: dark_color,  fontFamily: 'Montserrat',fontSize: 11,fontWeight: FontWeight.w600),),
                                              )





                                          ),
                                        ),








                                      ],
                                    ),
                                  ),
                                )
                              // ],

                            );


                            // return new OfferData(
                            //   discount: offerdatalist[index]['discount'],
                            //   dark_color: offerdatalist[index]['dark_color'],
                            //   light_color: offerdatalist[index]['light_color'],
                            // );
                          },
                        ),

                        // height: 50,
                      ),*/
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: offerdataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Color light_color;
                              Color dark_color;

                              int disc = offerdataList[index].discount!;
                              if (disc >= 50) {
                                light_color = const Color(0xFFc8caff);
                                dark_color = const Color(0xFFb5b8ff);
                              } else if (disc >= 30) {
                                light_color = const Color(0xFFffc8c8);
                                dark_color = const Color(0xFFffb5b5);
                              } else {
                                light_color = const Color(0xFFffc8de);
                                dark_color = const Color(0xFFffb5cc);
                              }

                              String? type = offerdataList[index].type;
                              String type1 = "";

                              if (type == "Percentage") {
                                type1 = "%";
                              } else if (type == "Amount") {
                                type1 = "Rs.";
                              }

                              return new Container(
                                  color: Colors.transparent,
                                  // width: 210,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.all(10.0),
                                    width: screenwidth,
                                    decoration: BoxDecoration(
                                      color: light_color,
                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                    // margin: EdgeInsets.only(left: 5,right: 5,bottom: 0.0),
                                    child: Container(
                                      child: new Row(
                                        children: <Widget>[
                                          Container(
                                              height: 75,
                                              // width: 70.0,

                                              width: screenwidth * .22,
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                  color: dark_color,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  )),
                                              child: new Center(
                                                child: new Text(
                                                  offerdataList[index]
                                                          .discount
                                                          .toString() +
                                                      type1,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Color(0xFF213640),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Montserrat'),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                          Container(
                                              width: screenwidth * .41,
                                              margin: EdgeInsets.only(
                                                  left: 1.0, right: 10.0),
                                              alignment: Alignment.topLeft,
                                              child: ListView(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                children: <Widget>[
                                                  Container(
                                                    transform: Matrix4
                                                        .translationValues(
                                                            5.0, 0.0, 0.0),
                                                    child: Text(
                                                      offerdataList[index]
                                                          .code!,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFfff9fb),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontFamily:
                                                              'Montserrat'),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    child: Text(
                                                      offerdataList[index]
                                                          .desc!,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFfff9fb),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              'Montserrat'),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          GestureDetector(
                                            child: Container(
                                                width: screenwidth * .20,
                                                height: 35,
                                                margin:
                                                    EdgeInsets.only(left: 1.0),
                                                alignment: Alignment.topCenter,
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      print("code123:$code");

                                                      if (code == -1) {
                                                        AppConstant.toastMessage(
                                                            "First Book Appointment from Home");
                                                        print("not apply");
                                                      } else if (code == 1) {
                                                        AppConstant
                                                                .CheckNetwork()
                                                            .whenComplete(() =>
                                                                CallApiforApplycoupon(
                                                                    offerdataList[
                                                                            index]
                                                                        .code));
                                                      }
                                                    });
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7)),
                                                  ),
                                                  child: Text(
                                                    "Apply",
                                                    style: TextStyle(
                                                        color: dark_color,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  // ],

                                  );

                              // return new OfferData(
                              //   discount: offerdatalist[index]['discount'],
                              //   dark_color: offerdatalist[index]['dark_color'],
                              //   light_color: offerdatalist[index]['light_color'],
                              // );
                            },
                          ),
                          Container(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                    new Container(child: Body())
                  ],
                )),
          ),
        ),
      ),
    );

    // pr.show();

    ;
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);

    return (await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => new HomeScreen(0)))) ??
        false;
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
