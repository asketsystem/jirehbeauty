import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/common/common_view.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TermsCondition extends StatefulWidget {
  @override
  _TermsCondition createState() => new _TermsCondition();
}

class _TermsCondition extends State<TermsCondition> {
  bool datavisible = false;
  bool _loading = false;
  String? termsdata = '';
  String name = "User";

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    AppConstant.CheckNetwork().whenComplete(() => CallApiForSettings());
    name = PreferenceUtils.getString(AppConstant.username);
  }

  void CallApiForSettings() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).settings().then((response) {
      setState(() {
        if (response.success = true) {
          _loading = false;
          datavisible = true;

          termsdata = response.data!.termsConditions;
        } else {
          datavisible = false;

          AppConstant.toastMessage("No Data");
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      AppConstant.toastMessage("Internal Server Error");
    });
  }

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        opacity: 1.0,
        color: Colors.transparent.withOpacity(0.2),
        progressIndicator:
            SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
        child: new SafeArea(
          child: Scaffold(
            appBar:
                appbar(context, 'Terms & Condition', _drawerscaffoldkey, false)
                    as PreferredSizeWidget?,
            body: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: true,
              key: _drawerscaffoldkey,
              drawer: new DrawerOnly(name),
              body: new Stack(children: <Widget>[
                datavisible
                    ? Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 60),
                        child: new SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Html(
                            data: termsdata,
                          ),
                        ),
                      )
                    : Container(
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
                new Container(alignment: Alignment.bottomCenter, child: Body())
              ]),
            ),
          ),
        ),
      ),
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
