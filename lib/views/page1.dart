// ignore_for_file: prefer_const_constructors
// ignore_for_file: library_private_types_in_public_api

import "package:flutter/material.dart";

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(padding: EdgeInsets.all(25)),
              ElevatedButton(
                  onPressed: () {
                    print("Clicked Call Manager Button");
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.blue),
                      padding: MaterialStateProperty.all(EdgeInsets.all(25.0))),
                  child: Text("Touch Here to Talk to my Property Manager")),
              Padding(padding: EdgeInsets.all(50)),
              Positioned(
                  right: 10.0,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: const <Widget>[
                      Text("Other Stuff"),
                      Padding(padding: EdgeInsets.all(5))
                    ],
                  ))
            ],
          ),
        ));
  }
}
