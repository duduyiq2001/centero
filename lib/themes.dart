import "package:flutter/material.dart";

class Values {
  double logoSize;
  double scaleFactor;
  double borderRadius;
  double spacer;
  double footerSize;

  Values(this.logoSize, this.scaleFactor, this.borderRadius, this.spacer,
      this.footerSize);
}

const green = Color(0xFF41AF28);
const black = Color(0xFF221D34);

class CenteroTheme {
  static Values mediumValues = Values(100, 1, 25, 20, 50);
  static Values protoValues = Values(400, 3, 80, 150, 150);

  static final ThemeData mediumScreens = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 28),
      bodyMedium: TextStyle(fontSize: 20),
      bodySmall: TextStyle(fontSize: 16),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: black,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: black,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(green),
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
        foregroundColor: MaterialStatePropertyAll(black),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: green,
    ),
  );

  static final ThemeData protoScreens = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 72),
      bodyMedium: TextStyle(fontSize: 56),
      bodySmall: TextStyle(fontSize: 48),
      headlineLarge: TextStyle(
        fontSize: 84,
        fontWeight: FontWeight.bold,
        color: black,
      ),
      headlineMedium: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: black,
      ),
      headlineSmall: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(green),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(40)),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(
            fontSize: 64,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(black),
        padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            fontSize: 48,
          ),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: green,
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

  static Values getValues(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    if (media.size.height > 3000) {
      return CenteroTheme.protoValues;
    } else {
      return CenteroTheme.mediumValues;
    }
  }
}
