import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusAlert{

  Future<void> alertError(String title, String message) async{
    return Get.defaultDialog(
      title: title,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      radius: 8,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 50),
          const SizedBox(height: 30),
          Text(message, 
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.start
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            minimumSize: const Size(100, 40),
          ),
          onPressed: (){
            Get.back();
          },
          child: const Text('Aceptar', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ],
    );
  }

}