import 'package:barber_app/constant/appconstant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:flutter/material.dart';


class CustomView extends StatefulWidget {
  const CustomView({Key? key}) : super(key: key);

  @override
  _CustomView createState() => _CustomView();
}

class _CustomView extends State<CustomView> {
  @override
  // implement wantKeepAlive


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      //    bottomNavigationBar: new BottomBar1(),
      child: Container(
        color:  Color(AppConstant.pinkcolor),
            alignment: FractionalOffset.center,
            height: 50,

            child:Row(
              children: <Widget>[

/*                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(1)));
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        child: new SvgPicture.asset("images/location_white.svg")
                    ),
                  ),
                ),*/

                Expanded(

                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(0)));
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        child: new SvgPicture.asset("images/home_white.svg")
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(1)));
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        child: new SvgPicture.asset("images/calendar_white.svg")
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(2)));
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        child: new SvgPicture.asset("images/notification_white.svg")
                    ),
                  ),
                ),
                Expanded(

                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(3)));
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        child: new SvgPicture.asset("images/profile_white.svg")
                    ),
                  ),
                ),


              ],
            ),






          // alignment: FractionalOffset.center,

          // color: Colors.pinkAccent,




    )
    );

  }
}
