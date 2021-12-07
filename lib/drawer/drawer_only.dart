import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/drawerscreen/about.dart';
import 'package:barber_app/drawerscreen/privacypolicy.dart';
import 'package:barber_app/drawerscreen/tems_condition.dart';
import 'package:barber_app/drawerscreen/top_offers.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';


class DrawerOnly extends StatelessWidget {


  String? name;
  DrawerOnly(this.name);

  bool logoutvisible = false;



  @override
  Widget build (BuildContext ctxt) {
    PreferenceUtils.init();
    print("drawername:$name");


    if(name == null && name == ""){
      name = "User";
    }

    if(PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true){

      logoutvisible = true;


    }else{
      logoutvisible = false;
    }
    return new Drawer(


        //   enableOpenDragGesture: true,
        // dragStartBehavior:,



/*        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: new Text("DRAWER HEADER.."),
              decoration: new BoxDecoration(
                  color: Colors.orange
              ),
            ),
            new ListTile(
              title: new Text("Item => 1"),
              onTap: () {
                Navigator.pop(ctxt);
                Navigator.push(ctxt,
                    new MaterialPageRoute(builder: (ctxt) => new FirstFragment()));
              },
            ),
            new ListTile(
              title: new Text("Item => 2"),
              onTap: () {
                Navigator.pop(ctxt);
                Navigator.push(ctxt,
                    new MaterialPageRoute(builder: (ctxt) => new FirstFragment()));
              },
            ),
          ],
        )*/

        child: ListView(


          children: <Widget>[

            Container(
              padding: EdgeInsets.only(left: 0.0, top: 10.0),
              color: Colors.white,
              alignment: Alignment.center,
              height: 80,
              width: double.infinity,
              child: Text(
                'Hii, '+ name!,
                style: TextStyle(
                    color: Colors.black,

                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat'),
              ),
            ),
            Container(

                height: 0,
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                )
            ),
            Container(

                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.0, top: 10.0),

                child: ListTile(



                  title: Text(

                    'Top Offers',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat'),



                  ),
                  onTap: () {

                    Navigator.of(ctxt).push(MaterialPageRoute(builder: (context) => new TopOffers(-1,null,null,null,null,null,null,null,null,null)));
                  },

                )




            ),
   /*         Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.0, top: 0.0),

                child: ListTile(
                  title: Text(
                    'Top Services',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat'),
                  ),
                  onTap: () {

                    Navigator.of(ctxt).push(MaterialPageRoute(builder: (context) => new TopService(0,"Explore All")));
                  },

                )
            ),*/

            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.0, top: 0.0),

                child: ListTile(
                    title: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                    ),
                  onTap: () {
                    Navigator.of(ctxt).push(MaterialPageRoute(builder: (context) => new TermsCondition()));
                  },
                )
            ),

            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.0, top: 0.0),

                child: ListTile(
                    title: Text(
                      'Privacy & Policy',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),),
                      onTap: () {

                        Navigator.of(ctxt).push(MaterialPageRoute(builder: (context) => new PrivacyPolicy()));
                      },

                )
            ),

            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.0, top: 0.0),

                child: ListTile(
                    title: Text(
                      'Invite a friends',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                    ),

                  onTap: () {
                      Navigator.pop(ctxt);
                      Share.share(
                            'the barber app link');

                  },
                )
            ),

            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.0, top: 0.0),

                child: ListTile(
                    title: Text(
                      'About',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                    ),

                  onTap: () {

                    Navigator.of(ctxt).push(MaterialPageRoute(builder: (context) => new About()));
                  },

                )
            ),

           Visibility (
             visible: logoutvisible,
              child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20.0, top: 0.0),

                  child: ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                    ),

                    onTap: ()  async {

                      PreferenceUtils.clear();
                      PreferenceUtils.setlogin(AppConstant.isLoggedIn, false);

                      Navigator.of(ctxt).push(MaterialPageRoute(builder: (context) => new LoginScreen(6)));

                      // Navigator.push(ctxt,
                      //     new MaterialPageRoute(builder: (ctxt) => new LoginScreen(6)));



                      // Navigator.of(context).pop();
                    },

                  )
              ),
            ),

          ],
          // Drawer content here
          // design your own drawer menu here.
        )
    );
  }
}