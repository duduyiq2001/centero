// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter/material.dart";
import "package:centero/models/footer.dart";
import "page3.dart";

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const Footer(),
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(50.0)),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(width: 1.0, color: Colors.black38),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(50.0)),
                  const Text(
                    "(Manager Video Feed)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  // Add more widgets here if needed
                  const Padding(padding: EdgeInsets.all(100.0)),
                  ElevatedButton(
                    onPressed: () {
                      print("Pressed End Call Button");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Page3()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(25.0)),
                    ),
                    child: const Text("End Call"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
