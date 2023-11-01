import "package:flutter/material.dart";

class Values {
  double logoSize;
  double scaleFactor;
  double borderRadius;
  double spacer;

  Values(this.logoSize, this.scaleFactor, this.borderRadius, this.spacer);
}

class CenteroTheme {
  static Values mediumValues = Values(100, 1, 20, 10);
  static Values protoValues = Values(400, 3, 80, 100);

  static final ThemeData mediumScreens = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 20.0),
      bodySmall: TextStyle(fontSize: 14.0),
      headlineLarge: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
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
        fontSize: 96,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.blue),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(40)),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(
            fontSize: 48,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.black),
        padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            fontSize: 48,
          ),
        ),
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

  static Values getValues(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    if (media.size.height > 3000) {
      return CenteroTheme.protoValues;
    } else {
      return CenteroTheme.mediumValues;
    }
  }
}
