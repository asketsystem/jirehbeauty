import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';



class ReViewTab extends StatefulWidget {
  List<Review> reviewlist;

  ReViewTab(this.reviewlist);

  @override
  _ReViewTab createState() => _ReViewTab();
}

class _ReViewTab extends State<ReViewTab> {
  List<Review> reviewlist = <Review>[];

  int? currentSelectedIndex;
  String? categoryname;
  var rating = 0.0;
  bool datavisible = false;
  bool nodatavisible = true;

  // List categorydatalist = [
  //   {
  //     "category": "All",
  //     "dark_color": const Color(0xFFffb5cc),
  //     "light_color": const Color(0xFFffc8de),
  //   },
  //   {
  //     "category": "Salon",
  //     "dark_color": const Color(0xFFb5b8ff),
  //     "light_color": const Color(0xFFc8caff)
  //   },
  //   {
  //     "category": "Styling",
  //     "dark_color": const Color(0xFFffb5b5),
  //     "light_color": const Color(0xFFffc8c8)
  //   },
  //   {
  //     "category": "Mackup",
  //     "dark_color": const Color(0xFFffb5b5),
  //     "light_color": const Color(0xFFffc8c8)
  //   },
  //   {
  //     "category": "Shaving",
  //     "dark_color": const Color(0xFFffb5b5),
  //     "light_color": const Color(0xFFffc8c8)
  //   },
  //   {
  //     "category": "Shampoo",
  //     "dark_color": const Color(0xFFffb5b5),
  //     "light_color": const Color(0xFFffc8c8)
  //   },
  //
  //
  // ];

