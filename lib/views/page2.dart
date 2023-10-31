// ignore_for_file: library_private_types_in_public_api

import "package:flutter/material.dart";

import 'page3.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Vertically center the column
        children: <Widget>[
          Container(
            width: 400.0,
            height: 800.0,
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(width: 1.0, color: Colors.black38),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.all(50.0),
            child:  Column(
              children: <Widget>[
                const SizedBox(height: 200), //for spacing?

                const Text(
                  "(Manager Video Feed)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                // Add more widgets here if needed
                const SizedBox(height: 200), // Add some space between the text and the button

            ElevatedButton(
              onPressed: (){
                print("Pressed End Call Button");

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page3()),
                );

                  },
                  style: ButtonStyle(
                    backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.blue),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(25.0)),
                  ),
                  child: const Text("End Call"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
