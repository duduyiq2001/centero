// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:centero/themes.dart";
import "package:centero/views/footer.dart";

class ManagerHome extends HookWidget {
  const ManagerHome({super.key});

  @override
  Widget build(BuildContext context) {
    var showLeftPanel = useState(true);
    var showRightPanel = useState(true);

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
            EdgeInsets.all(10 * CenteroTheme.getValues(context).scaleFactor),
        padding:
            EdgeInsets.only(bottom: CenteroTheme.getValues(context).footerSize),
        child: Row(
          children: <Widget>[
            // left panel
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
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                                border:
                                    Border.all(width: 1, color: Colors.black38),
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
                                    CenteroTheme.getValues(context).scaleFactor,
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
                            "1409 Cherry Lane, Los Angeles, CA 90277",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                border:
                                    Border.all(width: 1, color: Colors.black38),
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
                                    CenteroTheme.getValues(context).scaleFactor,
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
                            "Unit 2051A\n2BR 1BA \"Colonial\"",
                            style: Theme.of(context).textTheme.bodyLarge,
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
                        size: 40 * CenteroTheme.getValues(context).scaleFactor,
                      ),
                      onPressed: () {
                        showLeftPanel.value = true;
                      },
                    ),
                  ),
            // center panel
            Expanded(
              flex: 5,
              child: Container(),
            ),
            // right panel
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
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                                border:
                                    Border.all(width: 1, color: Colors.black38),
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
                                    CenteroTheme.getValues(context).scaleFactor,
                              ),
                              margin: EdgeInsets.only(
                                right: 20 *
                                    CenteroTheme.getValues(context).scaleFactor,
                                left: 20 *
                                    CenteroTheme.getValues(context).scaleFactor,
                                bottom: 20 *
                                    CenteroTheme.getValues(context).scaleFactor,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Profile",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
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
                        size: 40 * CenteroTheme.getValues(context).scaleFactor,
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
