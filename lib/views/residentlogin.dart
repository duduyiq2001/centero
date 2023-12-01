// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:centero/themes.dart";
import "package:centero/views/clienthome.dart";
import "package:centero/controllers/authentication/residentauthentication.dart";
import "package:centero/models/loginresponse.dart";

class ResidentLogin extends HookWidget {
  ResidentLogin({super.key});

  final TextEditingController propertyct = TextEditingController();
  final TextEditingController unitct = TextEditingController();
  final TextEditingController socialct = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Centero Login Page"),
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 60.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: propertyct,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Property Name",
                hintText: "Enter valid centero property name",
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 15,
              bottom: 0,
            ),
            child: TextField(
              controller: unitct,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Unit Number",
                  hintText: "Enter Unit number"),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 15,
              bottom: 0,
            ),
            child: TextField(
              controller: socialct,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Social Security Number",
                  hintText: "Enter social security number"),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              15 * CenteroTheme.getValues(context).scaleFactor,
            ),
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                  ),
              onPressed: () {
                // TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text("Forgot Password"),
            ),
          ),
          ElevatedButton(
            // Login button
            onPressed: () async {
              var (response, resident) = await residentlogin(
                  propertyct.text, unitct.text, socialct.text);
              if (response == LoginResponse.success) {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => ClientHome(
                      resident: resident,
                    ),
                  ),
                  (route) => false,
                );
              } else {
                if (response == LoginResponse.deviceTokenFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("failed to fetch token!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                if (response == LoginResponse.customTokenFailedToGenerate) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("invalid credential!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                if (response == LoginResponse.signInFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Something is wrong, please contact admin!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                minimumSize: const MaterialStatePropertyAll(Size(200, 1))),
            child: Text(
              "Login",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Text("New User? Create Account"),
                Padding(
                  padding: EdgeInsets.only(
                    top: 25 * CenteroTheme.getValues(context).scaleFactor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
