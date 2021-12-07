import 'dart:io';

import 'package:barber_app/ResponseModel/bannerResponse.dart';
import 'package:barber_app/ResponseModel/categorydataResponse.dart';
import 'package:barber_app/ResponseModel/salonResponse.dart';
import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:barber_app/screens/detailbarber.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:progress_dialog/progress_dialog.dart';

class FgHome extends StatefulWidget {
  FgHome({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _FgHome createState() => _FgHome();
}

class _FgHome extends State<FgHome> {
  List<Data1> banner_image = <Data1>[];
  List<String> image12 = <String>[];
  List<String?> banner_title = <String?>[];
  List<CategoryData> categorydataList = <CategoryData>[];
  List<SalonData> salondataList = <SalonData>[];
  String name = "User";
  bool _loading = false;

  int index = 0;

  String current_address = "No address found";
  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        PreferenceUtils.init();
        checkpermission();
        name = PreferenceUtils.getString(AppConstant.username);

        AppConstant.CheckNetwork().whenComplete(() => CallApiforBanner());
        AppConstant.CheckNetwork().whenComplete(() => CallApiForCategory());

        AppConstant.cuttentlocation()
            .whenComplete(() => AppConstant.cuttentlocation().then((value) {
                  current_address = value;
                }));
      });
      // BackButtonInterceptor.add(myInterceptor);
    }
  }

  void checkpermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    permission = await Geolocator.checkPermission();
    print("permissionresult:$permission");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("denied");
    } else if (permission == LocationPermission.whileInUse) {
      print("whileInUse56362");
      //setState(() {

      AppConstant.cuttentlocation()
          .whenComplete(() => AppConstant.cuttentlocation().then((value) {
                current_address = value;
              }));

      //});

    } else if (permission == LocationPermission.always) {
      print("always");
      //setState(() {

      AppConstant.cuttentlocation()
          .whenComplete(() => AppConstant.cuttentlocation().then((value) {
                current_address = value;
              }));
      //});
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ).then((value) => value as bool);
  }

  void CallApiforBanner() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).banners().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.data!.length);
            banner_image.addAll(response.data!);
            image12.clear();
            for (int i = 0; i < banner_image.length; i++) {
              image12.add(banner_image[i].imagePath! + banner_image[i].image!);
              banner_title.add(banner_image[i].title);
            }
            int length123 = image12.length;
            print("StringlistSize:$length123");
          } else {
            AppConstant.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      //AppConstant.toastMessage("Internal Server Error");
    });
  }

  void CallApiForCategory() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).categories().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.data!.length);
            categorydataList.addAll(response.data!);
            int size = categorydataList.length;
          } else {
            AppConstant.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
    });
  }

  int _current = 0;

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    double defaultScreenWidth = screenwidth;
    double defaultScreenHeight = screenHeight;

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

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
          child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: appbar(context, 'Home', _drawerscaffoldkey, false)
                    as PreferredSizeWidget?,
                resizeToAvoidBottomInset: true,
                key: _drawerscaffoldkey,
                drawer: new DrawerOnly(name),
                body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Code for image slider

                        Container(
                          width: screenwidth,
                          height: 200,
                          color: Colors.transparent,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                          child: Card(
                            elevation: 10,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height: 190,
                                      viewportFraction: 1.0,
                                      onPageChanged: (index, index1) {
                                        setState(() {
                                          _current = index;
                                        });
                                      },
                                    ),

                                    // items: image12.map((it){

                                    items: banner_image.map((it) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                              child: Stack(
                                            children: <Widget>[
                                              Material(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                elevation: 2.0,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                type: MaterialType.transparency,
                                                /*  child: Image.network(it,
                                                    height: 200,
                                                    width: 500,
                                                    fit: BoxFit.fitWidth,
                                                ),*/
                                                child: ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black12
                                                          .withOpacity(0.4),
                                                      BlendMode.srcOver),
                                                  child: CachedNetworkImage(
                                                    imageUrl: it.imagePath! +
                                                        it.image!,
                                                    height: 200,
                                                    width: 500,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        (context, url) =>
                                                            SpinKitFadingCircle(
                                                      color: Color(AppConstant
                                                          .pinkcolor),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "images/no_image.png"),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  it.title!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              )
                                              // (() {
                                              //   for (int i = 0;
                                              //       i < banner_image.length;
                                              //       i++)
                                              //     return Center(
                                              //       child: Text(
                                              //         banner_title[i]!,
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontSize: 26,
                                              //             fontWeight:
                                              //                 FontWeight.w800),
                                              //       ),
                                              //     );
                                              // }()),
                                            ],
                                          ));
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: map<Widget>(image12, (index, url) {
                                  //     return Container(
                                  //       alignment: Alignment.bottomCenter,
                                  //       width: 9.0,
                                  //       height: 9.0,
                                  //       margin: EdgeInsets.symmetric(
                                  //           vertical: 10.0, horizontal: 2.0),
                                  //       decoration: BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         color: _current == index
                                  //             ? Color(AppConstant.pinkcolor)
                                  //             : Color(0xFFffffff),
                                  //       ),
                                  //     );
                                  //   }) as List<Widget>,
                                  // ),
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
                                                      ? Color(
                                                          AppConstant.pinkcolor)
                                                      : Color(0xFFffffff),
                                                ),
                                              ))
                                      // map<Widget>(image12, (index, url) {
                                      //   return ;
                                      // }) as List<Widget>,
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Top Services',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: GridView.count(
                            childAspectRatio: 2.3,
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            mainAxisSpacing: ScreenUtil().setWidth(10),
                            children:
                                List.generate(categorydataList.length, (index) {
                              return Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    print(index);
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TopService(index,categorydataList[index].name)));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new DetailBarber(
                                                    categorydataList[index]
                                                        .catId)));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                        right: ScreenUtil().setWidth(10)),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      color: Colors.white,
                                      elevation: 5,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(20),
                                                right:
                                                    ScreenUtil().setWidth(10)),
                                            child: CachedNetworkImage(
                                              imageUrl: categorydataList[index]
                                                      .imagePath! +
                                                  categorydataList[index]
                                                      .image!,
                                              width: ScreenUtil().setWidth(30),
                                              height:
                                                  ScreenUtil().setHeight(30),
                                              fit: BoxFit.fill,
                                              color:
                                                  Color(AppConstant.pinkcolor),
                                              placeholder: (context, url) =>
                                                  SpinKitFadingCircle(
                                                color: Color(
                                                    AppConstant.pinkcolor),
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "images/no_image.png"),
                                            ),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(75),
                                            child: Text(
                                              categorydataList[index].name!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ))),
          ),
        ));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App ?'),
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
}
