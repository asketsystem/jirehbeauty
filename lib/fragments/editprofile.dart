import 'dart:convert';
import 'dart:io';

import 'package:barber_app/ResponseModel/showprofileResponse.dart';
import 'package:barber_app/apiservice/Apiservice.dart';
import 'package:barber_app/apiservice/Retro_Api.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfile extends StatefulWidget {
  ShowProfile? showProfile;

  EditProfile(this.showProfile);

  @override
  _EditProfile createState() => new _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  List<Address>? addressdataList = <Address>[];
  ShowProfile? showProfile1;
  String? _selectedCountryCode;
  bool _loading = false;
  // List<String> _countryCodes = [' +91', ' +23',' +8'];

  // ProgressDialog pr;

  @override
  void initState() {
    super.initState();

    setState(() {
      PreferenceUtils.init();

      showProfile1 = widget.showProfile;
      addressdataList = widget.showProfile!.address;

      // int addlength = addressdataList.length;
      // print("addlength:$addlength");
    });
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void CallApiForRemoveLocation(int index) {
    setState(() {
      int? addressid = addressdataList![index].addressId;
      print("Addid:$addressid");

      AppConstant.CheckNetwork().whenComplete(
          () => CallAddRessRemoveApi(addressdataList![index].addressId));
      addressdataList!.removeAt(index);
    });
  }

  void CallAddRessRemoveApi(int? addressId) {
    setState(() {
      _loading = true;
    });
    print(addressId);
    RestClient(Retro_Api().Dio_Data()).removeadd(addressId).then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          AppConstant.toastMessage(response.msg!);
        } else {}
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

  void callApiForEditProfile(String imageB64) {
    print("imageB64:$imageB64");
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data())
        .editprofile(
            imageB64, _email, _phoneno, _username, _selectedCountryCode)
        .then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          print(response.msg);

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => new HomeScreen(3)));
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

  List<String> _countryCodes = ["+91", "+23", "+8"];

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _oldpasswordFocusNode = FocusNode();
  FocusNode _newpasswordFocusNode = FocusNode();
  FocusNode _confirmpasswordFocusNode = FocusNode();

  String? _username, _email, _password, _phoneno = "";
  String? oldpassword, newpassword, confirmpassword = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List appoinmentdatalist = [
    {
      "discount": "10%",
      "dark_color": const Color(0xFFffb5cc),
      "light_color": const Color(0xFFffc8de),
    },
    // {"discount": "50%", "dark_color": const Color(0xFFb5b8ff), "light_color": const Color(0xFFc8caff)},
    // {"discount": "30%", "dark_color": const Color(0xFFffb5b5), "light_color": const Color(0xFFffc8c8)},
  ];

  List appoinmentdatalist1 = [
    {
      "discount": "10%",
      "dark_color": const Color(0xFFffb5cc),
      "light_color": const Color(0xFFffc8de),
    },
    {
      "discount": "50%",
      "dark_color": const Color(0xFFb5b8ff),
      "light_color": const Color(0xFFc8caff)
    },
    {
      "discount": "30%",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },
  ];
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    _selectedCountryCode = showProfile1!.code;
    print("_selectedCountryCode123:$_selectedCountryCode");

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

    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator:
          SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,

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
              "Edit Profile",
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
              /* IconButton(
                  icon: Icon(
                    Icons.search,

                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => new SearchResult()));
                    },
                ),
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => new HomeScreen(0)));




                    // do something
                  },
                ),*/
            ],
          ),

          key: _drawerscaffoldkey,

          //set gobal key defined above

          // drawer: new DrawerOnly(),

          body: Form(
            key: _formKey,
            child: new ListView(physics: ClampingScrollPhysics(), // add this

                children: <Widget>[
                  // new SingleChildScrollView(
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        // child:
                        // Padding(
                        //   padding: EdgeInsets.all(10),
                        //      child: SingleChildScrollView(
                        //        physics: AlwaysScrollableScrollPhysics(),
                        // child:
                        // ListView(
                        //
                        //       shrinkWrap: true,
                        //       // physics: NeverScrollableScrollPhysics(),
                        //       children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFFf1f1f1), width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        selectimage(context);
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Container(
                                                height: 90,
                                                width: 90,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    selectimage(context);
                                                    // final pickedFile =
                                                    // await picker.getImage(
                                                    //     source:
                                                    //     ImageSource.gallery);
                                                    //
                                                    // setState(() {
                                                    //   if (pickedFile != null) {
                                                    //     _image = File(pickedFile.path);
                                                    //   } else {
                                                    //     print('No image selected.');
                                                    //   }
                                                    // });
                                                  },
                                                  child: _image == null
                                                      ? CachedNetworkImage(
                                                          imageUrl: showProfile1!
                                                                  .imagePath! +
                                                              showProfile1!
                                                                  .image!,
                                                          // imageUrl:_image,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              ClipOval(
                                                            child: Image(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              SpinKitFadingCircle(
                                                                  color: Color(
                                                                      AppConstant
                                                                          .pinkcolor)),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                                  "images/no_image.png"),
                                                        )
                                                      : ClipOval(
                                                    child: Image.file(
                                                      _image!,
                                                      // width: ScreenUtil().setWidth(100),
                                                      // height: ScreenUtil().setHeight(100),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 50,
                                                  top: 35,
                                                  bottom: 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  selectimage(context);
                                                  // final pickedFile =
                                                  //     await picker.getImage(
                                                  //     source:
                                                  //     ImageSource.camera);

                                                  // setState(() {
                                                  //   if (pickedFile != null) {
                                                  //     _image = File(pickedFile.path);
                                                  //     print("imagefile:$_image");
                                                  //   } else {
                                                  //     print('No image selected.');
                                                  //   }
                                                  // });
                                                },
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  child: SvgPicture.asset(
                                                      "images/camera.svg"),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                // width: 150,
                                child: Center(
                                  child: Text(
                                    showProfile1!.name!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 11, top: 25),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Personal Info',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Edit your name',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                          child: TextFormField(
                            autofocus: false,
                            initialValue: showProfile1!.name,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,

                            validator: (name) {
                              Pattern pattern =
                                  r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                              RegExp regex = new RegExp(pattern as String);
                              if (!regex.hasMatch(name!))
                                return 'Invalid name';
                              else
                                return null;
                            },

                            onSaved: (name) => _username = name,
                            onFieldSubmitted: (_) {
                              fieldFocusChange(
                                  context, _usernameFocusNode, _emailFocusNode);
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
                              hintText: 'Enter your Name',
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
                          margin: EdgeInsets.only(left: 20, top: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Edit your EmailId',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                          child: TextFormField(
                            autofocus: false,
                            initialValue: showProfile1!.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,

                            focusNode: _emailFocusNode,
                            validator: (email) =>
                                EmailValidator.validate(email!)
                                    ? null
                                    : "Invalid email address",
                            onSaved: (email) => _email = email,
                            onFieldSubmitted: (_) {
                              fieldFocusChange(
                                  context, _emailFocusNode, _phoneFocusNode);
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
                              hintText: 'Enter your EmailId',
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
                          margin: EdgeInsets.only(left: 20, top: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Edit your Contact Number',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                          child: TextFormField(
                            initialValue: showProfile1!.phone,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,

                            focusNode: _phoneFocusNode,

                            validator: (phone) {
                              Pattern pattern = r'^[0-9]*$';
                              RegExp regex = new RegExp(pattern as String);
                              if (!regex.hasMatch(phone!))
                                return 'Invalid Phone number';
                              else
                                return null;
                            },

                            onSaved: (phone) => _phoneno = phone,

                            // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              prefixIcon: countryDropDown,
                              filled: true,
                              fillColor: const Color(0xFFf1f1f1),
                              hintText: 'Enter your Contact Number',
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
                          margin: EdgeInsets.only(top: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: addressdataList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 60,
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 1, top: 00),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenwidth * .1,
                                      alignment: FractionalOffset.topCenter,
                                      margin: EdgeInsets.only(top: 10),
                                      child: SvgPicture.asset(
                                        "images/location_black.svg",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Container(
                                      //height: 35,
                                      alignment: FractionalOffset.topLeft,

                                      width: screenwidth * .5,
                                      transform: Matrix4.translationValues(
                                          0.0, 5.0, 0.0),

                                      child: ListView(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),

                                        children: [
                                          Text(
                                            addressdataList![index].street!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat'),
                                          ),
                                          Text(
                                            addressdataList![index].city! +
                                                ", " +
                                                addressdataList![index].state! +
                                                ", " +
                                                addressdataList![index]
                                                    .country!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showremovelocationdialog(
                                            context, index);
                                      },
                                      child: Container(
                                          width: screenwidth * .25,
                                          margin: EdgeInsets.only(right: 5),
                                          transform: Matrix4.translationValues(
                                              5.0, -10.0, 0.0),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: SvgPicture.asset(
                                                      "images/delete.svg",
                                                      color: const Color(
                                                          0xFFff4040),
                                                    ),
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, left: 5),
                                                    child: Text("Remove",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xFFff4040),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              );

                              /*  return new SavedLocationData(
                                  location: "aaa",
                                );*/
                            },
                          ),
                        ),

                        Container(
                          height: 45,
                          margin: EdgeInsets.only(top: 20, bottom: 10),
                          //height: 200,
                          color: Colors.white,

                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (_image == null) {
                                  String imageB64 = "";
                                  print("imageB64123:$imageB64");

                                  AppConstant.CheckNetwork().whenComplete(
                                      () => callApiForEditProfile(imageB64));
                                } else {
                                  List<int> imageBytes =
                                      _image!.readAsBytesSync();
                                  String imageB64 = base64Encode(imageBytes);

                                  AppConstant.CheckNetwork().whenComplete(
                                      () => callApiForEditProfile(imageB64));
                                }
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                'Change this',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF4a92ff),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),

/*              Container(

                    child: SizedBox(

                      width: screenwidth,
                      height: 10,
                    ),


                  )*/
                      ],
                    ),
                  ),

                  // )
                  // ),

                  //     ]
                  // )
                  // )
                ]),
          ),
        ),
      ),
    );
  }

  void showremovelocationdialog(BuildContext context, int index) {
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
              CallApiForRemoveLocation(index);
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
                'Remove Location !',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
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
                      "Are you sure you want to remove your location?  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void selectimage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text(
                      'Photo Library',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    'Camera',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                  onTap: () {
                    getImage();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(

          // child: CustomView(),

          ),
    );
  }
}
