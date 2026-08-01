import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFFFFFF),
    secondary: Color(0xff3A4640),
  ),
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Color(0xffFFFCFC);
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xffFFFCFC);
      }
      return Color(0xFF9E9E9E);
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),

    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 4;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      backgroundColor: WidgetStateProperty.all(Color(0xff15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xff161F1B)),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xff3A4640)),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: Color(0xff3A4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xff6A6A6A),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xffFFFFFF),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    hintStyle: TextStyle(
      color: Color(0xff9E9E9E),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionHandleColor: Colors.black,
    selectionColor: Colors.lightBlue,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xff3A4640),
    selectedItemColor: Color(0xff14A662),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xffF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
    ),
  ),
);
