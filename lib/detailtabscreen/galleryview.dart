import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryView extends StatefulWidget {
  List<Gallery> galleydataList;

  GalleryView(this.galleydataList);

  @override
  _GalleryView createState() => _GalleryView();
}

class _GalleryView extends State<GalleryView> {
  List<Gallery> galleydataList = <Gallery>[];
  List<String> imaglist = <String>[];

  bool datavisible = false;
  bool nodatavisible = true;

  @override
  void initState() {
    super.initState();

    galleydataList = widget.galleydataList;

    if (widget.galleydataList.length > 0) {
      datavisible = true;
      nodatavisible = false;

      print(galleydataList[0].imagePath);

      for (int i = 0; i < galleydataList.length; i++) {
        imaglist.add(galleydataList[i].imagePath! + galleydataList[i].image!);
      }
    } else {
      datavisible = false;
      nodatavisible = true;
    }
    // int gallength = galleydataList.length;
    // print("gallength:$gallength");

    // for(int i = 0 ; i< galleydataList.length;i++) {
    //   imaglist.add(galleydataList[i].imagePath + galleydataList[i].image);
    // }
    //
    int imglength = imaglist.length;
    print("imglength:$imglength");
  }

  int? currentSelectedIndex;
  String? categoryname;

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 45),
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Visibility(
                visible: datavisible,
                child: SizedBox(
                  width: screenwidth * 0.8,
                  height: screenHeight * 0.8,
                  child: Container(
                    color: Colors.transparent,
                    child: StaggeredGridView.countBuilder(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: imaglist.length,
                      itemBuilder: (BuildContext context, int index) =>
                          new Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              // color: Colors.grey,
                              child: new Container(
                                child: CachedNetworkImage(
                                  imageUrl: imaglist[index],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      SpinKitFadingCircle(
                                          color: Color(AppConstant.pinkcolor)),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("images/no_image.png"),
                                ),

                                /*      decoration: BoxDecoration(

                                            image:DecorationImage(
                                              image: NetworkImage(imaglist[index]),
                                              fit: BoxFit.fitWidth,
                                              alignment: Alignment.topCenter,
                                            ) ,
                                            borderRadius: BorderRadius.circular(10.0),

                                        ),*/
                              )),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(2, index.isEven ? 2 : 1),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: nodatavisible,
                child: SizedBox(
                  width: screenwidth,
                  height: screenHeight * 0.5,
                  child: Container(
                    child: Center(
                      child: Container(
                          width: screenwidth,
                          height: screenHeight,
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
                                  "No Images Available ",
                                  style: TextStyle(
                                      color: Color(0xFFa3a3a3),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // body: Container(
      //
      //   height: double.infinity,
      //   width: double.infinity,
      //
      //
      //
      // ),
    );
  }
}
