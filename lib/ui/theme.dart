import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

//const Color bluishClr = Color(0xFF4e5ae8);
const Color primaryClr = Color(0xFF1976D2);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color blueClr = Color(0xFF2196F3);

const Color white = Colors.white;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Colors.grey[800];


///vse zadeve za temo
class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white, // odgovorn za appbar
    primaryColor: primaryClr, //primary color pa kr simple isti
    brightness: Brightness.light, //Spremenimo Brightnes fora glede texta črn text, pa beu background
  );
  static final dark = ThemeData(
    backgroundColor: darkGreyClr, //odgovorn za appbar
    primaryColor: primaryClr,
    brightness: Brightness.dark, //Spremenimo Brightnes fora glede texta beu text pa backgrogund barve
  );
}
///potem pa še vsi style
TextStyle get headingTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get subHeadingTextStyle { //za datum pa leto
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey),
  );
}

TextStyle get titleTextStle { //za Today
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get subTitleTextStle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 16,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[700]),
  );
}

TextStyle get bodyTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get body2TextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey[200] : Colors.grey[600]),
  );
}
