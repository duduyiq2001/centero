import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:centero/views/clienthome.dart";
import "package:centero/views/managerhome.dart";
import "package:flutter_hooks/flutter_hooks.dart";
// import "package:centero/views/login.dart";
import "firebase_options.dart";
import "themes.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class Users {
  static const none = 0;
  static const tenant = 1;
  static const manager = 2;
  static const admin = 3;
}

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
      title: "Centero",
      theme: CenteroTheme.getTheme(context),
      debugShowCheckedModeBanner: false,
      home: (interface.value == Users.none)
          ? userSelect
          : (interface.value == Users.tenant)
              ? const ClientHome()
              : (interface.value == Users.manager)
                  ? const ManagerHome()
                  : Container(),
    );
  }
}
