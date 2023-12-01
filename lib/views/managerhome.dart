// ignore_for_file: avoid_print

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:intl/intl.dart";
import "package:centero/themes.dart";
import "package:centero/views/footer.dart";
import "package:centero/models/resident.dart";
import "package:centero/models/manager.dart";
import "package:centero/controllers/authentication/managerauthentication.dart";
import "package:centero/views/managerlogin.dart";
import "package:centero/main.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:centero/views/notification.dart";
import "package:centero/controllers/call/acceptcall.dart";

enum PageStates {
  home,
  incomingCall,
  onCall,
}

String getStatus(DateTime rentDueDate) {
  DateTime now = DateTime.now();
  if (now.isBefore(rentDueDate)) {
    return "Due in ${rentDueDate.difference(now).inDays} days";
  }
  return "Overdue by ${now.difference(rentDueDate).inDays} days";
}

class ManagerHome extends HookWidget {
  final Manager? manager;

  const ManagerHome({super.key, this.manager});

  @override
  Widget build(BuildContext context) {
    var showLeftPanel = useState(true);
    var showRightPanel = useState(true);
    var pageState = useState(PageStates.home);

    var resident = useState(dummyResidents[10]);

    var dateformat = DateFormat("yyyy/MM/dd");

    //set up messaging!
    // a listener for messaging from FCM!
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Got a message whilst in the foreground!");
      print("Message data: ${message.data}");
      //html.window.alert("${message.data}");
      BuildContext? current = navigatorKey.currentState?.overlay?.context;
      if (current != null) {
        showImmediateDialog(current, message.data.entries.first.value,
            acceptcall, () => {print("rejected")});
      }

      if (message.notification != null) {
        print("Message also contained a notification: ${message.notification}");
      }
    });

    // placeholder home page
    // I"m not sure what the manager page should look like when there"s no call
    var centerHome = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            pageState.value = PageStates.incomingCall;
          },
          child: Text(
            "Get Call",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () async {
              await managerlogout();
              navigatorKey.currentState?.popUntil((route) => route.isFirst);
              Navigator.push(
                navigatorKey.currentContext!,
                MaterialPageRoute(builder: (_) => ManagerLogin()),
              );
            },
            child: const Text("Logout"),
          ),
        ),
      ],
    );

    var centerIncomingCall = Column(
      children: [
        Padding(
          padding: EdgeInsets.all(
            15 * CenteroTheme.getValues(context).scaleFactor,
          ),
        ),
        Text(
          "Incoming Call",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Padding(
          padding: EdgeInsets.all(
            15 * CenteroTheme.getValues(context).scaleFactor,
          ),
        ),
        Text(
          resident.value.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          resident.value.propertyname,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          "Unit ${resident.value.unit}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          resident.value.address,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Container(
          width: CenteroTheme.getValues(context).logoSize,
          height: CenteroTheme.getValues(context).logoSize,
          margin: EdgeInsets.all(
            10 * CenteroTheme.getValues(context).scaleFactor,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/user.png"),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showLeftPanel.value = true;
            showRightPanel.value = true;
            pageState.value = PageStates.onCall;
          },
          child: Text(
            "Answer",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );

    var centerOnCall = Column(
      children: <Widget>[
        Text(
          resident.value.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(width: 1, color: Colors.black38),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8 * CenteroTheme.getValues(context).scaleFactor,
                ),
              ),
            ),
            padding: EdgeInsets.all(
              15 * CenteroTheme.getValues(context).scaleFactor,
            ),
            child: Center(
              child: Text(
                "Video",
                style: CenteroTheme.getTheme(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: () {
              showLeftPanel.value = false;
              showRightPanel.value = false;
              pageState.value = PageStates.home;
            },
            child: Text(
              "End Call",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );

    // #########################################################################
    // The actual page
    // #########################################################################
    return Scaffold(
      bottomSheet: const Footer(),
      appBar: AppBar(
        title: const Text("Centero Property Administration"),
        leading: Container(
          width: 0.4 * CenteroTheme.getValues(context).logoSize,
          height: 0.4 * CenteroTheme.getValues(context).logoSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/centeroBrand.jpg"),
            ),
          ),
        ),
        actions: <Widget>[
          if (manager is Manager)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                    ),
                child: Row(
                  children: <Widget>[
                    Text(manager!.name),
                    const Icon(Icons.person),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: Container(
        margin:
            EdgeInsets.all(10 * CenteroTheme.getValues(context).scaleFactor),
        padding:
            EdgeInsets.only(bottom: CenteroTheme.getValues(context).footerSize),
        child: Row(
          children: <Widget>[
            // left panel
            if (pageState.value == PageStates.onCall)
              (showLeftPanel.value)
                  ? Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(
                              10 * CenteroTheme.getValues(context).scaleFactor,
                            ),
                            child: TextButton(
                              onPressed: () {
                                showLeftPanel.value = false;
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_left_rounded,
                                    size: 40 *
                                        CenteroTheme.getValues(context)
                                            .scaleFactor,
                                  ),
                                  Text(
                                    "Hide",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.all(
                                      width: 1, color: Colors.black38),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8 *
                                          CenteroTheme.getValues(context)
                                              .scaleFactor,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(
                                  15 *
                                      CenteroTheme.getValues(context)
                                          .scaleFactor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Google Map",
                                    style: CenteroTheme.getTheme(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              20 * CenteroTheme.getValues(context).scaleFactor,
                            ),
                            child: Text(
                              resident.value.address,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.all(
                                      width: 1, color: Colors.black38),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8 *
                                          CenteroTheme.getValues(context)
                                              .scaleFactor,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(
                                  15 *
                                      CenteroTheme.getValues(context)
                                          .scaleFactor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Floor Plan",
                                    style: CenteroTheme.getTheme(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              20 * CenteroTheme.getValues(context).scaleFactor,
                            ),
                            child: Text(
                              "Unit ${resident.value.unit}",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_right_rounded,
                          size:
                              40 * CenteroTheme.getValues(context).scaleFactor,
                        ),
                        onPressed: () {
                          showLeftPanel.value = true;
                        },
                      ),
                    ),
            // #################################################################
            // center panel
            // #################################################################
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: (pageState.value == PageStates.home)
                        ? centerHome
                        : (pageState.value == PageStates.incomingCall)
                            ? centerIncomingCall
                            : centerOnCall,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (pageState.value == PageStates.onCall)
                        Text(
                          "Last Call: ${dateformat.format(resident.value.lastCall)}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // #################################################################
            // right panel
            // #################################################################
            if (pageState.value == PageStates.onCall)
              (showRightPanel.value)
                  ? Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(
                              10 * CenteroTheme.getValues(context).scaleFactor,
                            ),
                            child: TextButton(
                              onPressed: () {
                                showRightPanel.value = false;
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Hide",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Icon(
                                    Icons.arrow_right_rounded,
                                    size: 40 *
                                        CenteroTheme.getValues(context)
                                            .scaleFactor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.all(
                                      width: 1, color: Colors.black38),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8 *
                                          CenteroTheme.getValues(context)
                                              .scaleFactor,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(
                                  15 *
                                      CenteroTheme.getValues(context)
                                          .scaleFactor,
                                ),
                                margin: EdgeInsets.only(
                                  right: 20 *
                                      CenteroTheme.getValues(context)
                                          .scaleFactor,
                                  left: 20 *
                                      CenteroTheme.getValues(context)
                                          .scaleFactor,
                                  bottom: 20 *
                                      CenteroTheme.getValues(context)
                                          .scaleFactor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        "Profile",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    Text(
                                      "Monthly Rent",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text("\$${resident.value.monthlyRent}"),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "Rent Status",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text(getStatus(resident.value.rentDueDate)),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "Lease Expires",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text(dateformat
                                        .format(resident.value.leaseend)),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "Deposit",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text("\$${resident.value.deposit}"),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "Pet Rent",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text("\$${resident.value.petRent}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_left_rounded,
                          size:
                              40 * CenteroTheme.getValues(context).scaleFactor,
                        ),
                        onPressed: () {
                          showRightPanel.value = true;
                        },
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
