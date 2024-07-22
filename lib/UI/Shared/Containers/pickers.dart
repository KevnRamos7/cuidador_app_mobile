import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pickers{

  Widget timePicker(String titulo, Widget timePickerDropdown) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              // key: const Key('pickers'),
              width: Get.width * 0.6,
              height: Get.height * 0.05,
              child: timePickerDropdown
            )
          ],
        ),
        titulo == '' ? const SizedBox() : Text(
          titulo, 
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center),
      ],
    ),
  );
}

}