import "package:flutter/material.dart";

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Text("Powered By"),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              "centeroBrand.jpg",
              width: 40.0,
            ),
          ),
          const Padding(padding: EdgeInsets.all(25.0)),
        ],
      ),
    );
  }
}
