import 'package:flutter/material.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Client Home Page"),
        ));
  }
}
