///
/// Used by Manager Frontend
/// a eventhandler for when manager rejects the call
///
import "package:centero/main.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as developer;
import "package:provider/provider.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "package:localstorage/localstorage.dart";

///
Future<void> rejectcall() async {
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  http.Response response;
  final LocalStorage storage = LocalStorage("centero");
  String deviceToken = storage.getItem("device_token");
  print("rejecting client");
  try {
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();

    response = await client.post(
        Uri.parse(
            "http://127.0.0.1:5001/centero-191ae/us-central1/onRejectCall"),
        body: jsonEncode({"device_token": deviceToken}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

    if (response.statusCode != 200) {
      print("ERROR: ${response.body}");
      return;
    }
  } catch (e) {
    print(e.toString());
    return;
  }
}
