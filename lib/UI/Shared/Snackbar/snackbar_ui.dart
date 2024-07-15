import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackbarUI{

  void snackbarError(String title, String message){
    if(Get.isSnackbarOpen){
      Get.back();
    }
    Get.snackbar(
      '', 
      '',
      titleText: Text(title, 
      style: GoogleFonts.roboto(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200), 
        textAlign: TextAlign.center,),
      messageText: message == '' ? Container() : Text(message, 
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w200), 
          textAlign: TextAlign.center,),
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      borderRadius: 10,
      colorText: Colors.white,
      icon: const Icon(CupertinoIcons.xmark_octagon_fill, color: Colors.red, size: 20,),
      maxWidth: Get.height * 0.43,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(vertical: 6),
      boxShadows: [
        const BoxShadow(
          color: Color.fromARGB(255, 1, 34, 61), // Color de la sombra
          blurRadius: 5.0, // Radio de desenfoque
          spreadRadius: 2.0, // Radio de expansión
          offset: Offset(0, 2), // Desplazamiento en dirección y
        ),
      ],
    );
  }

  void snackbarSuccess(String title, String message){
    if(Get.isSnackbarOpen){
      Get.back();
    }
    Get.snackbar(
      '', 
      '',
      titleText: Text(title, 
      style: GoogleFonts.roboto(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200), 
        textAlign: TextAlign.center,),
      messageText: message == '' ? Container() : Text(message, 
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w200), 
          textAlign: TextAlign.center,),
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      borderRadius: 10,
      colorText: Colors.white,
      icon: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green, size: 20,),
      maxWidth: Get.height * 0.43,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 6),
      boxShadows: [
        const BoxShadow(
          color: Color.fromARGB(255, 1, 34, 61), // Color de la sombra
          blurRadius: 5.0, // Radio de desenfoque
          spreadRadius: 2.0, // Radio de expansión
          offset: Offset(0, 2), // Desplazamiento en dirección y
        ),
      ],
    );
  }

  void snackbarInfo(String title, String message){
    Get.snackbar(
      '', 
      '',
      titleText: Text(title, 
      style: GoogleFonts.roboto(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200), 
        textAlign: TextAlign.center,),
      messageText: message == '' ? Container() : Text(message, 
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w200), 
          textAlign: TextAlign.center,),
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      borderRadius: 10,
      colorText: Colors.white,
      icon: const Icon(CupertinoIcons.info_circle_fill, color: Color.fromARGB(255, 15, 117, 201), size: 20,),
      maxWidth: Get.height * 0.43,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 6),
      boxShadows: [
        const BoxShadow(
          color: Color.fromARGB(255, 1, 34, 61), // Color de la sombra
          blurRadius: 5.0, // Radio de desenfoque
          spreadRadius: 2.0, // Radio de expansión
          offset: Offset(0, 2), // Desplazamiento en dirección y
        ),
      ],
    );
  }
}