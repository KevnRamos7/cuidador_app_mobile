import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorsThemeData{

  ThemeData adultoMayorThemeData = ThemeData(
    textTheme: GoogleFonts.anekMalayalamTextTheme(),
    primaryColor: const Color.fromARGB(255, 31, 31, 31),
    colorScheme: const ColorScheme(
      brightness: Brightness.light, 
      secondary: Color.fromARGB(255, 54, 54, 54),
      primary: Color.fromARGB(255, 1, 2, 43),
      onPrimary: Color.fromARGB(255, 43, 43, 42),
      surface: Colors.white,
      onSurface: Color.fromARGB(255, 35, 35, 35),
      error: Color.fromARGB(255, 117, 21, 21),
      onError: Color.fromARGB(255, 148, 19, 19),
      onSecondary: Color.fromARGB(255, 60, 21, 21),
    )
  );

  ThemeData cuidadorThemeData = ThemeData(

  );

  ThemeData adminThemeData = ThemeData(

  );

}