// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter/material.dart";
import "package:centero/models/footer.dart";
import "page1.dart";
import "page2.dart";

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const Footer(),
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            const SizedBox(height: 150),
            const Center(
                child: Text("Thanks for chatting!",
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    textAlign: TextAlign.center)),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                print("Pressed Call Again Button");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.blue),
                padding: MaterialStateProperty.all(const EdgeInsets.all(25.0)),
              ),
              child: const Text("Call Again", style: TextStyle(fontSize: 20.0)),
            ),
            const Padding(padding: EdgeInsets.all(5.0)),
            TextButton(
              onPressed: () {
                print("Pressed Back to Home Screen Button");

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page1()),
                );
              },
              style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              child: const Text("Back to Home Screen"),
            ),
            const SizedBox(height: 100),
            const Text("Rate this interaction",
                style: TextStyle(fontSize: 20.0, color: Colors.black)),
            const SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  print("Red rating pressed");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: const CircleBorder(),
                  backgroundColor: Colors.red,
                ),
                child: const Text(""),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  print("Orange rating pressed");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: const CircleBorder(),
                  backgroundColor: Colors.orange,
                ),
                child: const Text(""),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  print("Yellow rating pressed");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: const CircleBorder(),
                  backgroundColor: Colors.yellow,
                ),
                child: const Text(""),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  print("Green rating pressed");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: const CircleBorder(),
                  backgroundColor: Colors.green,
                ),
                child: const Text(""),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
