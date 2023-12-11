// ignore_for_file: unused_import

import "package:localstorage/localstorage.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";

import "package:centero/controllers/http/connectionservice.dart";
import "package:centero/main.dart";
import "package:provider/provider.dart";
import "package:centero/utility/urlmanager.dart";

///
/// Used by Manager Frontend
/// a eventhandler for when manager rejects the call
Future<void> cancellCallFromClient() async {
  final LocalStorage storage = new LocalStorage('centero');
  String deviceToken = storage.getItem("deviceToken");
  http.Response response;
  String? access_token =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  try {
    print("calling");
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    response = await client.post(Uri.parse(getfunctionname("onCancelCall")),
        body: jsonEncode({
          "deviceToken": deviceToken,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $access_token"
        });
    if (response.statusCode != 200) {
      print("ERROR: ${response.body}");
      throw Exception("request failed");
    }
    return;
  } catch (e) {
    print(e);
    throw Exception("request failed");
  }
}
