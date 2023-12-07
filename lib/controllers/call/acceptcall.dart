import "package:localstorage/localstorage.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as developer;
import "package:provider/provider.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "package:centero/main.dart";

///
/// Used by Manager Frontend
/// a eventhandler for when manager accepts the call
/// return true if succeed
Future<bool> acceptcall(String residentID) async {
  final LocalStorage storage = LocalStorage("centero");
  String deviceToken = storage.getItem("device_token");
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  http.Response response;
  try {
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    response = await client.post(
        Uri.parse(
            "http://127.0.0.1:5001/centero-191ae/us-central1/onAcceptCall"),
        body: jsonEncode({
          "device_token": deviceToken,
          "residentID": residentID,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    developer.log(response.body);
  } catch (e) {
    developer.log(e.toString());
    return false;
  }
  return true;
}
