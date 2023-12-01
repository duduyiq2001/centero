// ignore_for_file: avoid_print

import "package:flutter/material.dart";

void showImmediateDialog(BuildContext context, String message,
    Function acceptcallback, Function rejectcallback) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button to dismiss.
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Would you like to accept this call?"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Accept"),
            onPressed: () async {
              print("Accepted");
              Navigator.of(context).pop(); // Dismiss the dialog
              await acceptcallback();
            },
          ),
          TextButton(
            child: const Text("reject"),
            onPressed: () async {
              print("Rejected");
              Navigator.of(context).pop();
              await rejectcallback();
              // Dismiss the dialog
            },
          ),
        ],
      );
    },
  );
}
