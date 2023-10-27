// ignore_for_file: prefer_const_constructors

import "dart:io";
import "package:flutter/material.dart";

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int counter = 0;
  var pic = File("./../assets/apartmentBuilding.jpg");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75.0),
                child: Image.network(
                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  width: 150.0,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            Center(
              child: Text(
                "Welcome to Shady Oaks Apartments",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
