// ignore_for_file: avoid_print

import "package:centero/utility/getdevicetoken.dart";
import "package:centero/serializers/residentserialzer.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:centero/models/loginresponse.dart";
import "package:localstorage/localstorage.dart";
import "package:centero/models/resident.dart";

///
/// Sign in resident with
/// [propertyname]
/// [unitNumber]
/// [social]
/// Returns [LoginResponse] for granularity of login response.
/// control left click on those things for more details.
Future<(LoginResponse, Resident?)> residentlogin(
    String propertyname, String unitNumber, String social) async {
  //fetch device token
  String deviceToken = "";
  try {
    deviceToken = await getdevicetoken();
  } catch (e) {
    return (LoginResponse.deviceTokenFailed, null);
  }
  // print(deviceToken);
  String data =
      residentserializer(propertyname, unitNumber, social, deviceToken);

  // get custom token
  http.Response response;
  Resident? r;
  String token = "";
  Map<String, dynamic> decodedData;
  try {
    response = await http.post(
      Uri.parse("http://127.0.0.1:5001/centero-191ae/us-central1/clientsignin"),
      body: data,
      headers: <String, String>{"Content-Type": "application/json"},
    );
    if (response.statusCode == 403) {
      return (LoginResponse.signInFailed, null);
    }
    decodedData = jsonDecode(response.body);
    token = decodedData["token"];
  } catch (e) {
    return (LoginResponse.customTokenFailedToGenerate, null);
  }

  try {
    int id = decodedData["id"];
    r = dummyResidents.firstWhere((element) => element.id == id);
  } catch (e) {
    r = null;
  }

  try {
    // ignore: unused_local_variable
    final userCredential =
        await FirebaseAuth.instance.signInWithCustomToken(token);
    // print("user:${userCredential}");
  } catch (e) {
    return (LoginResponse.signInFailed, null);
  }
  return (LoginResponse.success, r);
}

///
/// Sign out resident
///
Future<void> residentlogout() async {
  //delete device token in database
  final LocalStorage storage = LocalStorage("centero");
  String deviceToken = storage.getItem("device_token");
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  try {
    http.Response _ = await http.post(
        Uri.parse(
            "http://127.0.0.1:5001/centero-191ae/us-central1/OnResidentLogOut"),
        body: jsonEncode({"device_token": deviceToken}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
  } catch (e) {
    throw Exception("request failed");
  }

  //signout
  await FirebaseAuth.instance.signOut();
}
