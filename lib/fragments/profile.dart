import 'dart:async';
import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:barber_app/ResponseModel/appointmentResponse.dart';
import 'package:barber_app/ResponseModel/showprofileResponse.dart';
import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:barber_app/separator/separator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:barber_app/drawerscreen/top_offers.dart';
import 'package:barber_app/fragments/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => new _Profile();
}

class _Profile extends State<Profile> {
  ShowProfile? showProfile = new ShowProfile();

  int index = 0;
  var day;
  var salontime;

  String? profilename = "";
  String name = "User";
  String? imageurl;

  List<Completed> completeddataList = <Completed>[];
  List<Cancel> canceldataList = <Cancel>[];
  List<UpcomingOrder> upcomingorderdataList = <UpcomingOrder>[];
  List<Services> servicelist = <Services>[];
  bool noupdatavisible = false;
  bool uplistvisible = false;
  bool allvisible = true;

  // bool nocanceldatavisible = false;
  // bool cancellistvisible = false;
  //
  bool nocompletedatavisible = false;
  bool completelistvisible = false;
  bool _loading = false;

  List<String?> upcomingServiceList = <String?>[];
  List<String> cancelServiceList = <String>[];
  List<String> completedServiceList = <String>[];

  FocusNode _oldpasswordFocusNode = FocusNode();
  FocusNode _newpasswordFocusNode = FocusNode();
  FocusNode _confirmpasswordFocusNode = FocusNode();

  String? oldpassword, newpassword, confirmpassword = "";

  TextEditingController _textEditctrlOldPassword = new TextEditingController();
  TextEditingController _textEditctrlnewPassword = new TextEditingController();
  TextEditingController _textEditctrlconfPassword = new TextEditingController();

  String? kvalidatePassword(String? value) {
    Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern as String);
    if (value!.length == 0) {
      return 'Password is Required';
    } else if (!regex.hasMatch(value))
      return 'Password required: Alphabet, Number & 8 chars';
    else
      return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    PreferenceUtils.init();

