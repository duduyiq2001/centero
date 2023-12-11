import "package:centero/main.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";

import "package:provider/provider.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "package:localstorage/localstorage.dart";
import "package:centero/utility/urlmanager.dart";

///
/// Used by client fronend
/// Initiates a call from client
/// Returns [true, managername] if succeds
/// control left click on those things for more details.
Future<(bool, String)> initiatecall() async {
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  http.Response response;
  String managername = "";
  final LocalStorage storage = LocalStorage("centero");
  String deviceToken = storage.getItem("deviceToken");
  String? rejectedmanager = storage.getItem("rejectedmanager");
  try {
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    if (rejectedmanager != null) {
      response = await client.post(Uri.parse(getfunctionname("onRequestCall")),
          body: jsonEncode(
              {"deviceToken": deviceToken, "rejected": rejectedmanager}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken"
          });
    } else {
      response = await client.post(Uri.parse(getfunctionname("onRequestCall")),
          body: jsonEncode({"deviceToken": deviceToken}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken"
          });
    }
    if (response.statusCode != 200) {
      print("ERROR: ${response.body}");
      return (false, response.body);
    }
    managername = response.body;
  } catch (e) {
    print(e.toString());
    return (false, e.toString());
  }
  return (true, managername);
}
