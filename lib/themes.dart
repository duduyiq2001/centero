import "package:flutter/material.dart";

class CenteroTheme {
  static final ThemeData mediumScreens = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 20.0),
      bodySmall: TextStyle(fontSize: 14.0),
      headlineLarge: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue),
        padding: MaterialStatePropertyAll(EdgeInsets.all(20.0)),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.black),
      ),
    ),
  );

  static final ThemeData protoScreens = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 20.0),
      bodySmall: TextStyle(fontSize: 14.0),
      headlineLarge: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.red),
        padding: MaterialStatePropertyAll(EdgeInsets.all(20.0)),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.black),
      ),
    ),
  );

  static ThemeData getTheme(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    if (media.size.height > 3000) {
      return CenteroTheme.protoScreens;
    } else {
      return CenteroTheme.mediumScreens;
    }
  }
}
