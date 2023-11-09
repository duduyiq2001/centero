// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:centero/themes.dart";
import "package:centero/views/footer.dart";

class PageStates {
  static const home = 0;
  static const call = 1;
  static const callEnded = 2;
}

class ClientHome extends HookWidget {
  const ClientHome({super.key});

  @override
  Widget build(BuildContext context) {
    final pageState = useState(PageStates.home);
    final onCall = useState(false);
    final rated = useState(false);
    var managerName = "Bob Jones";

    // ignore: unused_element
    void resetState() {
      rated.value = false;
    }

    var home = Column(
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
                  pageState.value = PageStates.call;
                }
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  CenteroTheme.getValues(context).borderRadius),
              child: Image.asset(
                "assets/centeroLogo.jpg",
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
            padding: EdgeInsets.all(CenteroTheme.getValues(context).spacer)),
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
    );

    var callTime = Center(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(
                  50.0 * CenteroTheme.getValues(context).scaleFactor)),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(width: 1.0, color: Colors.black38),
              borderRadius: BorderRadius.all(
                Radius.circular(CenteroTheme.getValues(context).borderRadius),
              ),
            ),
            padding: EdgeInsets.all(
                50.0 * CenteroTheme.getValues(context).scaleFactor),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(
                        25 * CenteroTheme.getValues(context).scaleFactor)),
                Text(
                  "(Manager Video Feed)",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 6 * CenteroTheme.getValues(context).spacer,
                    right: 4 * CenteroTheme.getValues(context).spacer,
                    left: 4 * CenteroTheme.getValues(context).spacer,
                    bottom: 6 * CenteroTheme.getValues(context).spacer,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    pageState.value = PageStates.callEnded;
                  },
                  child: const Text("End Call"),
                ),
              ],
            ),
          ),
          Padding(
              padding:
                  EdgeInsets.all(CenteroTheme.getValues(context).footerSize)),
        ],
      ),
    );

    var callEnded = Column(
      children: [
        Padding(
            padding:
                EdgeInsets.all(2 * CenteroTheme.getValues(context).spacer)),
        Center(
          child: Text(
            "Thanks for chatting!",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
            padding: EdgeInsets.all(
                50 * CenteroTheme.getValues(context).scaleFactor)),
        ElevatedButton(
          onPressed: () {
            pageState.value = PageStates.call;
          },
          child: const Text("Call Again"),
        ),
        Padding(
            padding: EdgeInsets.all(
                10 * CenteroTheme.getValues(context).scaleFactor)),
        TextButton(
          onPressed: () {
            pageState.value = PageStates.home;
          },
          child: Text(
            "Back to Home Screen",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                (!rated.value)
                    ? "Rate this interaction"
                    : "Thanks for your feedback!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Padding(
                  padding: EdgeInsets.all(
                      25 * CenteroTheme.getValues(context).scaleFactor)),
              if (!rated.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        rated.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            20 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.red,
                      ),
                      child: null,
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            5 * CenteroTheme.getValues(context).scaleFactor)),
                    ElevatedButton(
                      onPressed: () {
                        rated.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            20 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.orange,
                      ),
                      child: null,
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            5 * CenteroTheme.getValues(context).scaleFactor)),
                    ElevatedButton(
                      onPressed: () {
                        rated.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            20 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.yellow,
                      ),
                      child: null,
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            5 * CenteroTheme.getValues(context).scaleFactor)),
                    ElevatedButton(
                      onPressed: () {
                        rated.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            20 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.green,
                      ),
                      child: null,
                    ),
                  ],
                ),
              Padding(
                padding: EdgeInsets.all(
                  CenteroTheme.getValues(context).footerSize +
                      CenteroTheme.getValues(context).spacer,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      bottomSheet: const Footer(),
      body: Container(
        margin: EdgeInsets.all(5 * CenteroTheme.getValues(context).scaleFactor),
        child: (pageState.value == PageStates.home)
            ? home
            : (pageState.value == PageStates.call)
                ? callTime
                : callEnded,
      ),
    );
  }
}
