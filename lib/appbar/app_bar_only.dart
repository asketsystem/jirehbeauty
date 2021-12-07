import 'package:flutter/material.dart';

Widget appbar(
    BuildContext context, String title, dynamic otherData, bool appon) {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey = otherData;

  return AppBar(
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    centerTitle: true,
    elevation: 0.0,
    iconTheme: new IconThemeData(color: Colors.black),
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontSize: 16,
          fontWeight: FontWeight.w600),
    ),
    leading: IconButton(
      onPressed: () {
        //on drawer menu pressed
        if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
          //if drawer is open, then close the drawer
          Navigator.pop(context);
        } else {
          _drawerscaffoldkey.currentState!.openDrawer();
          //if drawer is closed then open the drawer.
        }
      },
      icon: Icon(Icons.menu),
    ),
/*          actions: <Widget>[


            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => new SearchResult()));
                },
              child:

              Container(

                margin: EdgeInsets.only(top: 1,right: 10),

                  child: SvgPicture.asset("images/search_black.svg",width: 18,height: 18,)
              ),
            ),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => new HomeScreen(0)));
                },
                child:   Container(
                    margin: EdgeInsets.only(top: 1,right: 20,left: 10),

                    child: SvgPicture.asset("images/calendar.svg",width: 18,height: 18,
                    color: appon
                        ? Colors.pink
                        : Colors.black,)
                )
            ),
          ],*/
  );
}
