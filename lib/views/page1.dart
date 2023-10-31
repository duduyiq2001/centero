// ignore_for_file: library_private_types_in_public_api, avoid_print

import "dart:math";
import "package:flutter/material.dart";
import "package:centero/models/footer.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "page2.dart";

class Page1 extends HookWidget {
  const Page1({super.key});
  final managerName = "Bob Jones";

  @override
  Widget build(BuildContext context) {
    final onCall = useState(false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomSheet: const Footer(),
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(height / 20),
            ),
            Center(
              child: Container(
                width: max(height, width) / 15,
                height: max(height, width) / 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      (onCall.value) ? "user.png" : "apartmentBuilding.jpg",
                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            Center(
              child: Text((onCall.value)
                  ? "$managerName will be with you in just a moment!"
                  : "Welcome to Shady Oaks Apartments"),
            ),
            const Padding(padding: EdgeInsets.all(25.0)),
            if (!onCall.value)
              ElevatedButton(
                onPressed: () {
                  onCall.value = true;
                  Future.delayed(const Duration(seconds: 3), () {
                    if (onCall.value) {
                      onCall.value = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Page2()),
                      );
                    }
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "centeroLogo.jpg",
                    width: width / 10,
                  ),
                ),
              ),
            if (onCall.value)
              ElevatedButton(
                onPressed: () {
                  onCall.value = false;
                },
                child: const Text("Cancel Call"),
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