    if (mounted) {
      setState(() {
        print(
            "loginstatus123654:${PreferenceUtils.getlogin(AppConstant.isLoggedIn)}");

        if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
          AppConstant.CheckNetwork().whenComplete(() => CallApiForGetProfile());
          AppConstant.CheckNetwork()
              .whenComplete(() => CallApiforAppointment());
        } else {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));

          // print("nullstatus:${PreferenceUtils.getlogin(
          //     AppConstant.isLoggedIn)}");

          Future.delayed(
            Duration(seconds: 0),
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginScreen(3))),
          );
        }
      });
    }
  }

  void CallApiForGetProfile() {
    var apptoken = PreferenceUtils.getString(AppConstant.headertoken);

    print("AppToken:$apptoken");

    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).profile().then((response) {
      // AppConstant.hideDialog(context);
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            showProfile = response.data;

            PreferenceUtils.setString(
                AppConstant.username, response.data!.name!);

            profilename = showProfile!.name;
            imageurl = showProfile!.imagePath! + showProfile!.image!;
            print("profileimage:$imageurl");
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
      AppConstant.toastMessage("Internal Server Error__123");
    });
  }

  void CallApiforAppointment() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).appointment().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;

          if (response.success = true) {
            upcomingorderdataList.clear();
            canceldataList.clear();
            completeddataList.clear();

            print(response.data!.upcomingOrder!.length);
            print(response.data!.completed!.length);

            if (response.data!.upcomingOrder!.length == 0 &&
                response.data!.completed!.length == 0) {
              allvisible = true;
              uplistvisible = false;
              noupdatavisible = false;
              nocompletedatavisible = false;
              completelistvisible = false;
            }

            if (response.data!.upcomingOrder!.isNotEmpty) {
              upcomingorderdataList.addAll(response.data!.upcomingOrder!);

              // servicelist.addAll(upcomingorderdataList[currentindex].services);

              uplistvisible = true;
              noupdatavisible = false;
              allvisible = false;
            } else {
              uplistvisible = false;
              noupdatavisible = true;
            }

            if (response.data!.completed!.isNotEmpty) {
              completeddataList.addAll(response.data!.completed!);
              completelistvisible = true;
              nocompletedatavisible = false;
              allvisible = false;
            } else {
              completelistvisible = false;
              nocompletedatavisible = true;
            }
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
      AppConstant.toastMessage("Internal Server Error_ _456");
      // pr.hide();
    });
  }

  void CallApiforCancelBooking(int id) {
    int id1 = id.toInt();

    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).removeappointment(id).then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          AppConstant.toastMessage(response.msg!);

          AppConstant.CheckNetwork()
              .whenComplete(() => CallApiforAppointment());
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
      //AppConstant.toastMessage("Internal Server Error");
    });
  }

  void CallApiforchangePassword(
      String? oldpassword, String? newpassword, String? confirmpassword) {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data())
        .changepassword(oldpassword, newpassword, confirmpassword)
        .then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          AppConstant.toastMessage("Password Change Successfully");
        } else {
          AppConstant.toastMessage(response.msg!);
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      // {"message":"The given data was invalid.","errors":{"new_Password":["The new  password must be at least 8 characters."]}}
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
            AppConstant.toastMessage(
                "The new  password must be at least 8 characters.");
            print("code:$responsecode");
            print("msg:$msg");
          }
          break;
        default:
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  File? _image;
  final picker = ImagePicker();

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
            resizeToAvoidBottomInset: false,
            key: _drawerscaffoldkey,
            backgroundColor: Colors.white,
            appBar: appbar(context, 'Profile', _drawerscaffoldkey, false)
                as PreferredSizeWidget?,

            //set gobal key defined above

            drawer: new DrawerOnly(name),

            body: Form(
              key: _formKey,
              child: new Stack(children: <Widget>[
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFFf1f1f1), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: imageurl == null ? CachedNetworkImage(
                                    imageUrl:imageurl!,
                                    // imageUrl: imageurl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.fill,

                                    imageBuilder: (context, imageProvider) =>
                                        ClipOval(
                                      child: Image(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        SpinKitFadingCircle(
                                            color:
                                                Color(AppConstant.pinkcolor)),
                                    errorWidget: (context, url, error) =>
                                        Image.asset("images/no_image.png"),
                                  ) : Image.asset("images/no_image.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    profilename!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (ctxt) =>
                                            new EditProfile(showProfile)));
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset(
                                    "images/edit.svg",
                                    width: 30,
                                    height: 30,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Old Password',
                          style: TextStyle(
                              color: const Color(0xFF999999),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: true,

                          focusNode: _oldpasswordFocusNode,
                          // initialValue: showProfile1.name,
                          textInputAction: TextInputAction.next,
                          controller: _textEditctrlOldPassword,
                          validator: (name) {
                            Pattern pattern =
                                r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                            RegExp regex = new RegExp(pattern as String);
                            if (!regex.hasMatch(name!))
                              return 'Invalid Password';
                            else
                              return null;
                          },
                          onSaved: (name) => oldpassword = name,
                          onFieldSubmitted: (_) {
                            fieldFocusChange(context, _oldpasswordFocusNode,
                                _newpasswordFocusNode);
                          },
                          // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFf1f1f1),
                            hintText: 'Enter your old Password',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: const Color(0xFFf1f1f1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: const Color(0xFFf1f1f1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'New Password',
                          style: TextStyle(
                              color: const Color(0xFF999999),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: true,
                          focusNode: _newpasswordFocusNode,
                          // initialValue: showProfile1.name,
                          textInputAction: TextInputAction.next,
                          controller: _textEditctrlnewPassword,
                          validator: kvalidatePassword,

                          onSaved: (name) => newpassword = name,
                          onFieldSubmitted: (_) {
                            fieldFocusChange(context, _newpasswordFocusNode,
                                _confirmpasswordFocusNode);
                          },
                          // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFf1f1f1),
                            hintText: 'Enter your new Password',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: const Color(0xFFf1f1f1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: const Color(0xFFf1f1f1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                              color: const Color(0xFF999999),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: true,
                          controller: _textEditctrlconfPassword,
                          focusNode: _confirmpasswordFocusNode,
                          // initialValue: showProfile1.name,
                          textInputAction: TextInputAction.done,

                          validator: kvalidatePassword,

                          onSaved: (name) => confirmpassword = name,
                          // onFieldSubmitted: (_){
                          //   // fieldFocusChange(context, _newpasswordFocusNode, _confirmpasswordFocusNode);
                          // },
                          // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFf1f1f1),
                            hintText: 'Enter your confirm Password',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: const Color(0xFFf1f1f1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: const Color(0xFFf1f1f1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                      Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 20, right: 20),
                          alignment: FractionalOffset.center,
                          // width: 500,
                          // height: 50,
                          // color: Colors.pink,

                          child: MaterialButton(
                            minWidth: screenwidth,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 45,
                            color: Color(AppConstant.pinkcolor),

                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                print("pass_newpassword:$newpassword");
                                print("pass_confirmpassword:$confirmpassword");

                                if (newpassword == confirmpassword) {
                                  AppConstant.CheckNetwork().whenComplete(() =>
                                      CallApiforchangePassword(oldpassword,
                                          newpassword, confirmpassword));
                                } else {
                                  AppConstant.toastMessage(
                                      "Password not Match");
                                }
                              }
                            },
                            // },

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

                      Visibility(
                        visible: uplistvisible,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, top: 25),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Upcoming Appointments',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),

                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                print('item clicked');
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    // margin: EdgeInsets.only(top: 5.0,left: 10,right: 10),
                                    color: Colors.white,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        Visibility(
                                          visible: uplistvisible,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                upcomingorderdataList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var parsedDate;
                                              parsedDate = DateTime.parse(
                                                  upcomingorderdataList[index]
                                                      .date!);
                                              var df =
                                                  new DateFormat('MMM dd,yyyy');
                                              parsedDate =
                                                  df.format(parsedDate);

                                              upcomingServiceList.clear();
                                              for (int i = 0;
                                                  i <
                                                      upcomingorderdataList[
                                                              index]
                                                          .services!
                                                          .length;
                                                  i++) {
                                                upcomingServiceList.add(
                                                    upcomingorderdataList[index]
                                                        .services![i]
                                                        .name);
                                              }

                                              return Container(
                                                margin: EdgeInsets.only(
                                                    left: 5, right: 5, top: 10),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFf1f1f1),
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  new Container(
                                                                height: 75,
                                                                width:
                                                                    screenwidth *
                                                                        .35,
                                                                // color: Colors.black,
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),

                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: PreferenceUtils
                                                                      .getString(
                                                                          AppConstant
                                                                              .salonImage),
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            /*    Expanded(
                                                                child:  new Container(
                                                                  height: 75,
                                                                  width: screenwidth * .33,
                                                                  // color: Colors.black,
                                                                  alignment: Alignment.topLeft,
                                                                  margin: EdgeInsets.only(left: 10),

                                                                            child: CachedNetworkImage(
                                                                              imageUrl: upcomingorderdataList[index].salon.imagePath +upcomingorderdataList[index].salon.image,
                                                                              imageBuilder: (context,
                                                                                  imageProvider) =>
                                                                                  Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius:
                                                                                      BorderRadius.circular(10.0),
                                                                                      image: DecorationImage(
                                                                                        image: imageProvider,
                                                                                        fit: BoxFit.fill,
                                                                                        alignment: Alignment.topCenter,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                              placeholder: (context,url) => SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
                                                                              errorWidget: (context,url, error) => Icon(Icons.error),
                                                                            ),
                                                                          ),
                                                                        ),*/

                                                            new Container(
                                                                // height: 100.0,
                                                                width:
                                                                    screenwidth *
                                                                        .65,
                                                                height: 110,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5.0,
                                                                        top:
                                                                            0.0),
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                color: Colors
                                                                    .white,
                                                                child: ListView(
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 25.0),
                                                                      child:
                                                                          Text(
                                                                        PreferenceUtils.getString(
                                                                            AppConstant.singlesalonName),
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF1e1e1e),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily: 'Montserrat'),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          top:
                                                                              5.0,
                                                                          left:
                                                                              0.0),
                                                                      child:
                                                                          Text(
                                                                        PreferenceUtils.getString(
                                                                            AppConstant.salonAddress),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF9e9e9e),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily: 'Montserrat'),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: 2,
                                                                              left: 0),
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            "images/star.svg",
                                                                            width:
                                                                                10,
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 2, left: 2),
                                                                            child:
                                                                                Text(PreferenceUtils.getString(AppConstant.salonRating) + " Rating", style: TextStyle(color: const Color(0xFF999999), fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Montserrat')),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          width:
                                                                              5.0,
                                                                          height:
                                                                              5.0,
                                                                          margin: EdgeInsets.only(
                                                                              left: 5.0,
                                                                              top: 5.0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Color(0xFF9e9e9e),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            margin: EdgeInsets.only(
                                                                                left: 0.0,
                                                                                top: 5.0,
                                                                                right: 0),
                                                                            child: RichText(
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textScaleFactor: 1,
                                                                              textAlign: TextAlign.center,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  WidgetSpan(
                                                                                    child: Icon(
                                                                                      Icons.calendar_today,
                                                                                      size: 14,
                                                                                      color: Color(AppConstant.pinkcolor),
                                                                                    ),
                                                                                  ),
                                                                                  TextSpan(text: upcomingorderdataList[index].startTime! + " - " + parsedDate, style: TextStyle(color: Color(0xFF9e9e9e), fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Montserrat')),
                                                                                ],
                                                                              ),
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )),
                                                          ],
                                                        )),
                                                    Container(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 1.0,
                                                            bottom: 1.0),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0,
                                                                right: 10.0),
                                                        child: MySeparator(
                                                            color: Color(
                                                                0xFF9e9e9e)),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                                width:
                                                                    screenwidth *
                                                                        .33,
                                                                // height: 80,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5.0,
                                                                        right:
                                                                            10.0),
                                                                color: Colors
                                                                    .white,
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: ListView(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      transform: Matrix4.translationValues(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        "Service Type",
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFFb3b3b3),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily: 'Montserrat'),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: upcomingorderdataList[
                                                                              index]
                                                                          .serlistvisible,
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                5),
                                                                        child:
                                                                            Text(
                                                                          upcomingorderdataList[index]
                                                                              .services![0]
                                                                              .name!,
                                                                          style: TextStyle(
                                                                              color: Color(0xFF4b4b4b),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: 'Montserrat'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: upcomingorderdataList[
                                                                              index]
                                                                          .seeallvisible,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            upcomingorderdataList[index].seeallvisible =
                                                                                false;
                                                                            upcomingorderdataList[index].serlistvisible =
                                                                                false;
                                                                            upcomingorderdataList[index].newlistvisible =
                                                                                true;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          margin: EdgeInsets.only(
                                                                              left: 5,
                                                                              top: 5),
                                                                          child:
                                                                              Text(
                                                                            "see all...",
                                                                            style: TextStyle(
                                                                                color: Color(0xFF4a92ff),
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Montserrat'),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: upcomingorderdataList[
                                                                              index]
                                                                          .newlistvisible,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            print("sellallTap");
                                                                            upcomingorderdataList[index].seeallvisible =
                                                                                true;
                                                                            upcomingorderdataList[index].serlistvisible =
                                                                                true;
                                                                            upcomingorderdataList[index].newlistvisible =
                                                                                false;
                                                                          });
                                                                        },
                                                                        child:
                                                                            ListView(
                                                                          shrinkWrap:
                                                                              true,
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              margin: EdgeInsets.only(left: 5, top: 5),
                                                                              child: Text(
                                                                                upcomingServiceList.join(" , "),
                                                                                maxLines: 5,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: Color(0xFF4b4b4b), fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                            Container(
                                                              // height: 100.0,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              height: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 20,
                                                                      right:
                                                                          10),
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showcancledialog(
                                                                            context,
                                                                            upcomingorderdataList[index].id);
                                                                      },
                                                                      child:
                                                                          RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            WidgetSpan(
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(top: 5),
                                                                                child: SvgPicture.asset(
                                                                                  "images/delete.svg",
                                                                                  color: const Color(0xFFff4040),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            WidgetSpan(
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(top: 5, left: 5),
                                                                                child: Text("Cancel Booking", style: TextStyle(color: const Color(0xFFff4040), fontSize: 12, fontWeight: FontWeight.w500)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                            ),
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                                // ),
                                              );

                                              /*    return new AppointmentData(
                                                  discount: appoinmentdatalist[index]['discount'],
                                                  dark_color: appoinmentdatalist[index]['dark_color'],
                                                  light_color: appoinmentdatalist[index]['light_color'],
                                                );*/
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 15,
                                      top: 25,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Visibility(
                                      visible: completelistvisible,
                                      child: Text(
                                        "Appointment's History",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    color: Colors.white,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        Visibility(
                                          visible: completelistvisible,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                upcomingorderdataList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var parsedDate;
                                              parsedDate = DateTime.parse(
                                                  upcomingorderdataList[index]
                                                      .date!);
                                              var df =
                                                  new DateFormat('MMM dd,yyyy');
                                              parsedDate =
                                                  df.format(parsedDate);

                                              upcomingServiceList.clear();
                                              for (int i = 0;
                                                  i <
                                                      upcomingorderdataList[
                                                              index]
                                                          .services!
                                                          .length;
                                                  i++) {
                                                upcomingServiceList.add(
                                                    upcomingorderdataList[index]
                                                        .services![i]
                                                        .name);
                                              }

                                              return Container(
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 10),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFf1f1f1),
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  new Container(
                                                                height: 75,
                                                                width:
                                                                    screenwidth *
                                                                        .33,
                                                                // color: Colors.black,
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),

                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: PreferenceUtils
                                                                      .getString(
                                                                          AppConstant
                                                                              .salonImage),
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      SpinKitFadingCircle(
                                                                          color:
                                                                              Color(AppConstant.pinkcolor)),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Image.asset(
                                                                          "images/no_image.png"),
                                                                ),
                                                              ),
                                                            ),
                                                            new Container(
                                                                // height: 100.0,
                                                                width:
                                                                    screenwidth *
                                                                        .67,
                                                                height: 110,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5.0,
                                                                        top:
                                                                            0.0),
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                color: Colors
                                                                    .white,
                                                                child: ListView(
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 25.0),
                                                                      child:
                                                                          Text(
                                                                        PreferenceUtils.getString(
                                                                            AppConstant.singlesalonName),
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF1e1e1e),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily: 'Montserrat'),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          top:
                                                                              5.0,
                                                                          left:
                                                                              0.0),
                                                                      child:
                                                                          Text(
                                                                        PreferenceUtils.getString(
                                                                            AppConstant.salonAddress),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF9e9e9e),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily: 'Montserrat'),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: 2,
                                                                              left: 0),
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            "images/star.svg",
                                                                            width:
                                                                                10,
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 2, left: 2),
                                                                            child:
                                                                                Text(PreferenceUtils.getString(AppConstant.salonRating) + " Rating", style: TextStyle(color: const Color(0xFF999999), fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Montserrat')),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          width:
                                                                              5.0,
                                                                          height:
                                                                              5.0,
                                                                          margin: EdgeInsets.only(
                                                                              left: 5.0,
                                                                              top: 5.0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Color(0xFF9e9e9e),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            margin: EdgeInsets.only(
                                                                                left: 0.0,
                                                                                top: 5.0,
                                                                                right: 0),
                                                                            child: RichText(
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textScaleFactor: 1,
                                                                              textAlign: TextAlign.center,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  WidgetSpan(
                                                                                    child: Icon(
                                                                                      Icons.calendar_today,
                                                                                      size: 14,
                                                                                      color: Color(AppConstant.pinkcolor),
                                                                                    ),
                                                                                  ),
                                                                                  TextSpan(text: completeddataList[index].startTime! + " - " + parsedDate, style: TextStyle(color: Color(0xFF9e9e9e), fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Montserrat')),
                                                                                ],
                                                                              ),
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )),
                                                          ],
                                                        )),
                                                    Container(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 1.0,
                                                            bottom: 1.0),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0,
                                                                right: 10.0),
                                                        child: MySeparator(
                                                            color: Color(
                                                                0xFF9e9e9e)),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                                width:
                                                                    screenwidth *
                                                                        .33,
                                                                // height: 80,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5.0,
                                                                        right:
                                                                            10.0),
                                                                color: Colors
                                                                    .white,
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: ListView(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      transform: Matrix4.translationValues(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        "Service Type",
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFFb3b3b3),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily: 'Montserrat'),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: completeddataList[
                                                                              index]
                                                                          .serlistvisible,
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                5),
                                                                        child:
                                                                            Text(
                                                                          completeddataList[index]
                                                                              .services![0]
                                                                              .name!,
                                                                          style: TextStyle(
                                                                              color: Color(0xFF4b4b4b),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: 'Montserrat'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: completeddataList[
                                                                              index]
                                                                          .seeallvisible,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            completeddataList[index].seeallvisible =
                                                                                false;
                                                                            completeddataList[index].serlistvisible =
                                                                                false;
                                                                            completeddataList[index].newlistvisible =
                                                                                true;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          margin: EdgeInsets.only(
                                                                              left: 5,
                                                                              top: 5),
                                                                          child:
                                                                              Text(
                                                                            "see all...",
                                                                            style: TextStyle(
                                                                                color: Color(0xFF4a92ff),
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Montserrat'),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: completeddataList[
                                                                              index]
                                                                          .newlistvisible,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            print("sellallTap");
                                                                            completeddataList[index].seeallvisible =
                                                                                true;
                                                                            completeddataList[index].serlistvisible =
                                                                                true;
                                                                            completeddataList[index].newlistvisible =
                                                                                false;
                                                                          });
                                                                        },
                                                                        child:
                                                                            ListView(
                                                                          shrinkWrap:
                                                                              true,
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              margin: EdgeInsets.only(left: 5, top: 5),
                                                                              child: Text(
                                                                                completedServiceList.join(" , "),
                                                                                maxLines: 5,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: Color(0xFF4b4b4b), fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                            Container(
                                                              // height: 100.0,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              height: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 20,
                                                                      right:
                                                                          10),
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            WidgetSpan(
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(top: 5),
                                                                                child: SvgPicture.asset(
                                                                                  "images/correct.svg",
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            WidgetSpan(
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(top: 5, left: 5),
                                                                                child: Text("Completed", style: TextStyle(color: const Color(0xFF00d579), fontSize: 12, fontWeight: FontWeight.w500)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                            ),
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                                // ),
                                              );

                                              /* return new DoneAppointmentData(
                                                  discount: appoinmentdatalist1[index]['discount'],
                                                  dark_color: appoinmentdatalist1[index]['dark_color'],
                                                  light_color: appoinmentdatalist1[index]['light_color'],
                                                );*/
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 15,
                              top: 0,
                            ),
                            alignment: Alignment.topLeft,
                            child: Visibility(
                              visible: allvisible,
                              child: Text(
                                "Appointment's History",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                          Container(
                            child: Visibility(
                              visible: allvisible,
                              child: Center(
                                child: Container(
                                    width: screenwidth,
                                    height: screenHeight * 0.50,
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
                                            "You haven't any appointment set",
                                            style: TextStyle(
                                                color: Color(0xFFa3a3a3),
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen(1)));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Go to Home",
                                                style: TextStyle(
                                                    color: Color(0xFF4a92ff),
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //
                      // )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void showcancledialog(BuildContext context, int? id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Widget cancelButton = TextButton(
            child: Text(
              "No",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              "Yes",
              style: TextStyle(
                  color: Color(AppConstant.pinkcolor),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              print("BookingId:$id");

              AppConstant.CheckNetwork()
                  .whenComplete(() => CallApiforCancelBooking(id!));
              Navigator.pop(context);
            },
          );

          return AlertDialog(
            actions: [
              cancelButton,
              continueButton,
            ],
            title: Align(
              alignment: Alignment.center,
              child: Text(
                'Cancel Appointment !',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat'),
                textAlign: TextAlign.center,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Are you sure you want to cancel your appointment?  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);

    return (await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => new HomeScreen(0)))) ??
        false;
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
