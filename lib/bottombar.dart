import 'dart:collection';

import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/fragments/appoinment.dart';
import 'package:barber_app/fragments/fghome.dart';
import 'package:barber_app/fragments/notification.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'common/inndicator.dart';
import 'fragments/profile.dart';

class BottomBar extends StatefulWidget {
  int index;
  int save_prev_index = 2;

  BottomBar(this.index);

  @override
  State<StatefulWidget> createState() {
    return BottomBar1();
  }
}

class BottomBar1 extends State<BottomBar> {
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool? login = false;

  @override
  Widget build(BuildContext context) {
    login = PreferenceUtils.getlogin(AppConstant.isLoggedIn);

    return new DefaultTabController(
      length: 4,
      initialIndex: widget.index,
      child: new Scaffold(
        // body:(_getBody(index)),

        // 0a8dd3a0-17c9-490d-9178-1a9d4863448a

        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            // FgHome(),
            // FgHome(),
            // FgHome(),
            // FgHome(),
            // Profile(),
            FgHome(),
            Appoinment(),
            // Map(),

            Notification1(),
            Profile(),
          ],
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            /*     Tab(
                    icon: Container(
                        width: 20,
                        height: 20,
                        child: new SvgPicture.asset("images/location_white.svg")
                    ),
                  ),*/
            Tab(
              icon: Container(
                  width: 20,
                  height: 20,
                  child: new SvgPicture.asset("images/home_white.svg")),
            ),
            Tab(
              icon: GestureDetector(
                // onTap:(){
                //
                //   print("11233232");
                //
                //
                // },

                child: Container(
                    width: 20,
                    height: 20,
                    child: new SvgPicture.asset("images/calendar_white.svg")),
              ),
            ),
            Tab(
              icon: Container(
                  width: 20,
                  height: 20,
                  child: new SvgPicture.asset("images/notification_white.svg")),
            ),
            Tab(
              icon: Container(
                  width: 20,
                  height: 20,
                  child: new SvgPicture.asset("images/profile_white.svg")),
            ),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(0.0),
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          indicator: MD2Indicator(
            indicatorSize: MD2IndicatorSize.full,
            indicatorHeight: 5.0,
            indicatorColor: Colors.white,
          ),
          onTap: (value) {
            _navigationQueue.addLast(index);
            // index = value;
            setState(() => index = value);

            // // setState(() {
            //   if(index == 4){
            //     print("index456:$index");
            //
            //     _getBody(index);
            //   }
            // // });

            print(value);
          },
        ),
        backgroundColor: Color(AppConstant.pinkcolor),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (widget.index != 1) {
      return (await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => new HomeScreen(1))));
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm Exit"),
              content: Text("Are you sure you want to exit?"),
              actions: <Widget>[
                TextButton(
                  child: Text("YES"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                TextButton(
                  child: Text("NO"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      return Future.value(true);
    }
    // return (await Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => new HomeScreen(0)))
    // ) ??
    //     false;
  }
// Future<bool> _onWillPop() {
//   setState(
//         () {
//       print("currentindex852:${widget.index}");
//       if (widget.index != 1) {
//
//
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) => new HomeScreen(1)));
//
//       } else {
//         showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Confirm Exit"),
//                 content: Text("Are you sure you want to exit?"),
//                 actions: <Widget>[
//                   FlatButton(
//                     child: Text("YES"),
//                     onPressed: () {
//                       SystemNavigator.pop();
//                     },
//                   ),
//                   FlatButton(
//                     child: Text("NO"),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   )
//                 ],
//               );
//             });
//         return Future.value(true);
//       }
//     },
//   );
// }
}
