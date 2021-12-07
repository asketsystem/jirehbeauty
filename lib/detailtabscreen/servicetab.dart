import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/common/customcheckbox.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:barber_app/separator/separator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:barber_app/common/customwidget.dart';
import 'package:barber_app/screens/bookapointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selectable GridView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ServiceTab(),
    );
  }
}

class ServiceTab extends StatefulWidget {
  List<Category> categorylist;
  var salonId;
  var salonData;

  ServiceTab(this.categorylist, this.salonId, this.salonData);

  @override
  _ServiceTab createState() => _ServiceTab();
}

class _ServiceTab extends State<ServiceTab> {
  List<Category> categorylist = <Category>[];
  List<Service> catservice = <Service>[];
  // List catservice = [];
  List<int?> _selecteServices = <int?>[];
  List<String?> _selecteServicesName = <String?>[];
  List _totalprice = [];
  var salonId;
  var salonData;
  bool viewVisible = false;
  double totalprice = 0;

  bool datavisible = false;
  bool nodatavisible = true;

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();

    categorylist = widget.categorylist;
    salonId = widget.salonId;
    salonData = widget.salonData;

    // int gallength = galleydataList.length;
    // print("gallength:$gallength");

    // print(categorylist[0].service[0].name);

    currentSelectedIndex = 0;
    currentSelectedIndex1 = 0;