  @override
  void initState() {
    super.initState();
    if (widget.reviewlist.length > 0) {
      reviewlist = widget.reviewlist;
      datavisible = true;
      nodatavisible = false;
    } else {
      datavisible = false;
      nodatavisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Padding(
              padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 50),

              // padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 10, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Review',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        /*GestureDetector(
                          onTap: () {
                            _newTaskModalBottomSheet(context);
                          },
                          child: Text(
                            '+ Add Your Review',
                            style: TextStyle(
                                color: const Color(0xFF4a92ff),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Total Review' + "(" + reviewlist.length.toString() + ")",
                      style: TextStyle(
                          color: const Color(0xFFaeaeae),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Visibility(
                          visible: datavisible,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 0.0, left: 0, right: 10, bottom: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                DateTime today = new DateTime.now();

                                String difference;
                                String difference1;

                                String date = reviewlist[index].createdAt!;

                                difference1 =
                                    "${today.difference(DateTime.parse(date)).inHours}" +
                                        " Hours Ago.";
                                difference =
                                    "${today.difference(DateTime.parse(date)).inHours}";

                                int diffrennce12 = int.parse(difference);

                                if (diffrennce12 > 24) {
                                  difference1 =
                                      "${today.difference(DateTime.parse(date)).inDays}" +
                                          " Days Ago.";
                                }

                                return new Container(
                                  alignment: Alignment.topLeft,
                                  // margin: EdgeInsets.all(10.0),
                                  width: screenwidth,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: screenwidth * .12,
                                        height: 75,
                                        // color: Colors.white,
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(left: 0),

                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 15),
                                              height: 40.0,
                                              width: screenwidth * .12,
                                              alignment: Alignment.centerLeft,

                                              // child:CircleAvatar(
                                              // radius: 55,
                                              // // backgroundColor: Color(0xffFDCF09),
                                              child: CachedNetworkImage(
                                                height: 35,
                                                width: 35,
                                                imageUrl: reviewlist[index]
                                                        .user!
                                                        .imagePath! +
                                                    reviewlist[index]
                                                        .user!
                                                        .image!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                      alignment:
                                                          Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),

                                                placeholder: (context, url) =>
                                                    SpinKitFadingCircle(
                                                        color: Color(AppConstant
                                                            .pinkcolor)),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "images/no_image.png"),
                                                // radius: 50,
                                                // backgroundImage: CachedNetworkImage(imageUrl: ""),
                                              ),
                                              // ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(top: 1),
                                              height: 12.0,
                                              width: screenwidth * .12,

                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 2),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0, left: 10),
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
                                                          top: 0, left: 2),
                                                      child: Text(
                                                          reviewlist[index]
                                                              .rate
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xFFffc107),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'Montserrat')),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // child: Text("4.0",style: TextStyle(color: const Color(0xFFffc107),fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'Montserrat'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only(
                                            top: 5, left: 0, right: 5),
                                        width: screenwidth * .75,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFf1f1f1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              height: 30,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      reviewlist[index]
                                                          .user!
                                                          .name!,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5, right: 10),
                                                    child: Text(
                                                      difference1,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF999999),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 20,
                                                  bottom: 10),

                                              child: Text(
                                                reviewlist[index].message!,
                                                style: TextStyle(
                                                  color: Color(0xFF999999),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Montserrat',
                                                ),
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              // color: Colors.yellow
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                /* return new ReviewData(
                                  category: categorydatalist[index]
                                  ['category'],
                                  dark_color: categorydatalist[index]
                                  ['dark_color'],
                                  light_color: categorydatalist[index]
                                  ['light_color'],
                                );*/
                              },
                              itemCount: reviewlist.length,
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
                                  Matrix4.translationValues(5.0, 50.0, 0.0),
                              child: Center(
                                child: Container(
                                    width: screenwidth,
                                    height: screenHeight,
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
                                            "No Review",
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
                        ),
                      ]),
                ],
              ))),
    );
  }

  void _newTaskModalBottomSheet(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 15, bottom: 20),
                  // height: screenHeight,

                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 1,
                  ),
                  // You can wrap this Column with Padding of 8.0 for better design
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            'Share Your Experience',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat"),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              top: 25, left: 5, right: 10, bottom: 5),
                          width: screenwidth,
                          height: 70,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: screenwidth * .2,
                                height: 70,
                                // color: Colors.white,
                                alignment: Alignment.center,

                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 40.0,
                                      width: 40.0,
                                      child: CircleAvatar(
                                        radius: 55,
                                        // backgroundColor: Color(0xffFDCF09),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage(
                                              'images/the_barber.jpg'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    EdgeInsets.only(top: 10, left: 5, right: 5),
                                width: screenwidth * .65,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFf1f1f1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  // margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                                  child: TextFormField(
                                    autofocus: false,
                                    initialValue: "Excellent Service.",
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    maxLines: 8,

                                    // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFFf1f1f1),
                                      hintText: 'Enter review',
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0,
                                          bottom: 0.0,
                                          top: 5.0,
                                          right: 5),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFf1f1f1)),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFf1f1f1)),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          child: Text(
                            'How Many Stars you will Give',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat"),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          alignment: Alignment.topLeft,
                          child: RatingStars(
                            value: rating,
                            onValueChanged: (v) {
                              setState(() {
                                rating = v;
                                print(v);
                              });

                              // setState(() {
                              //   value = v;
                              // });
                            },
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                            ),
                            starCount: 5,
                            starSize: 20,
                            // valueLabelColor: const Color(0xFFffc107),
                            // valueLabelTextStyle: const TextStyle(
                            //     color: Colors.white,
                            //     fontWeight: FontWeight.w400,
                            //     fontStyle: FontStyle.normal,
                            //     fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 2.5,
                            maxValueVisibility: false,
                            valueLabelVisibility: false,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Color(0xFFffc107),
                          ),
                          // child: SmoothStarRating(
                          //   defaultIconData: Icons.star,
                          //   spacing: 2.5,
                          //   rating: 3,
                          //   color: Color(0xFFffc107),
                          //   borderColor: Colors.grey,
                          //   allowHalfRating: false,
                          //   size: 24,
                          //   starCount: 5,
                          //   onRated: (value) {
                          //     setState(() {
                          //       rating = value;
                          //       print(value);
                          //     });
                          //   },
                          // ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: BorderSide(
                                      color: Color(AppConstant.pinkcolor),
                                      width: 2)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Share Review',
                              style: TextStyle(
                                  color: Color(AppConstant.pinkcolor),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ]),
                ),
              );
            },
          );
        });
  }
}
