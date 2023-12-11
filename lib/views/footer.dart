import "package:flutter/material.dart";
import "package:centero/themes.dart";

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black12,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.black12,
      ),
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
            width: 1 * CenteroTheme.getValues(context).logoSize,
            height: .4 * CenteroTheme.getValues(context).logoSize,
            decoration: const BoxDecoration(
              //shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/centeroLogo.jpg"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 25 * CenteroTheme.getValues(context).scaleFactor,
              top: 0.5 * CenteroTheme.getValues(context).logoSize,
            ),
          ),
        ],
      ),
    );
  }
}
