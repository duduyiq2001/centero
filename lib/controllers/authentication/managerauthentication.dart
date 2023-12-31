import "package:centero/main.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:localstorage/localstorage.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import "package:provider/provider.dart";
import "package:centero/models/loginresponse.dart";
import "package:centero/models/manager.dart";
import "package:centero/utility/getdevicetoken.dart";
import "package:centero/utility/registerdevicetoken.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "package:centero/utility/urlmanager.dart";

///
/// Sign in manager with
/// [email]
/// [password]
/// register manager device token with[registerdevicetoken]
/// Returns [LoginResponse] for granularity of login response.
/// control left click on those things for more details.
Future<LoginResponse> managerlogin(
  String email,
  String password,
) async {
  UserCredential? credential;
  try {
    // ignore: unused_local_variable
    credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print("No user found for that email.");
      return LoginResponse.signInFailed;
    } else if (e.code == "wrong-password") {
      print("Wrong password provided for that user.");
      return LoginResponse.signInFailed;
    }
  }
  String? id = credential?.user?.uid;
  String deviceToken = "";
  try {
    deviceToken = await getdevicetoken();
  } catch (e) {
    print(e);
    return LoginResponse.deviceTokenFailed;
  }

  try {
    await registerdevicetoken(deviceToken);
  } catch (e) {
    print(e);
    return LoginResponse.signInFailed;
  }

  return LoginResponse.success;
}

///
/// Sign out manager
/// delete device token on server side
/// control left click on those things for more details.
Future<void> managerlogout() async {
  //delete device token in database
  final LocalStorage storage = LocalStorage("centero");
  String deviceToken = storage.getItem("deviceToken");
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  try {
    http.Client client = Provider.of<ConnectionService>(
            navigatorKey.currentContext!,
            listen: false)
        .returnConnection();
    http.Response _ = await client.post(
        Uri.parse(getfunctionname("OnManagerLogout")),
        body: jsonEncode({"deviceToken": deviceToken}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    // print(response.body);
  } catch (e) {
    // print(e);
    throw Exception("request failed");
  }

  //signout
  await FirebaseAuth.instance.signOut();
}
