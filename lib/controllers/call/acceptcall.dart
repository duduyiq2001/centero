import "package:localstorage/localstorage.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as developer;
import "package:provider/provider.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "package:centero/main.dart";
import "package:centero/utility/urlmanager.dart";

///
/// Used by Manager Frontend
/// a eventhandler for when manager accepts the call
/// return true if succeed
Future<bool> acceptcall(String residentID) async {
  final LocalStorage storage = LocalStorage("centero");
  String deviceToken = storage.getItem("deviceToken");
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  http.Response response;
  try {
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    response = await client.post(Uri.parse(getfunctionname("onAcceptCall")),
        body: jsonEncode({
          "deviceToken": deviceToken,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    developer.log(response.body);
    if (response.statusCode != 200) {
      developer.log("ERROR: ${response.body}");
      return false;
    }
  } catch (e) {
    developer.log(e.toString());
    return false;
  }
  return true;
}
