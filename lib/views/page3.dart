// ignore_for_file: library_private_types_in_public_api

import "package:flutter/material.dart";

import 'page1.dart';
import 'page2.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),

            const SizedBox(height: 150), // for spacing (change later?)

            const Center(
              child: Text(
                "Thanks for chatting!",
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                  textAlign: TextAlign.center
              )


            ),

            const SizedBox(height: 100), // for spacing (change later?)

            ElevatedButton(
              onPressed: () {
                print("Pressed Call Again Button");

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page2()),
                );
            },
              style: ButtonStyle(
                backgroundColor:
                const MaterialStatePropertyAll<Color>(Colors.blue),
                padding: MaterialStateProperty.all(const EdgeInsets.all(25.0)),
              ),
              child: const Text("Call Again", style: TextStyle(fontSize: 20.0))
            ),

            const Padding(padding: EdgeInsets.all(5.0)),
            TextButton(
              onPressed: () {
                print("Pressed Back to Home Screen Button");

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page1()),
                );

              },
              style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              child: const Text("Back to Home Screen"),
            ),

            const SizedBox(height: 100), // for spacing (change later?)

            const Text("Rate this interaction", style: TextStyle(fontSize: 20.0, color: Colors.black)),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    print("Red rating pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0), // Adjust the padding for the button size
                    shape: CircleBorder(), // Make the button circular
                    backgroundColor: Colors.red, // Change the button's background color
                  ),
                  child: Text(
                    ""
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    print("Orange rating pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0), // Adjust the padding for the button size
                    shape: CircleBorder(), // Make the button circular
                    backgroundColor: Colors.orange, // Change the button's background color
                  ),
                  child: Text(
                      ""
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    print("Yellow rating pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0), // Adjust the padding for the button size
                    shape: CircleBorder(), // Make the button circular
                    backgroundColor: Colors.yellow, // Change the button's background color
                  ),
                  child: Text(
                      ""
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    print("Green rating pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0), // Adjust the padding for the button size
                    shape: CircleBorder(), // Make the button circular
                    backgroundColor: Colors.green, // Change the button's background color
                  ),
                  child: Text(
                      ""
                  ),
                ),

              ]
            )
          ]
        )
      );

  }
}
