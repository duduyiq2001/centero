// ignore_for_file: unused_import

import "package:localstorage/localstorage.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as developer;
import "package:centero/controllers/http/connectionservice.dart";
import "package:centero/main.dart";
import "package:provider/provider.dart";

///
/// Used by Manager Frontend
/// a eventhandler for when manager rejects the call
Future<void> cancellCallFromClient() async {
  final LocalStorage storage = new LocalStorage('centero');
  String device_token = storage.getItem("device_token");
  http.Response response;
  String? access_token =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  try {
    print("calling");
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    response = await client.post(
        Uri.parse(
            "http://127.0.0.1:5001/centero-191ae/us-central1/onCancelCall"),
        body: jsonEncode({
          "device_token": device_token,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $access_token"
        });
    if (response.statusCode != 200) {
      developer.log("ERROR: ${response.body}");
      throw Exception("request failed");
    }
    return;
  } catch (e) {
    print(e);
    throw Exception("request failed");
  }
}