    if (categorylist[currentSelectedIndex].service!.length > 0) {
      datavisible = true;
      nodatavisible = false;

      catservice.addAll(categorylist[currentSelectedIndex].service!);
      var catservicelength = catservice.length;
      print("catservicelength:$catservicelength");
    } else {
      datavisible = false;
      nodatavisible = true;
    }
  }

  int currentSelectedIndex = 0;
  int currentSelectedIndex1 = 0;
  String? categoryname;
  bool value = false;
  bool _btnEnabled = false;

  // var  color = currentSelectedIndex
  //     ? Color(0xFFe06287)
  //     : Color(0xFFa5a5a5);

  /* List categorydatalist = [

    {
      "category": "Salon",
      "dark_color": const Color(0xFFb5b8ff),
      "light_color": const Color(0xFFc8caff)
    },
    {
      "category": "Styling",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },
    {
      "category": "Mackup",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },
    {
      "category": "Shaving",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },
    {
      "category": "Shampoo",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },

    {
      "category": "Shampoo",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },

    {
      "category": "Shampoo",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },
    {
      "category": "Shampoo",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },
    {
      "category": "Shampoo",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },
  ];*/

  int _current = 0;

  void bookapointment() {
    print('CALLBACK: _onDaySelected');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: new Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 50),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          // child:

                          Container(
                            // height: screenHeight* 0.5,
                            color: Colors.white,
                            // color: Colors.red,
                            alignment: FractionalOffset.topCenter,
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  // color: Colors.white,
                                  height: 45,

                                  // height:screenHeight * .06,
                                  child: ListView.builder(
                                    itemCount: categorylist.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      bool isSelected =
                                          currentSelectedIndex == index;

                                      return GestureDetector(
                                        onTap: () {
                                          catservice.clear();
                                          setState(() {
                                            // value = !value;
                                            categoryname =
                                                categorylist[index].name;
                                            currentSelectedIndex = index;

                                            if (categorylist[index]
                                                    .service!
                                                    .length >
                                                0) {
                                              datavisible = true;
                                              nodatavisible = false;

                                              catservice.addAll(
                                                  categorylist[index].service!);
                                              var catservicelength =
                                                  catservice.length;
                                              print(
                                                  "catservicelength:$catservicelength");
                                            } else {
                                              datavisible = false;
                                              nodatavisible = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5.0),
                                          child: TextButton(
                                            onPressed: null,
                                            style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  side: BorderSide(
                                                      color: isSelected
                                                          ? Color(AppConstant
                                                              .pinkcolor)
                                                          : Color(0xFFa5a5a5))),
                                            ),
                                            child: Text(
                                              categorylist[index].name!,
                                              style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Color(0xFFa5a5a5),
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          decoration: isSelected
                                              ? BoxDecoration(
                                                  color: Color(
                                                      AppConstant.pinkcolor),
                                                  border: Border.all(
                                                    color: Color(
                                                        AppConstant.pinkcolor),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                )
                                              : BoxDecoration(),
                                        ),
                                      );

                                      /* return CustomWidget(
                                        category: categorylist[index].name,
                                        index: index,
                                        isSelected: currentSelectedIndex == index,
                                        onSelect: () {
                                          setState(() {
                                            categoryname =
                                            categorylist[index].name;
                                            currentSelectedIndex = index;
                                          });
                                        },
                                      );*/
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 0.0, left: 10, right: 10),
                                    color: Colors.white,
                                    height: 40,
                                    // height:screenHeight * .06,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: 20, top: 5),
                                          alignment: Alignment.topLeft,

                                          // child:Text(categoryname.toString(),style: TextStyle(color:Colors.black,fontWeight: FontWeight.w800,fontSize: 18)),
                                          child: Text("",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16)),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20, top: 5),
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                                onTap: () {
                                                  // _newTaskModalBottomSheet(context);
                                                },
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: "Filter ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Montserrat")),
                                                      WidgetSpan(
                                                        child: Icon(
                                                          Icons
                                                              .filter_alt_sharp,
                                                          size: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 00),

                                  // height: screenHeight * 0.31,
                                  height: 300,

                                  child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        Visibility(
                                          visible: datavisible,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0.0,
                                                left: 15,
                                                right: 0,
                                                bottom: 130),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var catid = categorylist[
                                                        currentSelectedIndex]
                                                    .catId;
                                                var serId =
                                                    catservice[index].serviceId;

                                                // bool _value = catid == serId;
                                                print("serId:$serId" +
                                                    "  " +
                                                    "catid:$catid");
                                                print("value123456:$serId");

                                                var color = catservice[index]
                                                        .isSelected
                                                    ? Color(
                                                        AppConstant.pinkcolor)
                                                    : Color(0xFFa5a5a5);

                                                return GestureDetector(
                                                  child: Container(
                                                    height: 60,
                                                    width: screenwidth,
                                                    child: Row(
                                                      children: <Widget>[
                                                        new Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 5),
                                                          width: 20,
                                                          height: 20,
                                                          color: Colors.white,

                                                          // child: new CustomCheckBox(value),

                                                          //
                                                          child: Container(
                                                              width: 15,
                                                              height: 15,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    // if (catservice.any((item) => item.isSelected)) {

                                                                    catservice[
                                                                            index]
                                                                        .isSelected = !catservice[
                                                                            index]
                                                                        .isSelected;
                                                                    print(catservice[
                                                                            index]
                                                                        .isSelected);
                                                                    // }
                                                                    print(catservice[
                                                                            index]
                                                                        .serviceId);

                                                                    if (catservice[index]
                                                                            .isSelected ==
                                                                        true) {
                                                                      setState(
                                                                          () {
                                                                        currentSelectedIndex1 =
                                                                            index;
                                                                        _selecteServices
                                                                            .add(catservice[index].serviceId);
                                                                        _selecteServicesName
                                                                            .add(catservice[index].name);
                                                                        _totalprice
                                                                            .add(catservice[index].price);
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        _selecteServices
                                                                            .remove(catservice[index].serviceId);
                                                                        _selecteServicesName
                                                                            .remove(catservice[index].name);
                                                                        _totalprice
                                                                            .remove(catservice[index].price);
                                                                      });
                                                                    }

                                                                    if (_selecteServices
                                                                        .isEmpty) {
                                                                      setState(
                                                                          () {
                                                                        viewVisible =
                                                                            false;
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        viewVisible =
                                                                            true;
                                                                      });
                                                                    }

                                                                    String
                                                                        _selecteServicesslen =
                                                                        _selecteServices
                                                                            .toString();
                                                                    print(
                                                                        "_selecteCategoryslen:$_selecteServicesslen");
                                                                    totalprice = _totalprice.fold(
                                                                        0,
                                                                        (p, c) =>
                                                                            p +
                                                                            c);
                                                                    print(
                                                                        "sum:$totalprice");
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        color,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: const Color(
                                                                          0xFFdddddd),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            1.0),
                                                                    child: catservice[index]
                                                                            .isSelected
                                                                        ? Icon(
                                                                            Icons.check,
                                                                            size:
                                                                                15.0,
                                                                            color:
                                                                                Colors.white,
                                                                          )
                                                                        : Icon(
                                                                            Icons.check_box_outline_blank_outlined,
                                                                            size:
                                                                                15.0,
                                                                            color:
                                                                                color,
                                                                          ),
                                                                  ),
                                                                ),
                                                              )),
                                                        ),
                                                        new Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 5),
                                                          height: 35,
                                                          width: 35,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child:
                                                              CachedNetworkImage(
                                                            height: 35,
                                                            width: 35,
                                                            imageUrl: catservice[
                                                                        index]
                                                                    .imagePath! +
                                                                catservice[
                                                                        index]
                                                                    .image!,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                ),
                                                              ),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                SpinKitFadingCircle(
                                                                    color: Color(
                                                                        AppConstant
                                                                            .pinkcolor)),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    "images/no_image.png"),
                                                          ),
                                                        ),
                                                        new Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 10),
                                                            height: 50,
                                                            // margin: EdgeInsets.only(left: 10,top: 10),
                                                            // width: double.infinity,

                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .60,
                                                                  height: 30,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              1,
                                                                          top:
                                                                              2,
                                                                          right:
                                                                              15),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          catservice[index]
                                                                              .name!,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                              fontFamily: 'Montserrat'),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          catservice[index].price.toString() +
                                                                              ' ₹',
                                                                          style: TextStyle(
                                                                              color: const Color(0xFF999999),
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                              fontFamily: 'Montserrat'),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .65,
                                                                  height: 10,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              1,
                                                                          top:
                                                                              8,
                                                                          right:
                                                                              10),
                                                                  child:
                                                                      MySeparator(),
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                );

                                                /*  return new Checklist(
                                                  category: categoryname,
                                                  dark_color: categorylist[index].name,
                                                  light_color: categorylist[index].name,

                                                );
                                                */
                                              },
                                              itemCount: catservice.length,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: nodatavisible,
                                          child: SizedBox(
                                            width: screenwidth,
                                            height: 130,
                                            child: Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      5.0, 50.0, 0.0),
                                              child: Center(
                                                child: Container(
                                                    width: screenwidth,
                                                    height: screenHeight,
                                                    alignment: Alignment.center,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "images/nodata.png",
                                                          alignment:
                                                              Alignment.center,
                                                          width: 150,
                                                          height: 100,
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "No Service Available ",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFFa3a3a3),
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewVisible,
                      child: Container(
                        height: 50,
                        color: Colors.blue,
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // width:screenwidth * .35,
                              margin: EdgeInsets.only(left: 10),
                              alignment: FractionalOffset.centerLeft,
                              child: Text(
                                ("Total : " + totalprice.toString()) + " ₹ ",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            Container(

                                // width: screenwidth * .45,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                alignment: FractionalOffset.center,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (PreferenceUtils.getlogin(
                                            AppConstant.isLoggedIn) ==
                                        true) {
                                      print("totalprice:$totalprice");
                                      print(_selecteServices);
                                      print(salonId);
                                      print(_selecteServicesName);
                                      print(_totalprice);
                                      print(salonData.name);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new BookApointment(
                                                      totalprice,
                                                      _selecteServices,
                                                      salonId,
                                                      _selecteServicesName,
                                                      _totalprice,
                                                      salonData)));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new LoginScreen(6)));
                                    }
                                  },
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Book service",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        fontSize: 14),
                                  ),
                                )),

                            // InkWell(
                            //
                            //   child: Container(
                            //     width: screenwidth * .05,
                            //     margin: EdgeInsets.only(left: 5),
                            //     alignment: FractionalOffset.center,
                            //
                            //     child: SvgPicture.asset("images/cancel.svg",
                            //
                            //     ),
                            //
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )

            /*

        ),*/

            ),
      ),
    );
  }

  void openBottomSheetforOrderType() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 50,
                margin: EdgeInsets.only(top: 30, left: 15, bottom: 20),
                // height: screenHeight,

                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 1,
                ),
                // You can wrap this Column with Padding of 8.0 for better design
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[]),
              );
            },
          );
        });
  }
}
