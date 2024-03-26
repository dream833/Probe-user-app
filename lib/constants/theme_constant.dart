import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/constants/color_constant.dart';

const globalElevation = 3.0;
const globalBorderRadius = 16.0;

ThemeData getTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(globalBorderRadius),
      ),
    ),
    fontFamily: "monstserrat",
    primaryColor: appColorPrimary,
    primarySwatch: generateMaterialColor(appColorPrimary),
    sliderTheme: SliderThemeData(
      inactiveTrackColor: appColorPrimary.withOpacity(0.3),
      valueIndicatorTextStyle:
          const TextStyle(color: Colors.white, fontFamily: "monstserrat"),
      valueIndicatorColor: appColorPrimary,
    ),
    cardTheme: CardTheme(
      elevation: globalElevation,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(globalBorderRadius),
      ),
    ),
    chipTheme: ChipThemeData(
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: appColorPrimary,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(globalBorderRadius)),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: "monstserrat",
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: appColorPrimary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: Colors.white,
      headerBackgroundColor: appColorPrimary,
      // dividerColor: Colors.transparent,
      headerForegroundColor: Colors.white,
      dayOverlayColor: MaterialStatePropertyAll(appColorPrimary),
      dayStyle: const TextStyle(
        color: Colors.black,
        fontFamily: "monstserrat",
        fontWeight: FontWeight.w500,
      ),
      todayBorder: BorderSide(color: appColorPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(globalBorderRadius),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: appColorPrimary,
      background: Colors.white,
    ),
  );
}

class FFamily {
  static const String montserrat = 'monstserrat';
}

class CustomFont {
  static const boldText = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: FFamily.montserrat,
    color: Color(0xFF2E2E2E),
    letterSpacing: 0,
    // height: 1.1,
  );
  static const boldTextMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: FFamily.montserrat,
    color: Color(0xFF2E2E2E),
    letterSpacing: 0,
    // height: 1.1,
  );
  static const mediumText = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    color: Color(0xFF2E2E2E),
    fontFamily: FFamily.montserrat,
    letterSpacing: 0,
    height: 1.3,
  );
  static const regularMediumText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: Color(0xFF2E2E2E),
    fontFamily: FFamily.montserrat,
    letterSpacing: 0,
    // height: 1.2,
  );
  static const regularText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: Color(0xFF2E2E2E),
    fontFamily: FFamily.montserrat,
    letterSpacing: 0,
    height: 1.2,
  );
  static const lightText = TextStyle(
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    color: Color(0xFF2E2E2E),
    letterSpacing: 0,
    fontFamily: FFamily.montserrat,
    // height: 1.1,
  );

    static final boldTextPoppins = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 25,
    color: Colors.black,
  );
  static final mediumTextPoppins = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    color: Colors.black,
    letterSpacing: 0,
    height: 1.2,
  );
  static final regularTextPoppins = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: Colors.black,
    letterSpacing: 0,
    height: 1.2,
  );
  static final lightTextPoppins = GoogleFonts.poppins(
    fontSize: 12,

    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    letterSpacing: 0,
    // height: 1.1,
  );
    static final boldTextRaleway = GoogleFonts.raleway(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 25,
    color: Colors.black,
  );
  static final mediumTextRaleway = GoogleFonts.raleway(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    color: Colors.black,
    letterSpacing: 0,
    height: 1.2,
  );
  static final regularTextRaleway = GoogleFonts.raleway(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: Colors.black,
    letterSpacing: 0,
    height: 1.2,
  );
  static final lightTextRaleway = GoogleFonts.raleway(
    fontSize: 12,

    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    letterSpacing: 0,
    // height: 1.1,
  );
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: _tintColor(color, 0.9),
    100: _tintColor(color, 0.8),
    200: _tintColor(color, 0.6),
    300: _tintColor(color, 0.4),
    400: _tintColor(color, 0.2),
    500: color,
    600: _shadeColor(color, 0.1),
    700: _shadeColor(color, 0.2),
    800: _shadeColor(color, 0.3),
    900: _shadeColor(color, 0.4),
  });
}

int _tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color _tintColor(Color color, double factor) => Color.fromRGBO(
    _tintValue(color.red, factor),
    _tintValue(color.green, factor),
    _tintValue(color.blue, factor),
    1);

int _shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color _shadeColor(Color color, double factor) => Color.fromRGBO(
    _shadeValue(color.red, factor),
    _shadeValue(color.green, factor),
    _shadeValue(color.blue, factor),
    1);

const List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(-1, 1),
    blurRadius: 10,
  )
];
