import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTextfield{

  Widget searchTextField({
    required String hintText,
    required IconData icon,
    required Function(String) onChanged,
  }){
    return Container(
      height: Get.height * 0.05,
      margin: const EdgeInsets.all(16),
      child: TextField(
        textAlign: TextAlign.center,
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.search, color: Color(0xFFA6A6A6), size: 20,),
          hintText: hintText,
      
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w100,
              fontSize: 13,
            ),
      
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Color(0xFFA6A6A6)),
              borderRadius: BorderRadius.circular(8),
            ),
        
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Color(0xFFA6A6A6)),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Color(0xFFA6A6A6)),
              borderRadius: BorderRadius.circular(8),
            ),
      
        ),
      ),
    );
  }

}