// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:centero/themes.dart";
import "package:centero/views/footer.dart";
import 'package:centero/controllers/authentication/managerauthentication.dart';
import "package:centero/views/managerlogin.dart";
import "package:centero/main.dart";

class ManagerHome extends HookWidget {
  const ManagerHome({super.key});

  @override
  Widget build(BuildContext context) {
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
          actions: const <Widget>[],
        ),
        body: Container(
          margin:
              EdgeInsets.all(5 * CenteroTheme.getValues(context).scaleFactor),
          padding: EdgeInsets.only(
              bottom: CenteroTheme.getValues(context).footerSize),
          child: Row(
            children: <Widget>[
              // tenant info section on the left
              Expanded(
                flex: 7,
                child: Column(),
              ),
              // incoming call info section on the right
              Expanded(
                flex: 3,
                child: Container(
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
                    children: <Widget>[
                      Text(
                        "Call Information",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await managerlogout();
                    navigatorKey.currentState
                        ?.popUntil((route) => route.isFirst);
                    Navigator.push(
                      navigatorKey.currentContext!,
                      MaterialPageRoute(builder: (_) => const ManagerLogin()),
                    );
                  },
                  child: const Text("Logout"))
            ],
          ),
        ));
  }
}
