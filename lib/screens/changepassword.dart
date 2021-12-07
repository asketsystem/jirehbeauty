import 'package:barber_app/constant/appconstant.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'changepassworddone.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => new _ChangePassword();
}

String? _username, _email, _password = "";
final _formKey = GlobalKey<FormState>();

FocusNode _newpassword = FocusNode();
FocusNode _confirmpassword = FocusNode();

class _ChangePassword extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
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
            "Change Password",
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
          child: Stack(
            children: <Widget>[
              ListView(
                children: [
                  Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                      alignment: FractionalOffset.center,
                      child: Image.asset(
                        "images/changepassword.png",
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
                        'Set New Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 5.0, left: 0.0),
                      alignment: FractionalOffset.center,
                      child: Text(
                        'set new password and forgot old one.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat'),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0, left: 40.0),
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      "New Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.topLeft,
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      obscureText: true,
                      autofocus: false,
                      validator: (password) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern as String);
                        if (!regex.hasMatch(password!))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                            context, _newpassword, _confirmpassword);
                      },
                      onSaved: (password) => _password = password,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFf1f1f1),
                        hintText: 'New Password',
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
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, left: 40.0),
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      "Confirm Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.topLeft,
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      obscureText: true,
                      focusNode: _confirmpassword,
                      validator: (password) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern as String);
                        if (!regex.hasMatch(password!))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFf1f1f1),
                        hintText: 'Confirm Password',
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
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      alignment: FractionalOffset.center,
                      // width: 500,
                      // height: 50,
                      // color: Colors.pink,

                      child: MaterialButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        minWidth: 300,
                        height: 40,
                        color: Color(AppConstant.pinkcolor),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            toastMessage(
                                "Email: $_email\nPassword: $_password");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePasswordDone()),
                            );
                          }
                        },
                        child: Text(
                          "Change Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
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
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
