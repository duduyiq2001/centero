// ignore_for_file: unused_import

import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:universal_html/html.dart" as html;
import "package:flutter_hooks/flutter_hooks.dart";
import "package:provider/provider.dart";
import "package:centero/views/clienthome.dart";
import "package:centero/views/managerhome.dart";
import "package:centero/views/residentlogin.dart";
import "package:centero/views/managerlogin.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "firebase_options.dart";
import "themes.dart";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String mode = String.fromEnvironment("mode");

  if (mode == "dev") {
    await Firebase.initializeApp(
      options: web,
    );
    try {
      await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  } else {
    await Firebase.initializeApp(
      options: web,
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConnectionService()),
      ],
      child: const MyApp(),
    ),
  );
}

enum Users {
  none,
  tenant,
  manager,
  admin,
}
//use enum instead

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var interface = useState(Users.none);

    var userSelect = Container(
      margin: EdgeInsets.all(5 * CenteroTheme.getValues(context).scaleFactor),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  CenteroTheme.getValues(context).borderRadius),
              child: Image.asset(
                "assets/centeroLogo.jpg",
                width: 2 * CenteroTheme.getValues(context).logoSize,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                20 * CenteroTheme.getValues(context).scaleFactor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(width: 1, color: Colors.black38),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                      8 * CenteroTheme.getValues(context).scaleFactor),
                ),
              ),
              padding: EdgeInsets.all(
                15 * CenteroTheme.getValues(context).scaleFactor,
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      interface.value = Users.tenant;
                    },
                    child: const Text("Tenant"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        10 * CenteroTheme.getValues(context).scaleFactor),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      interface.value = Users.manager;
                    },
                    child: const Text("Manager"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: "Centero",
      theme: CenteroTheme.getTheme(context),
      debugShowCheckedModeBanner: false,
      home: (interface.value == Users.none)
          ? userSelect
          : (interface.value == Users.tenant)
              ? ResidentLogin()
              // ? const ClientHome()
              : (interface.value == Users.manager)
                  ? ManagerLogin()
                  : Container(),
    );
  }
}
