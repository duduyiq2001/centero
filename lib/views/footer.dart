import "package:flutter/material.dart";
import "package:centero/themes.dart";

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Powered By",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
              padding: EdgeInsets.only(
                  right: 10 * CenteroTheme.getValues(context).scaleFactor)),
          Container(
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
          Padding(
              padding: EdgeInsets.only(
            left: 25 * CenteroTheme.getValues(context).scaleFactor,
            top: 0.5 * CenteroTheme.getValues(context).logoSize,
          )),
        ],
      ),
    );
  }
}
