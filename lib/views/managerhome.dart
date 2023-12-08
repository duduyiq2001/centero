import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:intl/intl.dart";
import "dart:convert";
import "dart:developer" as developer;
import "package:firebase_messaging/firebase_messaging.dart";
import "package:centero/themes.dart";
import "package:centero/views/footer.dart";
import "package:centero/models/resident.dart";
import "package:centero/models/manager.dart";
import "package:centero/controllers/authentication/managerauthentication.dart";
import "package:centero/views/managerlogin.dart";
import "package:centero/main.dart";
import "package:centero/controllers/call/acceptcall.dart";
import 'package:centero/controllers/call/rejectcall.dart';
import "package:centero/serializers/residentserialzer.dart";
import "package:centero/views/notification.dart";

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
    var gotResident = useState(false);
    var resident = useState<Resident?>(null);

    var dateformat = DateFormat("yyyy/MM/dd");

    //set up messaging!
    // a listener for messaging from FCM!
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      developer.log("Got a message whilst in the foreground!");
      developer.log("Message data: ${message.data}");
      BuildContext? current = navigatorKey.currentState?.overlay?.context;
      var reason = message.data["reason"];
      print('reason:$reason');
      if (current != null) {
        // showImmediateDialog(
        //   current,
        //   message.data.entries.first.value,
        //   () => {acceptcall(manager!.id), pageState.value = PageS},
        //   () => {developer.log("rejected")},
        // );
        var reason = message.data["reason"];
        print('reason:$reason');
        if (reason == "incoming call") {
          resident.value = residentFromData(jsonDecode(message.data["data"]));
          gotResident.value = resident.value != null;
          pageState.value = PageStates.incomingCall;
        }
        if (reason == "call cancelled") {
          showImmediateNotif(context, "call cancelled by client");
          pageState.value = PageStates.home;
        }
      }

      if (message.notification != null) {
        developer.log(
          "Message also contained a notification: ${message.notification}",
        );
      }
    });

    // placeholder home page
    // I"m not sure what the manager page should look like when there"s no call
    var centerHome = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () async {
              await managerlogout();
              Navigator.pushAndRemoveUntil(
                navigatorKey.currentContext!,
                PageRouteBuilder(
                  pageBuilder: (context, _, __) => ManagerLogin(),
                ),
                (route) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ),
      ],
    );

    var centerIncomingCall = (gotResident.value)
        ? Column(
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
                resident.value!.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                resident.value!.propertyname,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Unit ${resident.value!.unit}",
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
                onPressed: () async {
                  if (await acceptcall(resident.value!.id)) {
                    showLeftPanel.value = true;
                    showRightPanel.value = true;
                    pageState.value = PageStates.onCall;
                  } else {
                    pageState.value = PageStates.home;
                  }
                },
                child: Text(
                  "Answer",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await rejectcall();
                    pageState.value = PageStates.home;
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("rejectcall failed"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(
                  "Decline",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          )
        : const Column();

    var centerOnCall = (gotResident.value)
        ? Column(
            children: <Widget>[
              Text(
                resident.value!.name,
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
                      style: CenteroTheme.getTheme(context)
                          .textTheme
                          .headlineMedium,
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
          )
        : const Column();

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
                              (gotResident.value) ? "irvine" : "",
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
                              (gotResident.value)
                                  ? "Unit ${resident.value!.unit}"
                                  : "",
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
                          (gotResident.value) ? "Last Call: 10pm" : "",
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
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "Rent Status",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "Lease Expires",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "Deposit",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "Pet Rent",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
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
