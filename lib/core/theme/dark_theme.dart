import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xff282828),
    secondary: Color(0xffC6C6C6),
  ),
  scaffoldBackgroundColor: Color(0xff181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    titleTextStyle: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
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
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)
      )),
      backgroundColor: WidgetStateProperty.all(Color(0xff15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFCFC),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)), 
    )
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xff6E6E6E), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xffC6C6C6)),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: Color(0xffC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xffA0A0A0),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xffFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xff282828),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: .5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(
      color: Color(0xff6D6D6D),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),

  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xff6E6E6E), thickness: 1),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionHandleColor: Colors.white,
    selectionColor: Colors.lightBlue,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xffC6C6C6),
    selectedItemColor: Color(0xff15B86C),
  ),
  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xff181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0xff15B86C), width: 1),
    ),
    elevation: 2,
    shadowColor: Color(0xff15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    ),
  ),
);
