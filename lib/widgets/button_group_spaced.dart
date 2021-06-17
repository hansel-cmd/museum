import 'package:flutter/material.dart';
import 'package:museum/utils/constants.dart';

class ButtonGroupSpaced extends StatefulWidget {
  
  final List departments;
  final int activeIndex;
  final Function callBack;


  ButtonGroupSpaced({this.activeIndex, this.callBack, this.departments});

  @override
  _ButtonGroupSpacedState createState() => _ButtonGroupSpacedState(activeIndex: this.activeIndex, callBack: this.callBack);
}

class _ButtonGroupSpacedState extends State<ButtonGroupSpaced> {

  int activeIndex;
  Function callBack;
  _ButtonGroupSpacedState({this.activeIndex, this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: this.widget.departments.map((item) {
          int currentIndex = this.widget.departments.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                activeIndex = currentIndex;
              });
              callBack(currentIndex);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: activeIndex == currentIndex
                      ? Constants.primaryColor
                      : Color.fromRGBO(163, 167, 168, 1),
                ),
              ),
              child: Text(item["displayName"]),
            ),
          );
        }).toList(),
      ),
    );
  }
}
