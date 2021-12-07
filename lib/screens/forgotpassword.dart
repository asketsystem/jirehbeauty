import 'dart:async';
import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:progress_dialog/progress_dialog.dart';

import 'otpscreen.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() => new _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    // AppConstant.CheckNetwork().whenComplete(() => pr.show());
    // AppConstant.onLoading(context);
    // AppConstant.CheckNetwork().whenComplete(() => CallApiforEmpData());
    // AppConstant.CheckNetwork().whenComplete(() =>   CallApiforBookService());
  }

  final _formKey = GlobalKey<FormState>();

  FocusNode _emailFocusNode = FocusNode();
  String? _username, _email, _password = "";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "Forgot Password",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Form(
              key: _formKey,
              child: Container(
                  child: Column(children: <Widget>[
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        child: Container(
                          margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                          alignment: FractionalOffset.center,
                          child: Image.asset(
                            "images/forgotpassword.png",
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 70.0, left: 0.0),
                          alignment: FractionalOffset.center,
                          child: Text(
                            'Forgot Password !',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat'),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 2.0, left: 0.0),
                          alignment: FractionalOffset.center,
                          child: Text(
                            'Don\'t worry, we will find your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Montserrat'),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 40, right: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Email Id",
                                style: TextStyle(
                                    color: const Color(0xFF999999),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              focusNode: _emailFocusNode,
                              validator: (email) =>
                                  EmailValidator.validate(email!)
                                      ? null
                                      : "Invalid email address",
                              onSaved: (email) => _email = email,
                              onFieldSubmitted: (_) {},
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat'),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFf1f1f1),
                                hintText: 'Enter your email id',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: const Color(0xFFf1f1f1)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: const Color(0xFFf1f1f1)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              minWidth: 300,
                              height: 40,
                              color: Color(AppConstant.pinkcolor),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  AppConstant.CheckNetwork().whenComplete(
                                      () => callApiForForgotpassword(_email));



                                }
                              },
                              child: Text(
                                "Send me OTP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 2, top: 10),
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    "Please check your email.",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    "we will send you password on your mail.",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Montserrat'),
                  ),
                )
              ])))),
    );
  }

  void callApiForForgotpassword(String? email) {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).forgetpassword(email).then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success = true) {
          print("sucess");
          toastMessage(response.msg!);

          PreferenceUtils.setString(
              AppConstant.userid, response.data!.id.toString());
          PreferenceUtils.setString(AppConstant.username, response.data!.name!);
          PreferenceUtils.setString(
              AppConstant.useremail, response.data!.email!);
          PreferenceUtils.setString(
              AppConstant.userotp, response.data!.otp.toString());
          PreferenceUtils.setString(
              AppConstant.userphone, response.data!.phone!);
          PreferenceUtils.setString(
              AppConstant.userphonecode, response.data!.code!);
          PreferenceUtils.setString(
              AppConstant.imagePath, response.data!.imagePath!);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen(2)),
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

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
