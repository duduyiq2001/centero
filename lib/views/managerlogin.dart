// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:centero/themes.dart";
import "package:centero/views/managerhome.dart";
import "package:centero/controllers/authentication/managerauthentication.dart";
import "package:centero/models/loginresponse.dart";

class ManagerLogin extends HookWidget {
  ManagerLogin({super.key});

  final TextEditingController emailct = TextEditingController();
  final TextEditingController passwordct = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager login Page"),
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 60.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: emailct,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Manager Email",
                hintText: "Enter Valid Manager Email",
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
              controller: passwordct,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                hintText: "Enter Password",
              ),
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
              var (response, manager) =
                  await managerlogin(emailct.text, passwordct.text);
              if (response == LoginResponse.success) {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => ManagerHome(
                      manager: manager,
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
                if (response == LoginResponse.signInFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("invalid credential!"),
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
