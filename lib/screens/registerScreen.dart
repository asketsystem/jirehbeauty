import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:progress_dialog/progress_dialog.dart';
import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'loginscreen.dart';
import 'otpscreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => new _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  String? _selectedCountryCode = ' +91';
  List<String> _countryCodes = [' +91', ' +23', ' +8'];
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();

  String? _username, _email, _password, _phoneno = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var countryDropDown = Container(
      decoration: new BoxDecoration(
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      height: 45.0,
      //width: 300.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: _selectedCountryCode,
            items: _countryCodes.map((String value) {
              return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(
                    value,
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat'),
                  ));
            }).toList(),
            onChanged: (dynamic value) {
              setState(() {
                _selectedCountryCode = value;
              });
            },
          ),
        ),
      ),
    );

/*    var countryDropDown = Container(
      decoration: new BoxDecoration(
        color: const Color(0xFFf1f1f1),
        border: Border(
          right: BorderSide(width: 0.5, color: const Color(0xFFf1f1f1)),
        ),
      ),
      // height: 45.0,

     // margin: const EdgeInsets.all(3.0),
      //width: 300.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: false,
          child: DropdownButton(

            // iconSize: 0.0,

            value: _selectedCountryCode,
            items: _countryCodes.map((String value) {

              return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(


                    value,
                    style: TextStyle(fontSize: 12.0),
                  ));
            }).toList(),
            onChanged: (value) {
              setState(() {

                _selectedCountryCode = value;
              });
            },
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    );*/

    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator:
          SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
      child: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: Scaffold(
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
                  "Create New Account",
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
                child: new Stack(
                  children: <Widget>[
                    new SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 50.0, left: 35.0),
                                  alignment: FractionalOffset.topLeft,
                                  child: Text(
                                    "Name",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: const Color(0xFF999999),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                alignment: FractionalOffset.topLeft,
                                margin: const EdgeInsets.only(
                                    top: 5.0,
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 15),
                                child: TextFormField(
                                  autofocus: true,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  validator: (name) {
                                    Pattern pattern =
                                        r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                    RegExp regex =
                                        new RegExp(pattern as String);
                                    if (!regex.hasMatch(name!))
                                      return 'Invalid username';
                                    else
                                      return null;
                                  },
                                  onSaved: (name) => _username = name,
                                  onFieldSubmitted: (_) {
                                    fieldFocusChange(context,
                                        _usernameFocusNode, _emailFocusNode);
                                  },
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat'),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFf1f1f1),
                                    hintText: 'Enter your full name',
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFf1f1f1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFf1f1f1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 5.0, left: 35.0),
                                alignment: FractionalOffset.topLeft,
                                child: Text(
                                  "Email id",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: const Color(0xFF999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              Container(
                                height: 45,
                                alignment: FractionalOffset.topLeft,
                                margin: const EdgeInsets.only(
                                    top: 5.0,
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 15),
                                child: TextFormField(
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _emailFocusNode,
                                  validator: (email) =>
                                      EmailValidator.validate(email!)
                                          ? null
                                          : "Invalid email address",
                                  onSaved: (email) => _email = email,
                                  onFieldSubmitted: (_) {
                                    fieldFocusChange(context, _emailFocusNode,
                                        _phoneFocusNode);
                                  },
                                  style: TextStyle(
                                      fontSize: 16.0,
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
                                      borderSide: BorderSide(
                                          color: const Color(0xFFf1f1f1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFf1f1f1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 5.0, left: 35.0),
                                alignment: FractionalOffset.centerLeft,
                                child: Text(
                                  "Phone Number",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: const Color(0xFF999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              Container(
                                  alignment: FractionalOffset.centerLeft,
                                  height: 45,
                                  margin: const EdgeInsets.only(
                                      top: 5.0,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 15),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      focusNode: _phoneFocusNode,
                                      textAlign: TextAlign.left,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      validator: (phone) {
                                        Pattern pattern =
                                            r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                        RegExp regex =
                                            new RegExp(pattern as String);
                                        if (!regex.hasMatch(phone!))
                                          return 'Invalid Phone number';
                                        else
                                          return null;
                                      },
                                      onSaved: (phone) => _phoneno = phone,
                                      onFieldSubmitted: (_) {
                                        fieldFocusChange(
                                            context,
                                            _phoneFocusNode,
                                            _passwordFocusNode);
                                      },
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat'),
                                      decoration: InputDecoration(
                                        prefixIcon: countryDropDown,
                                        filled: true,
                                        fillColor: const Color(0xFFf1f1f1),
                                        hintText: '  Phone Number ',
                                        contentPadding: EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xFFf1f1f1)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xFFf1f1f1)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  )),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 5.0, left: 35.0),
                                alignment: FractionalOffset.centerLeft,
                                child: Text(
                                  "Password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: const Color(0xFF999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              Container(
                                alignment: FractionalOffset.centerLeft,
                                height: 45,
                                margin: const EdgeInsets.only(
                                    top: 5.0,
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 15),
                                child: TextFormField(
                                  obscureText: true,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _passwordFocusNode,
                                  validator: (password) {
                                    Pattern pattern =
                                        r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                    RegExp regex =
                                        new RegExp(pattern as String);
                                    if (!regex.hasMatch(password!))
                                      return 'Invalid password';
                                    else
                                      return null;
                                  },
                                  onSaved: (password) => _password = password,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat'),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFf1f1f1),
                                    hintText: 'Enter your Password',
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFf1f1f1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFf1f1f1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: MaterialButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0)),
                                  height: 45,
                                  color: Color(AppConstant.pinkcolor),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      /*    Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => HomeScreen(2)),
                                          );*/

                                      var connectivityResult =
                                          await (Connectivity()
                                              .checkConnectivity());
                                      if (connectivityResult ==
                                          ConnectivityResult.mobile) {

                                        CallRegisterapi(
                                            _username,
                                            _email,
                                            _phoneno,
                                            _password,
                                            0,
                                            _selectedCountryCode);
                                      } else if (connectivityResult ==
                                          ConnectivityResult.wifi) {

                                        CallRegisterapi(
                                            _username,
                                            _email,
                                            _phoneno,
                                            _password,
                                            0,
                                            _selectedCountryCode);
                                      } else {
                                        toastMessage("No Internet Connection");
                                      }

                                      // toastMessage("Email: $_email\nPassword: $_password");

                                    }
                                  },
                                  child: Text(
                                    "Create New Account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                              /* Container(

                                  margin: const EdgeInsets.only(top: 20.0),
                                  alignment: FractionalOffset.center,
                                  // width: 500,
                                  // height: 50,
                                  // color: Colors.pink,

                                  child: MaterialButton(
                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                    height: 40,
                                    color: Color(AppConstant.pinkcolor),

                                    onPressed: () async {
                                      if(_formKey.currentState.validate()){
                                        _formKey.currentState.save();

                                    */ /*    Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => HomeScreen(2)),
                                        );*/ /*



                                        var connectivityResult = await (Connectivity().checkConnectivity());
                                        if (connectivityResult == ConnectivityResult.mobile) {
                                          pr.show();
                                          CallRegisterapi(_username,_email,_phoneno,_password,0,_selectedCountryCode);

                                        } else if (connectivityResult == ConnectivityResult.wifi) {
                                          pr.show();
                                          CallRegisterapi(_username,_email,_phoneno,_password,0,_selectedCountryCode);

                                        }else{
                                          toastMessage("No Internet Connection");
                                        }






                                        // toastMessage("Email: $_email\nPassword: $_password");



                                      }


                                    },
                                    child: Text(
                                      "Create New Account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  )
                              ),*/

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        alignment:
                                            FractionalOffset.bottomCenter,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen(2)),
                                            );
                                          },
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Text(
                                                'Already have an account !',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Montserrat'),
                                              ),
                                              new Text(
                                                ' Login.',
                                                style: TextStyle(
                                                    color: Color(
                                                        AppConstant.pinkcolor),
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
                              new Container(
                                child: SizedBox(
                                  height: 100,
                                ),
                              ),
                              new Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "By clicking Create new account you agree to the following Terms & Condition.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
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
        fontSize: 16.0);
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    setState(() {
      PreferenceUtils.init();
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
  }

  void CallRegisterapi(String? username, String? email, String? phoneno,
      String? password, int verify, String? selectedCountryCode) {
    print("name:$username" +
        "email:$email" +
        "phoneno:$phoneno" +
        "password:$password" +
        "verify:$verify" +
        "selectedcode:$selectedCountryCode");
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data())
        .register(
            username, email, phoneno, password, verify, selectedCountryCode)
        .then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success = true) {
          print("sucess");
          toastMessage(response.message!);

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
            MaterialPageRoute(builder: (context) => OtpScreen()),
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
            toastMessage("The email has already been taken.");
            print("code:$responsecode");
            print("msg:$msg");
          }
          break;
        default:
      }
    });
  }
}
