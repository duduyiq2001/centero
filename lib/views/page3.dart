// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter/material.dart";
import "package:centero/models/footer.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "page1.dart";
import "page2.dart";

class Page3 extends HookWidget {
  const Page3({super.key});

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
            Center(
              child: Text(
                "Thanks for chatting!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                print("Pressed Call Again Button");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
              child: const Text("Call Again"),
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
              child: Text(
                "Back to Home Screen",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 100),
            const Text("Rate this interaction"),
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
                child: null,
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
                child: null,
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
                child: null,
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
                child: null,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
