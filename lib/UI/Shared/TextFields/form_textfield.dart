import 'package:flutter/material.dart';

class FormTextfield{

  Widget form_txt({
    required double height,
    required double width,
    required String hintText,
    required double padding,
    double? contentPaddingLeft,
    double? contentPaddingTop,
    int? maxLines,
    required TextEditingController controller,
  }){
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: padding),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 30,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          // hintText: hintText,
          hintText: hintText,
          hintMaxLines: 5,
          hintStyle: const TextStyle(
            color: Color(0xFFBDBDBD),
            fontSize: 12,
          ),
          contentPadding: EdgeInsets.only(left: contentPaddingLeft ?? 10, top: contentPaddingTop ?? 20),
        ),
      )
    );
  }

}