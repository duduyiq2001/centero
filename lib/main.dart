import "package:flutter/material.dart";
// import "package:centero/views/login.dart";
import "package:centero/views/clienthome.dart";
// import "package:firebase_core/firebase_core.dart";
// import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Centero",
      theme: ThemeData(
          primaryColor: const Color(0xff075E54),
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
          )),
      debugShowCheckedModeBanner: false,
      home: const ClientHome(),
    );
  }
}
