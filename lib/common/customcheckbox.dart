import 'package:barber_app/ResponseModel/empResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:flutter/material.dart';


class CustomCheckBox extends StatefulWidget {

  final EmpData _item;
  CustomCheckBox(this._item);

  // bool value;
  // CustomCheckBox(this.value);





  @override
  _CustomCheckBox createState() => _CustomCheckBox();
}

class _CustomCheckBox extends State<CustomCheckBox> {

  bool? _value;
  // bool showHidee;

  @override
  // implement wantKeepAlive


  @override
  void initState() {
    _value =  widget._item.isSelected;
    // showHidee = true;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var color =  _value!
        ? Color(AppConstant.pinkcolor)
        : Color(0xFFa5a5a5);


    return Container(
        width: 15,
        height: 15,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _value = !_value!;
              print(_value);
            });

          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: color,
              border: Border.all(color: const Color(0xFFdddddd),),
              borderRadius: BorderRadius.circular(8),),

            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: _value!
                  ? Icon(
                Icons.check,
                size: 15.0,
                color: Colors.white,
              )
                  : Icon(
                Icons.check_box_outline_blank_outlined,
                size: 15.0,
                color: color,
              ),
            ),
          ),
        )
    );
  }
}

