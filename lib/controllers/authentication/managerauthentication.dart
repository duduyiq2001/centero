// ignore_for_file: avoid_print

import "package:firebase_auth/firebase_auth.dart";
import "package:localstorage/localstorage.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:centero/models/loginresponse.dart";
import "package:centero/models/manager.dart";
import "package:centero/utility/getdevicetoken.dart";
import "package:centero/utility/registerdevicetoken.dart";

///
/// Sign in manager with
/// [email]
/// [password]
/// register manager device token with[registerdevicetoken]
/// Returns [LoginResponse] for granularity of login response.
/// control left click on those things for more details.
Future<(LoginResponse, Manager?)> managerlogin(
    String email, String password) async {
  UserCredential? credential;
  try {
    // ignore: unused_local_variable
    credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print("No user found for that email.");
      return (LoginResponse.signInFailed, null);
    } else if (e.code == "wrong-password") {
      print("Wrong password provided for that user.");
      return (LoginResponse.signInFailed, null);
    }
  }
  String? id = credential?.user?.uid;
  String deviceToken = "";
  try {
    deviceToken = await getdevicetoken();
  } catch (e) {
    return (LoginResponse.deviceTokenFailed, null);
  }

  try {
    await registerdevicetoken(deviceToken);
  } catch (e) {
    return (LoginResponse.signInFailed, null);
  }

  Manager? manager;
  try {
    manager = dummyManagers.firstWhere((element) => element.id == id);
  } catch (e) {
    manager = null;
  }

  return (LoginResponse.success, manager);
}

///
/// Sign out manager
/// delete device token on server side
/// control left click on those things for more details.
Future<void> managerlogout() async {
  //delete device token in database
  final LocalStorage storage = LocalStorage("centero");
  String deviceToken = storage.getItem("device_token");
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  try {
    http.Response _ = await http.post(
        Uri.parse(
            "http://127.0.0.1:5001/centero-191ae/us-central1/OnManagerLogout"),
        body: jsonEncode({"device_token": deviceToken}),
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
