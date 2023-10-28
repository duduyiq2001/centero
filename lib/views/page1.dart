// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter/material.dart";
// import "package:centero/controllers/scaling.dart";

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  var textButtonStyle = const ButtonStyle(
    foregroundColor: MaterialStatePropertyAll(Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text(
              "Welcome to Shady Oaks Apartments",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          const Padding(padding: EdgeInsets.all(25.0)),
          ElevatedButton(
            onPressed: () {
              print("Pressed Call Manager Button");
            },
            style: ButtonStyle(
              backgroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.blue),
              padding: MaterialStateProperty.all(const EdgeInsets.all(25.0)),
            ),
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
                    const Text(
                      "Other Stuff",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    TextButton(
                      onPressed: () {
                        print("Pressed Submit Work Order");
                      },
                      style: textButtonStyle,
                      child: const Text("Submit Work Order"),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Pressed Reserve Amenity Button");
                      },
                      style: textButtonStyle,
                      child: const Text("Reserve Amenity"),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Pressed Pay Rent Button");
                      },
                      style: textButtonStyle,
                      child: const Text("Pay My Rent"),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Pressed Calendar of Events Button");
                      },
                      style: textButtonStyle,
                      child: const Text("Calendar of Events"),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Pressed Rental Information Button");
                      },
                      style: textButtonStyle,
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
    );
  }
}
