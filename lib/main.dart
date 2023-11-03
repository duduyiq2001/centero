import "package:flutter/material.dart";
import "package:centero/views/login.dart";
import "package:centero/views/clienthome.dart";
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";
import "themes.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Centero",
      theme: CenteroTheme.getTheme(context),
      debugShowCheckedModeBanner: false,
      home: const ClientHome(),
    );
  }
}
