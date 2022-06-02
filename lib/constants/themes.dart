import 'package:flutter/material.dart';

import 'constans.dart';

class AppTheme {
  static final TextStyle heading = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    // letterSpacing: 1.2,
    color: Colors.black,
  );
  static final TextStyle headingColorBlue = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    // letterSpacing: 1.2,
    color: sliderTextColor,
  );
  static final TextStyle subHeading = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 12,
    color: Colors.black,
  );
  static final TextStyle subHeadingColorBlue = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 12,
    color: sliderTextColor,
  );
  static final containerBackground = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xfff4DC0B1),
      Color(0xfff2aa293),
    ],
  );
}

///////////////////////////////////////////////////////////////////////////
InputDecoration textFormInputDecorationForPassword(
    IconData icon, String label, Function() obscureText, bool obscurepasswrod) {
  return InputDecoration(
    errorStyle: AppTheme.subHeading.copyWith(
      color: customColorGray,
    ),
    hintText: label,
    hintStyle: AppTheme.heading.copyWith(
      color: customColorGray,
      fontSize: 10,
    ),
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColorGray,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColorGray,
      ),
    ),
    suffixIcon: IconButton(
      onPressed: obscureText,
      icon: obscurepasswrod
          ? Icon(
              icon,
              color: customColorGray,
            )
          : Icon(
              Icons.visibility,
              color: customColorGray,
            ),
    ),
  );
}

//////////////////////////////////////////////////////////////////////
InputDecoration textFormInputDecoration(
  IconData icon,
  String label,
) {
  return InputDecoration(
    errorStyle: AppTheme.subHeading.copyWith(
      color: customColor,
    ),
    hintText: label,
    hintStyle: AppTheme.heading.copyWith(
      color: customColorGray,
      fontSize: 10,
    ),
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.all(10),
    suffixIcon: Icon(
      icon,
      color: customColorGray,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColorGray,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColorGray,
      ),
    ),
  );
}

InputDecoration textFormInpuofEidtProfile({
  IconData? icon,
  String? hintText,
}) {
  return InputDecoration(
    errorStyle: AppTheme.subHeading.copyWith(
      color: customColor,
    ),
    fillColor: Colors.white,
    hintText: hintText ?? "",
    // filled: true,
    isDense: true,
    contentPadding: EdgeInsets.all(10),
    suffixIcon: Icon(
      icon,
      color: customColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColorGray,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColorGray,
      ),
    ),
  );
}

///////////////////////////////////////////////////////////////
InputDecoration conectedTextFormStyle({String? lableText}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: customColor),
      gapPadding: 10,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: customColor),
      gapPadding: 10,
    ),
    // suffixIcon: Icon(
    //   Icons.edit,
    //   color: customColor,
    // ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    labelStyle: AppTheme.heading.copyWith(
      color: customColor,
    ),
    labelText: lableText,
  );
}

/////////////////////////////////////////////////////////
