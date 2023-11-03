// ignore_for_file: library_private_types_in_public_api, avoid_print

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:centero/themes.dart";
import "package:centero/models/footer.dart";
import "page1.dart";
import "page2.dart";

class Page3 extends HookWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    final rated = useState(false);

    return Scaffold(
      bottomSheet: const Footer(),
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
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
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => const Page2(),
                  ),
                  (route) => false,
                );
              },
              child: const Text("Call Again"),
            ),
            Padding(
                padding: EdgeInsets.all(
                    10 * CenteroTheme.getValues(context).scaleFactor)),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => const Page1(),
                  ),
                  (route) => false,
                );
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
                            padding: EdgeInsets.all(20 *
                                CenteroTheme.getValues(context).scaleFactor),
                            shape: const CircleBorder(),
                            backgroundColor: Colors.red,
                          ),
                          child: null,
                        ),
                        Padding(
                            padding: EdgeInsets.all(5 *
                                CenteroTheme.getValues(context).scaleFactor)),
                        ElevatedButton(
                          onPressed: () {
                            rated.value = true;
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20 *
                                CenteroTheme.getValues(context).scaleFactor),
                            shape: const CircleBorder(),
                            backgroundColor: Colors.orange,
                          ),
                          child: null,
                        ),
                        Padding(
                            padding: EdgeInsets.all(5 *
                                CenteroTheme.getValues(context).scaleFactor)),
                        ElevatedButton(
                          onPressed: () {
                            rated.value = true;
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20 *
                                CenteroTheme.getValues(context).scaleFactor),
                            shape: const CircleBorder(),
                            backgroundColor: Colors.yellow,
                          ),
                          child: null,
                        ),
                        Padding(
                            padding: EdgeInsets.all(5 *
                                CenteroTheme.getValues(context).scaleFactor)),
                        ElevatedButton(
                          onPressed: () {
                            rated.value = true;
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20 *
                                CenteroTheme.getValues(context).scaleFactor),
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
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
