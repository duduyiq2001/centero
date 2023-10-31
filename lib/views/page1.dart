// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter/material.dart";
import "package:centero/models/footer.dart";
import "page2.dart";

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const Footer(),
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75.0),
                child: Image.asset(
                  "apartmentBuilding.jpg",
                  width: 150.0,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            const Center(
              child: Text("Welcome to Shady Oaks Apartments"),
            ),
            const Padding(padding: EdgeInsets.all(25.0)),
            ElevatedButton(
              onPressed: () {
                print("Pressed Call Manager Button");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "centeroLogo.jpg",
                  width: 150.0,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(width: 1.0, color: Colors.black38),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Other Stuff",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Padding(padding: EdgeInsets.all(5.0)),
                      TextButton(
                        onPressed: () {
                          print("Pressed Submit Work Order");
                        },
                        child: const Text("Submit Work Order"),
                      ),
                      TextButton(
                        onPressed: () {
                          print("Pressed Reserve Amenity Button");
                        },
                        child: const Text("Reserve Amenity"),
                      ),
                      TextButton(
                        onPressed: () {
                          print("Pressed Pay Rent Button");
                        },
                        child: const Text("Pay My Rent"),
                      ),
                      TextButton(
                        onPressed: () {
                          print("Pressed Calendar of Events Button");
                        },
                        child: const Text("Calendar of Events"),
                      ),
                      TextButton(
                        onPressed: () {
                          print("Pressed Rental Information Button");
                        },
                        child: const Text("Rental Information"),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(100.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
