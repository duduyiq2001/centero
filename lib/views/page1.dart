// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter/material.dart";
import "package:centero/themes.dart";
import "package:centero/views/footer.dart";
import "page2.dart";

class Page1 extends HookWidget {
  const Page1({super.key});
  final managerName = "Bob Jones";

  @override
  Widget build(BuildContext context) {
    final onCall = useState(false);

    return Scaffold(
      bottomSheet: const Footer(),
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
            ),
            Center(
              child: Container(
                width: CenteroTheme.getValues(context).logoSize,
                height: CenteroTheme.getValues(context).logoSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      (onCall.value)
                          ? "assets/user.png"
                          : "assets/apartmentBuilding.jpg",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(
                    10.0 * CenteroTheme.getValues(context).scaleFactor)),
            Center(
              child: Text(
                (onCall.value)
                    ? "$managerName will be with you in just a moment!"
                    : "Welcome to Shady Oaks Apartments",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(
                    25.0 * CenteroTheme.getValues(context).scaleFactor)),
            if (!onCall.value)
              ElevatedButton(
                onPressed: () {
                  onCall.value = true;
                  Future.delayed(const Duration(seconds: 3), () {
                    if (onCall.value) {
                      onCall.value = false;
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => const Page2(),
                        ),
                        (route) => false,
                      );
                    }
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      CenteroTheme.getValues(context).borderRadius),
                  child: Image.asset(
                    "centeroLogo.jpg",
                    width: 1.5 * CenteroTheme.getValues(context).logoSize,
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
            Padding(
                padding:
                    EdgeInsets.all(CenteroTheme.getValues(context).spacer)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(width: 1.0, color: Colors.black38),
                    borderRadius: BorderRadius.all(Radius.circular(
                        8 * CenteroTheme.getValues(context).scaleFactor)),
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
                Padding(
                    padding: EdgeInsets.all(
                        50 * CenteroTheme.getValues(context).scaleFactor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
