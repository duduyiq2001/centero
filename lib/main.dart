import 'package:flutter/material.dart';
import 'package:centero/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Centero",
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
      ),
      debugShowCheckedModeBanner: false,
      home: new Login(),
    );
  }
}
