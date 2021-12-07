import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';

import 'package:barber_app/common/common_view.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/drawerscreen/top_offers.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmBooking extends StatefulWidget {
  double? totalprice;
  List<int?>? selecteServices = <int>[];

  int? salonId;
  var date;

  var time;
  int? selectedempid;
  List? _totalprice = [];

  List<String?>? _selecteServicesName = <String>[];

  var salonData;
  bool couponvisible;
  bool couponnotvisible;

  ConfirmBooking(
      this.selectedempid,
      this.time,
      this.date,
      this.totalprice,
      this.selecteServices,
      this.salonId,
      this._selecteServicesName,
      this._totalprice,
      this.salonData,
      this.couponvisible,
      this.couponnotvisible);

  @override
  _ConfirmBooking createState() => new _ConfirmBooking();
}

class _ConfirmBooking extends State<ConfirmBooking> {
  bool _loading = false;
  double? totalprice;
  List<int>? selecteServices = <int>[];
  int? salonId;
  var date;
  var time;
  int? selectedempid;
  List? _totalprice = [];
  var rating = 1.0;

  List<String>? _selecteServicesName = <String>[];
  late var parsedDate;

  var salonData;
  bool couponvisible = true;
  bool couponnotvisible = false;
  final _formKey = GlobalKey<FormState>();
  String? _message;
  CardFieldInputDetails? _card = CardFieldInputDetails(complete: false);

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    PreferenceUtils.init();

    AppConstant.CheckNetwork().whenComplete(() => CallApiPaymentGatway());

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    totalprice = widget.totalprice;
    selecteServices = widget.selecteServices!.cast<int>();
    salonId = widget.salonId;
    date = widget.date;
    time = widget.time;
    selectedempid = widget.selectedempid;
    _totalprice = widget._totalprice;
    _selecteServicesName = widget._selecteServicesName!.cast<String>();
    salonData = widget.salonData;
    couponvisible = widget.couponvisible;
    couponnotvisible = widget.couponnotvisible;

    var address = salonData.address;

    parsedDate = DateTime.parse(date);
    // var now = date;
    // var df  = new DateFormat('dd-MMM-yyyy');
    var df = new DateFormat('MMMM dd,yyyy');

    parsedDate = df.format(parsedDate);

