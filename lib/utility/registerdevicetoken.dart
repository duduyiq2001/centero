import "package:centero/main.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as developer;
import "package:provider/provider.dart";
import "package:centero/controllers/http/connectionservice.dart";

///
/// Used by the manager side
/// Do Not call this method driectly
Future<void> registerdevicetoken(String deviceToken) async {
  http.Response response;
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  if (accessToken == null) {
    throw Exception("not signed in");
  }
  try {
    developer.log("register called");
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    response = await client.post(
        Uri.parse(
            "http://127.0.0.1:5001/centero-191ae/us-central1/OnManagerLogin"),
        body: jsonEncode({"device_token": deviceToken}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    developer.log(response.body);
  } catch (e) {
    developer.log(e.toString());
    throw Exception("request failed");
  }
}
