import 'package:flutter/material.dart';
import 'package:centero/views/login.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

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
      ),
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
