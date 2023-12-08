import "package:centero/main.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as developer;
import "package:provider/provider.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "package:localstorage/localstorage.dart";

///
/// Used by client fronend
/// Initiates a call from client
/// Returns [true, managername] if succeds
/// control left click on those things for more details.
Future<(bool, String)> initiatecall(String id) async {
  print('id is $id');
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  http.Response response;
  String managername = "";
  final LocalStorage storage = LocalStorage("centero");
  String deviceToken = storage.getItem("device_token");
  try {
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    response = await client.post(
        Uri.parse(
            "http://127.0.0.1:5001/centero-191ae/us-central1/onRequestCall"),
        body: jsonEncode({
          "id": id,
          "device_token": deviceToken,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    if (response.statusCode != 200) {
      developer.log("ERROR: ${response.body}");
      return (false, response.body);
    }
    managername = response.body;
  } catch (e) {
    developer.log(e.toString());
    return (false, e.toString());
  }
  return (true, managername);
}
