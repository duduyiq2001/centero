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
            width: 1.5 * CenteroTheme.getValues(context).logoSize,
            height: 1.5 * CenteroTheme.getValues(context).logoSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: (onCall.value)
              ? null
              : Border.all(
                color: Colors.green,
                width: 15.0,
              ),
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
                //? "$managerName will be with you in just a moment!"
                ? "Help is on the way!"
                : "Welcome to Shady Oaks Apartments!",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
            padding: EdgeInsets.all(
                10.0 * CenteroTheme.getValues(context).scaleFactor)),

        // if (!onCall.value)
        //   ElevatedButton(
        //     onPressed: () {
        //       onCall.value = true;
        //       Future.delayed(const Duration(seconds: 3), () {
        //         if (onCall.value) {
        //           onCall.value = false;
        //           pageState.value = PageStates.call;
        //         }
        //       });
        //     },
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(
        //           CenteroTheme.getValues(context).borderRadius),
        //       child: Image.asset(
        //         "assets/centeroLogo.jpg",
        //         width: 1.5 * CenteroTheme.getValues(context).logoSize,
        //       ),
        //     ),
        //   ),
        Padding(
            padding: EdgeInsets.all(CenteroTheme.getValues(context).spacer)),
        Visibility(
          visible: !onCall.value,
          child: Text(
            "Do any of these items help?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
            padding: EdgeInsets.all(.10 * CenteroTheme.getValues(context).spacer)),
        if (onCall.value)
          TextButton(
            onPressed: () {
              onCall.value = false;
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20 * CenteroTheme.getValues(context).scaleFactor),
              shape: const CircleBorder(),
              backgroundColor: Colors.transparent,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.pan_tool,
                  size: 150 * CenteroTheme.getValues(context).scaleFactor,
                  color: Colors.green,
                ),
                Positioned(
                  right: 25 * CenteroTheme.getValues(context).scaleFactor,
                  bottom: 12 * CenteroTheme.getValues(context).scaleFactor,
                  child: Text(
                    "Cancel \nContact",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17 * CenteroTheme.getValues(context).scaleFactor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        // Padding(
        //     padding: EdgeInsets.all(CenteroTheme.getValues(context).spacer)),
        Visibility(
          visible: !onCall.value,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 1.2 * CenteroTheme.getValues(context).logoSize,
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(width: 1.0, color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(
                    8 * CenteroTheme.getValues(context).scaleFactor)),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  // Text(
                  //   "Do these help?",
                  //   style: Theme.of(context).textTheme.bodyMedium,
                  // ),
                  const Padding(padding: EdgeInsets.all(12.0)),
                  TextButton(
                    onPressed: () {
                      //print("Pressed Submit Work Order");
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, CenteroTheme.getValues(context).scaleFactor),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8 * CenteroTheme.getValues(context).scaleFactor),
                      ),
                    ),
                    child: Text("Work Order",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5 * CenteroTheme.getValues(context).scaleFactor)),
                  TextButton(
                    onPressed: () {
                      //print("Pressed Reserve Amenity Button");
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, CenteroTheme.getValues(context).scaleFactor),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8 * CenteroTheme.getValues(context).scaleFactor),
                      ),
                    ),
                    child: Text("Amenities",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,),),
                  ),
                  Padding(padding: EdgeInsets.all(5 * CenteroTheme.getValues(context).scaleFactor)),
                  TextButton(
                    onPressed: () {
                      //print("Pressed Pay Rent Button");
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, CenteroTheme.getValues(context).scaleFactor),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8 * CenteroTheme.getValues(context).scaleFactor),
                      ),
                    ),
                    child: Text("Rent",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,),),
                  ),
                  Padding(padding: EdgeInsets.all(5 * CenteroTheme.getValues(context).scaleFactor)),
                  TextButton(
                    onPressed: () {
                      //print("Pressed Calendar of Events Button");
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, CenteroTheme.getValues(context).scaleFactor),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8 * CenteroTheme.getValues(context).scaleFactor),
                      ),
                    ),
                    child: Text("Events",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,),),
                  ),
                  Padding(padding: EdgeInsets.all(5 * CenteroTheme.getValues(context).scaleFactor)),
                  TextButton(
                    onPressed: () {
                      //print("Pressed Rental Information Button");
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, CenteroTheme.getValues(context).scaleFactor),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8 * CenteroTheme.getValues(context).scaleFactor),
                      ),
                    ),
                    child: Text("Information",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,),),
                  ),
                ],
              ),

            ),
          ],
        ),
        ),
        Padding(
            padding: EdgeInsets.all(
                50 * CenteroTheme.getValues(context).scaleFactor)),
        if (!onCall.value)
            TextButton(
            onPressed: () {
                onCall.value = true;
                Future.delayed(const Duration(seconds: 3), () {
                  if (onCall.value) {
                    onCall.value = false;
                    pageState.value = PageStates.call;
                  }
                });
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(20 * CenteroTheme.getValues(context).scaleFactor),
                shape: const CircleBorder(),
                backgroundColor: Colors.transparent,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.pan_tool,
                    size: 150 * CenteroTheme.getValues(context).scaleFactor,
                    color: Colors.green,
                  ),
                  Positioned(
                    right: 8 * CenteroTheme.getValues(context).scaleFactor,
                    bottom: 12 * CenteroTheme.getValues(context).scaleFactor,
                    child: Text(
                      "Would you \nlike to chat?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17 * CenteroTheme.getValues(context).scaleFactor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(
            //       CenteroTheme.getValues(context).borderRadius),
            //   child: Image.asset(
            //     "assets/centeroLogo.jpg",
            //     width: 1.5 * CenteroTheme.getValues(context).logoSize,
            //   ),
            // ),

      ],
    );

    var callTime = Center(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(
                  CenteroTheme.getValues(context).spacer)),
          Container(
            decoration: BoxDecoration(
              //color: Colors.black12,
              image: DecorationImage(
                image: AssetImage('assets/manager.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
              ),

              border: Border.all(width: 1.0, color: Colors.black38),
              borderRadius: BorderRadius.all(
                Radius.circular(CenteroTheme.getValues(context).borderRadius),
              ),
            ),
            // padding: EdgeInsets.all(
            //     50.0 * CenteroTheme.getValues(context).scaleFactor),

            child: Column(
              children: <Widget>[
                // Padding(
                //     padding: EdgeInsets.all(
                //         25 * CenteroTheme.getValues(context).scaleFactor)),
                Padding(
                    padding: EdgeInsets.all(
                        CenteroTheme.getValues(context).spacer)),
                Text(
                  "Illusion of a Volumetric Display",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 7 * CenteroTheme.getValues(context).spacer,
                    right: 5 * CenteroTheme.getValues(context).spacer,
                    left: 5 * CenteroTheme.getValues(context).spacer,
                    bottom: 7 * CenteroTheme.getValues(context).spacer,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(
                  .2 * CenteroTheme.getValues(context).spacer)),
          TextButton(
            onPressed: () {
              pageState.value = PageStates.callEnded;
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20 * CenteroTheme.getValues(context).scaleFactor),
              shape: const CircleBorder(),
              backgroundColor: Colors.transparent,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.pan_tool,
                  size: 150 * CenteroTheme.getValues(context).scaleFactor,
                  color: Colors.green,
                ),
                Positioned(
                  right: 20 * CenteroTheme.getValues(context).scaleFactor,
                  bottom: 12 * CenteroTheme.getValues(context).scaleFactor,
                  child: Text(
                    "End \nContact",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20 * CenteroTheme.getValues(context).scaleFactor,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
                25 * CenteroTheme.getValues(context).scaleFactor)),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  rated.value = false;
                  pageState.value = PageStates.home;
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20 * CenteroTheme.getValues(context).scaleFactor),
                  shape: const CircleBorder(),
                  backgroundColor: Colors.transparent,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                      child: Icon(
                        Icons.pan_tool,
                        size: 150 * CenteroTheme.getValues(context).scaleFactor,
                        color: Colors.red,
                      ),
                    ),
                    Positioned(
                      left: 25 * CenteroTheme.getValues(context).scaleFactor,
                      bottom: 12 * CenteroTheme.getValues(context).scaleFactor,
                      child: Text(
                        "Start \nOver",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20 * CenteroTheme.getValues(context).scaleFactor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(
                      10 * CenteroTheme.getValues(context).scaleFactor)),
              TextButton(
                onPressed: () {
                  rated.value = false;
                  pageState.value = PageStates.call;
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20 * CenteroTheme.getValues(context).scaleFactor),
                  shape: const CircleBorder(),
                  backgroundColor: Colors.transparent,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.pan_tool,
                      size: 150 * CenteroTheme.getValues(context).scaleFactor,
                      color: Colors.green,
                    ),
                    Positioned(
                      right: 25 * CenteroTheme.getValues(context).scaleFactor,
                      bottom: 12 * CenteroTheme.getValues(context).scaleFactor,
                      child: Text(
                        "Call \nAgain",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20 * CenteroTheme.getValues(context).scaleFactor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(
                10 * CenteroTheme.getValues(context).scaleFactor)),
        // TextButton(
        //   onPressed: () {
        //     pageState.value = PageStates.home;
        //   },
        //   child: Text(
        //     "Back to Home Screen",
        //     style: Theme.of(context).textTheme.headlineMedium,
        //   ),
        // ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                (!rated.value)
                    ? "How did we do?"
                    : "Thanks for your feedback!",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                  padding: EdgeInsets.all(
                      10 * CenteroTheme.getValues(context).scaleFactor)),
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
                            5 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.green,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.sentiment_very_satisfied,
                          size: 75 * CenteroTheme.getValues(context).scaleFactor,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            2 * CenteroTheme.getValues(context).scaleFactor)),
                    ElevatedButton(
                      onPressed: () {
                        rated.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            5 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.lightGreen,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.sentiment_satisfied,
                          size: 75 * CenteroTheme.getValues(context).scaleFactor,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            2 * CenteroTheme.getValues(context).scaleFactor)),
                    ElevatedButton(
                      onPressed: () {
                        rated.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            5 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.yellow,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.sentiment_neutral,
                          size: 75 * CenteroTheme.getValues(context).scaleFactor,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            2 * CenteroTheme.getValues(context).scaleFactor)),
                    ElevatedButton(
                      onPressed: () {
                        rated.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            5 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.orange,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.sentiment_dissatisfied,
                          size: 75 * CenteroTheme.getValues(context).scaleFactor,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            2 * CenteroTheme.getValues(context).scaleFactor)),
                    ElevatedButton(
                      onPressed: () {
                        rated.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            5 * CenteroTheme.getValues(context).scaleFactor),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.red,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.sentiment_very_dissatisfied,
                          size: 75 * CenteroTheme.getValues(context).scaleFactor,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            2 * CenteroTheme.getValues(context).scaleFactor)),
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
