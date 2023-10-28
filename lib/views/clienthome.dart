// ignore_for_file: library_private_types_in_public_api

import "package:flutter/material.dart";
import "package:centero/views/page1.dart";
// import "package:footer/footer.dart";
// import "package:footer/footer_view.dart";

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
      backgroundColor: Colors.white70,
      body: const Page1(),
      bottomSheet: Container(
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Text("Powerered By"),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "centeroBrand.jpg",
                width: 40.0,
              ),
            ),
            const Padding(padding: EdgeInsets.all(25.0)),
          ],
        ),
      ),
    );
  }
}