    // print(df.format(parsedDate));
    // print("booktotalprice:$totalprice");
    // print("bookselecteServices:$selecteServices");
    // print("booksalonId:$salonId");
    // print("bookdate:$date");
    // print("booktime:$time");
    // print("bookselectedempid:$selectedempid");
    // print("book_totalprice:$_totalprice");
    // print("book_selecteServicesName:$_selecteServicesName");
    // print("book_address:$address");
  }

  void CallApiPaymentGatway() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).paymentgateway().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.success);

            stripkey = response.data!.stripePublicKey;
            // rozarkey = response.data!.razorPublic;

            //TODO:stripe change
            // StripePayment.setOptions(StripeOptions(
            //     publishableK6ey: stripkey, merchantId: "Test", androidPayMode: 'test'));
            Stripe.publishableKey = stripkey!;

            print("stripekey456:$stripkey");
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

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  String _result = "paypal";
  int? _radioValue = -1;

  // TODO: Stripe change
  // PaymentMethod? _paymentMethod;
  String? _error;
  late Razorpay _razorpay;

  String? stripkey = "";
  String? rozarkey = " ";

  void setError(dynamic error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _result = "paypal";
          AppConstant.toastMessage("Select COD");
          _sucesspayment(context, _radioValue, _result);

          break;
        case 1:
          // _result = "rozarpay";
          // openCheckout(context, _result);

          // AppConstant.toastMessage("Select COD");
          // _sucesspayment(context, _radioValue,_result);

          break;
        case 2:
          _result = "stripe";

          setstripe(context, _result);

          // AppConstant.toastMessage("Select COD");

          // _sucesspayment(context, _radioValue,_result);

          break;
        case 3:
          _result = "LOCAL";
          _sucesspayment(context, _radioValue, _result);

          break;
      }
    });
  }

  void _sucesspayment(BuildContext context, int? radioValue, String result) {
    String paymentToken = "";

    AppConstant.CheckNetwork()
        .whenComplete(() => CallApiforBookService(result, paymentToken));
  }

  void setstripe(BuildContext context, String result) {
    Stripe.publishableKey = stripkey!;
    // showDialog(
    //           context: context,
    //           barrierDismissible: false,
    //           builder: (BuildContext context) {
    //             return AlertDialog(
    //               title: Text("Confirm Exit"),
    //               content: Text("Are you sure you want to exit?"),
    //               actions: <Widget>[
    //                 TextButton(
    //                   child: Text("YES"),
    //                   onPressed: () {
    //                     SystemNavigator.pop();
    //                   },
    //                 ),
    //                 TextButton(
    //                   child: Text("NO"),
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                 )
    //               ],
    //             );
    //           });
    //
    //
    //
    // TODO:stripe change
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Stripe",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                  ),
                  CardField(
                    enablePostalCode: false,
                    onCardChanged: (card) {
                      setState(() {
                        _card = card;
                      });
                    },
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton(
                        child: Text("pay"),
                        onPressed: () {
                          if (_card!.complete == true && _card!.last4!.isNotEmpty) {
                            _handleCreateTokenPress(result);
                          } else {
                            AppConstant.toastMessage(
                                "Something went wrong in Stripe payment");
                          }
                        },
                      ))
                ],
              ),
            ),
          );
        });
  }

  //stripe
  Future<void> _handleCreateTokenPress(result) async {
    if (_card == null) {
      return;
    }

    try {
      final tokenData = await Stripe.instance.createToken(
        CreateTokenParams(type: TokenType.Card),
      );
      Navigator.pop(context);
      AppConstant.CheckNetwork()
          .whenComplete(() => CallApiforBookService(result, tokenData.id));
      return;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      rethrow;
    }
  }

  void openCheckout(BuildContext context, String result) {
    var options = {
      'key': rozarkey,
      'amount': totalprice! * 100,
      'name': PreferenceUtils.getString(AppConstant.username),
      'description': 'Payment',
      'prefill': {
        'contact': PreferenceUtils.getString(AppConstant.userphone),
        'email': PreferenceUtils.getString(AppConstant.useremail)
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      print(response.paymentId);
      String paymentToken = response.paymentId.toString();

      AppConstant.CheckNetwork()
          .whenComplete(() => CallApiforBookService("rozarpay", paymentToken));
      print("done");
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!, timeInSecForIosWeb: 4);
  }

  void CallApiforBookService(String result1, String paymentToken) {
    print("con_salonid:$salonId");
    print("con_selectedempid:$selectedempid");
    print("con_selecteServices:$selecteServices");
    print("con_totalprice:$totalprice");
    print("con_date:$date");
    print("con_time:$time");
    print("con_result1:$result1");
    print("con_paymentToken:$paymentToken");

    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data())
        .booking(
      selectedempid.toString(),
      selecteServices.toString(),
      totalprice.toString(),
      date.toString(),
      time.toString(),
      result1,
      paymentToken,
    )
        .then((response) {
      print("bookinresponse:${response.toString()}");
      setState(() {
        _loading = false;
        if (response.success = true) {
          showsucess();
        } else {
          AppConstant.toastMessage("No Data");
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);

      print("bookinresponse_error:${obj.toString()}");
    });
  }

  int? currentSelectedIndex;
  String? categoryname;
  int _groupValue = -1;

  bool viewVisible = false;

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  CalendarCarousel? _calendarCarousel, _calendarCarouselNoHeader;
  DateTime _currentDate = new DateTime.now();
  DateTime _currentDate2 = new DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

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
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Book Appointment",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
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
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (ctxt) => new HomeScreen(0)));

                  // do something
                },
              ),
            ],
          ),
          body: Scaffold(
              resizeToAvoidBottomInset: true,
              key: _drawerscaffoldkey,
              backgroundColor: Colors.white,
              //set gobal key defined above

              body: new Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: new ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: 10.0,
                                bottom: 00.0,
                                left: 30.0,
                                right: 0.0,
                              ),
                              color: Colors.white,
                              child: Text(
                                "Confirmation Your Booking",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              height: 120,
                              margin: EdgeInsets.all(10),
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                height: 120,
                                // constraints: BoxConstraints.expand(),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFf1f1f1), width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),

                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left: 5.0, top: 0.0),
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              height: 70,
                                              width: 70,
                                              alignment: Alignment.topLeft,
                                              child: CachedNetworkImage(
                                                imageUrl: salonData.imagePath +
                                                    salonData.image,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
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
                                              ),
                                            ),
                                            new Container(
                                                width: screenwidth * .65,
                                                height: 110,
                                                margin: EdgeInsets.only(
                                                    left: 5.0, top: 0.0),
                                                alignment: Alignment.topLeft,
                                                color: Colors.white,
                                                child: ListView(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20.0),
                                                      child: Text(
                                                        salonData.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Montserrat'),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5.0),
                                                      child: Text(
                                                        salonData.address,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Montserrat'),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            0.0,
                                                                        top:
                                                                            5.0),
                                                                child: RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      WidgetSpan(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .star,
                                                                          size:
                                                                              14,
                                                                          color:
                                                                              Colors.yellow,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                          text: salonData
                                                                              .rate
                                                                              .toString(),
                                                                          // maxLines: 1,
                                                                          // overflow: TextOverflow.ellipsis,

                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11,
                                                                              fontWeight: FontWeight.w600)),
                                                                      TextSpan(
                                                                          text:
                                                                              " Rating",
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11,
                                                                              fontFamily: 'Montserrat',
                                                                              fontWeight: FontWeight.w600)),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 5.0,
                                                              height: 5.0,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5.0,
                                                                      top: 5.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5.0,
                                                                        top:
                                                                            5.0,
                                                                        right:
                                                                            0),
                                                                child: RichText(
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textScaleFactor:
                                                                      1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      WidgetSpan(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .calendar_today,
                                                                          size:
                                                                              14,
                                                                          color:
                                                                              Color(AppConstant.pinkcolor),
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                          text: time.toString() +
                                                                              " - " +
                                                                              parsedDate
                                                                                  .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 11,
                                                                              fontWeight: FontWeight.w600)),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        )),
                                  ],
                                ),

                                // color: Colors.grey,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(
                                top: 10.0,
                                bottom: 00.0,
                                left: 30.0,
                                right: 0.0,
                              ),
                              color: Colors.white,
                              child: Text(
                                "Service You Selected",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),

                            Container(
                              /* margin: EdgeInsets.only(
                                top: 10.0,
                                bottom: 00.0,
                                left: 30.0,
                                right: 15.0,
                              ),
                              color: Colors.white,*/
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _selecteServicesName!.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 00.0,
                                      left: 30.0,
                                      right: 15.0,
                                    ),
                                    color: Colors.white,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                _selecteServicesName![index],
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF999999),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat'),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                _totalprice![index].toString() +
                                                    " ₹",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF999999),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                            child: DottedLine(
                                          direction: Axis.horizontal,
                                          lineLength: double.infinity,
                                          lineThickness: 1.0,
                                          dashLength: 4.0,
                                          dashColor: Color(0xe2777474)
                                              .withOpacity(0.3),
                                          dashRadius: 0.0,
                                          dashGapLength: 4.0,
                                          dashGapColor: Colors.transparent,
                                          dashGapRadius: 0.0,
                                        )),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 10.0),
                            // Container(
                            //     // alignment: Alignment.center,
                            //     margin: EdgeInsets.only(left: 35, right: 25),
                            //     child: DottedLine(
                            //       direction: Axis.horizontal,
                            //       lineLength: double.infinity,
                            //       lineThickness: 1.0,
                            //       dashLength: 4.0,
                            //       dashColor: Color(0xFF5eb58f),
                            //       dashRadius: 0.0,
                            //       dashGapLength: 4.0,
                            //       dashGapColor: Colors.transparent,
                            //       dashGapRadius: 0.0,
                            //     )),
                            Container(
                              height: 30,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 25, right: 15),
                              decoration: BoxDecoration(
                                  color: Color(0xFF80dcb4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: couponnotvisible,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: 15, top: 5),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'You have a coupon to use',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (ctxt) =>
                                                        new TopOffers(
                                                            1,
                                                            selectedempid,
                                                            time,
                                                            date,
                                                            totalprice,
                                                            selecteServices,
                                                            salonId,
                                                            _selecteServicesName,
                                                            _totalprice,
                                                            salonData)));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10, top: 6),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Click here',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: couponvisible,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: 15, top: 5),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'coupon applied',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10, top: 6),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'new price: ' +
                                                  totalprice.toString() +
                                                  " ₹",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //     // alignment: Alignment.center,
                            //     margin: EdgeInsets.only(left: 25, right: 15),
                            //     child: DottedLine(
                            //       direction: Axis.horizontal,
                            //       lineLength: double.infinity,
                            //       lineThickness: 1.0,
                            //       dashLength: 4.0,
                            //       dashColor: Color(0xFF5eb58f),
                            //       dashRadius: 0.0,
                            //       dashGapLength: 4.0,
                            //       dashGapColor: Colors.transparent,
                            //       dashGapRadius: 0.0,
                            //     )),

                            Container(
                              margin: EdgeInsets.only(
                                top: 20.0,
                                bottom: 00.0,
                                left: 30.0,
                                right: 0.0,
                              ),
                              color: Colors.white,
                              child: Text(
                                "Select Payment Method",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 50),
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Visibility(
                                    visible: false,
                                    child: Container(
                                      height: 40,
                                      margin: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 00.0,
                                        left: 30.0,
                                        right: 0.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 15),
                                            child: Image.asset(
                                              "images/paypal.png",
                                              width: 60,
                                              height: 40,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Radio(
                                              value: 0,
                                              groupValue: _radioValue,
                                              onChanged:
                                                  _handleRadioValueChange,
                                              activeColor:
                                                  Color(AppConstant.pinkcolor),

                                              // selected: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //razorpay is currently off
                                  // Container(
                                  //   height: 40,
                                  //   margin: EdgeInsets.only(
                                  //     top: 0.0,
                                  //     bottom: 00.0,
                                  //     left: 30.0,
                                  //     right: 0.0,
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Container(
                                  //         margin: EdgeInsets.only(left: 15),
                                  //         child: Image.asset(
                                  //           "images/rozarpay.png",
                                  //           width: 60,
                                  //           height: 40,
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         margin: EdgeInsets.only(right: 10),
                                  //         child: Radio(
                                  //           value: 1,
                                  //           groupValue: _radioValue,
                                  //           onChanged: _handleRadioValueChange,
                                  //           activeColor:
                                  //               Color(AppConstant.pinkcolor),
                                  //           // selected: false,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                      top: 0.0,
                                      bottom: 00.0,
                                      left: 30.0,
                                      right: 0.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: Image.asset(
                                            "images/stripe.png",
                                            width: 50,
                                            height: 30,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Radio(
                                            value: 2,
                                            groupValue: _radioValue,
                                            // onChanged: (value) {},
                                            onChanged: _handleRadioValueChange,
                                            activeColor:
                                                Color(AppConstant.pinkcolor),
                                            // selected: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                      top: 0.0,
                                      bottom: 00.0,
                                      left: 30.0,
                                      right: 0.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 15, bottom: 0, top: 0),
                                          child: Text(
                                            "Cash on Delivery",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Radio(
                                            value: 3,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadioValueChange,
                                            activeColor:
                                                Color(AppConstant.pinkcolor),
                                            // selected: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomView(),
                  ),
                ], // new Container(child: Body(viewVisible))],
              )),
        ),
      ),
    );
  }

  void showsucess() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
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
                      new Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 0.0),
                          alignment: FractionalOffset.center,
                          child: Image.asset(
                            "images/passwordchangedone.png",
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 15.0, right: 15),
                          child: Text(
                            "Your Appointment booking is successfully.",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 15.0, right: 15),
                          child: Text(
                            "You can see your upcoming appointment in APPOINTMENT section",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _radioValue = -1;

                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (ctxt) => new HomeScreen(1)));
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 40.0, left: 15.0, right: 15, bottom: 20),
                            child: Text(
                              "GO there",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      /*GestureDetector(
                        onTap: (){


                          // Navigator.of(context).pop();
                          // _newAddReview(context,id);

                        },


                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 20.0, left: 15.0, right: 15, bottom: 20),
                            child: Text(
                              "Add Review",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                      )*/
                    ]),
              );
            },
          );
        });
  }

  void _newAddReview(BuildContext context, int id) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;
    double height = 900.0;

    print("rateid:$id");

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 15, bottom: 20),
                  // height: screenHeight,

                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 1,
                  ),
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

                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    maxLines: 8,

                                    validator: (msg) {
                                      Pattern pattern =
                                          r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                      RegExp regex =
                                          new RegExp(pattern as String);
                                      if (!regex.hasMatch(msg!))
                                        return 'Invalid Message';
                                      else
                                        return null;
                                    },
                                    onSaved: (msg) => _message = msg,

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
                            },
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                            ),
                            starCount: 5,
                            starSize: 20,
                            valueLabelColor: const Color(0xff9b9b9b),
                            valueLabelTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: true,
                            valueLabelVisibility: false,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow,
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
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                AppConstant.CheckNetwork().whenComplete(
                                    () => callApiForaddReview(id, _message));

                                Navigator.pop(context);
                              }
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

                // You can wrap this Column with Padding of 8.0 for better design
              );
            },
          );
        });
  }

  void callApiForaddReview(int id, String? message) {
    print("bookid:$id");
    print("bookSalonid:$salonId");
    print("bookrate:$rating");
    print("bookmesage:$message");
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data())
        .addreview(message, rating.toString(), id.toString())
        .then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success = true) {
          print("sucess");

          AppConstant.toastMessage(response.msg!);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(1)),
          );
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
            AppConstant.toastMessage("Invalid Data");
            print(responsecode);
            print(res.statusMessage);
          } else if (responsecode == 422) {
            AppConstant.toastMessage("Invalid Email");
            print("code:$responsecode");
            print("msg:$msg");
          }

          break;
        default:
      }
    });
  }
}
