import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final double height;
  final bool isHidden;
  final bool isSuffixIconNeeded;
  final TextEditingController textcontroller;
  final Function onTap;


  InputWidget({this.hintText, this.prefixIcon, this.height = 53.0, this.isHidden = false, this.textcontroller, this.onTap, this.isSuffixIconNeeded = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.only(
        right: 16.0,
        left: this.prefixIcon == null ? 16.0 : 0.0,
      ),
      child: TextFormField(
        controller: textcontroller,
        obscureText: isHidden,
        decoration: InputDecoration(
          prefixIcon: this.prefixIcon == null
              ? null
              : Icon(
                  this.prefixIcon,
                  color: Color.fromRGBO(105, 108, 121, 1),
                ),
          suffixIcon: isSuffixIconNeeded ? GestureDetector(
            onTap: onTap,
            child: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
          )
          : null,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: this.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(105, 108, 121, 1),
          ),
        ),
      ),
    );
  }
}
