import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/screens/otpscreen.dart';
import 'package:barber_app/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'forgotpassword.dart';
import 'homescreen.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  int index;
  LoginScreen(this.index);

  @override
  _LoginScreen createState() => new _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  FocusNode? myFocusNode;
  String? _email, _password = "";
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator:
          SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
      child: Form(
        key: _formKey,
        child: new SafeArea(
          child: Scaffold(
            body: Stack(children: <Widget>[
              new Container(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('images/loginbg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new ListView(
                children: [
                  Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 150.0, left: 100.0),
                      alignment: FractionalOffset.topLeft,
                      child: Text(
                        "The",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0.0, left: 130.0),
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      "BARBER.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    alignment: FractionalOffset.topCenter,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (email) => EmailValidator.validate(email!)
                          ? null
                          : "Invalid email address",
                      onSaved: (email) => _email = email,
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                            context, _emailFocusNode, _passwordFocusNode);
                      },
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xfff1f1f1).withOpacity(0.2),
                        hintText: 'Email id',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    alignment: FractionalOffset.topCenter,
                    child: TextFormField(
                      obscureText: true,
                      focusNode: _passwordFocusNode,
                      validator: (password) {
                        Pattern pattern =
                            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                        RegExp regex = new RegExp(pattern as String);
                        if (!regex.hasMatch(password!))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      onSaved: (password) => _password = password,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xfff1f1f1).withOpacity(0.2),
                        hintText: 'Password',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        contentPadding: EdgeInsets.only(left: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, right: 15.0),
                      alignment: FractionalOffset.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat'),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      alignment: FractionalOffset.center,
                      // width: 500,
                      // height: 50,
                      // color: Colors.pink,

                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * .90,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: Color(AppConstant.pinkcolor),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Demo())
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            AppConstant.CheckNetwork().whenComplete(
                                () => CallApiForLogin(_email, _password));
                          }
                        },
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            alignment: FractionalOffset.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat'),
                                  ),
                                  new Text(
                                    ' Sign up',
                                    style: TextStyle(
                                        color: Color(AppConstant.pinkcolor),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat'),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    initPlatformState();

    WidgetsFlutterBinding.ensureInitialized();

    if (mounted) {
      setState(() {
        PreferenceUtils.init();
      });
    }
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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

  // @override
  // void dispose() {
  //   // Clean up the focus node when the Form is disposed.
  //   myFocusNode.dispose();
  //
  //   super.dispose();
  // }
  /*Login Api Call*/

  // ignore: non_constant_identifier_names
  CallApiForLogin(String? email, String? password) async {
    String fcmtoken = PreferenceUtils.getString(AppConstant.fcmtoken);

    print("login_fcmtoken123:$fcmtoken");
    print("login_email:$email");
    print("login_password:$password");

    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data())
        .login(email, password, fcmtoken)
        .then((response) {
      setState(() {
        _loading = false;
      });
      print(response.toString());
      final body = json.decode(response!);

      bool? sucess = body['success'];
      print(sucess);
      if (sucess == true) {
        var token = body['data']['token'];

        PreferenceUtils.setString(AppConstant.headertoken, token);

        print(token);

        PreferenceUtils.setlogin(AppConstant.isLoggedIn, true);
        bool? login123 = PreferenceUtils.getlogin(AppConstant.isLoggedIn);
        print("login123:$login123");
        toastMessage("login successfully");

        print("WidgetIndex:${widget.index}");

        PreferenceUtils.setString(AppConstant.userimage, body['data']['image']);
        PreferenceUtils.setString(AppConstant.username, body['data']['name']);
        PreferenceUtils.setString(
            AppConstant.imagePath, body['data']['imagePath']);

        if (widget.index == 6) {
          Navigator.pop(context);
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(4)));

        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeScreen(widget.index)));
        }
      } else if (sucess == false) {
        var msg = body['msg'];
        print(msg);

        if (msg == "Verify your account") {
          toastMessage("Verify your account");

          var userid = body['data'].toString();
          print("loginuserid:$userid");
          PreferenceUtils.setString(AppConstant.userid, userid);
          PreferenceUtils.setString(AppConstant.useremail, email!);
          PreferenceUtils.setlogin(AppConstant.isLoggedIn, true);
          toastMessage("login successfully");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtpScreen()),
          );
        }
      }
      // });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj.");
      print(obj.runtimeType);

      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response!;
          print(res);

          var responsecode = res.statusCode;
          // print(responsecode);

          if (responsecode == 401) {
            toastMessage("Invalid email or password");

            print("Got error : ${res.statusCode} -> ${res.statusMessage}");
            print("Invalid email or password");
          } else if (responsecode == 422) {
            print("Invalid Data");
          }

          break;
        default:
      }
    });
  }

  void CallApiForgetProfile() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).profile().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            PreferenceUtils.setString(
                AppConstant.username, response.data!.name!);
            print(
                "profileNameLogin:${PreferenceUtils.getString(AppConstant.username)}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(1)),
            );
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
      AppConstant.toastMessage("Internal Server Error");
    });
  }

  Future<void> initPlatformState() async {
    // OneSignal.shared.consentGranted(true);
    // await OneSignal.shared.setAppId(appId);
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared.promptLocationPermission();
    var status = await OneSignal.shared.getDeviceState();

    // var status = await OneSignal.shared.getPermissionSubscriptionState();
    var pushtoken = await status!.userId!;
    // print("pushtoken123456:$pushtoken");
    PreferenceUtils.setString(AppConstant.fcmtoken, pushtoken);
  }
}
