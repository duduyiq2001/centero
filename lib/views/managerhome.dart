import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:centero/themes.dart";
import "package:centero/views/footer.dart";

class ManagerHome extends HookWidget {
  const ManagerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const Footer(),
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(5 * CenteroTheme.getValues(context).scaleFactor),
      ),
    );
  }
}
