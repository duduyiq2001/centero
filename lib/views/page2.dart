// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:centero/themes.dart";
import "package:centero/models/footer.dart";
import "page3.dart";

class Page2 extends HookWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const Footer(),
      body: Center(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Page3()),
                      );
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
      ),
    );
  }
}
