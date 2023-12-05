import "package:centero/main.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:localstorage/localstorage.dart";
import "package:provider/provider.dart";
import "package:centero/models/loginresponse.dart";
import "package:centero/utility/getdevicetoken.dart";
import "package:centero/serializers/residentserialzer.dart";
import "package:centero/controllers/http/connectionservice.dart";

///
/// Sign in resident with
/// [propertyname]
/// [unitNumber]
/// [social]
/// Returns [LoginResponse] for granularity of login response.
/// control left click on those things for more details.
Future<LoginResponse> residentlogin(
  String propertyname,
  String unitNumber,
  String social,
) async {
  //fetch device token
  String deviceToken = "";
  try {
    deviceToken = await getdevicetoken();
  } catch (e) {
    return LoginResponse.deviceTokenFailed;
  }
  // print(deviceToken);
  String data =
      residentserializer(propertyname, unitNumber, social, deviceToken);

  // get custom token
  http.Response response;
  String id;
  String token = "";
  Map<String, dynamic> decodedData;

  try {
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    response = await client.post(
      Uri.parse("http://127.0.0.1:5001/centero-191ae/us-central1/clientsignin"),
      body: data,
      headers: <String, String>{"Content-Type": "application/json"},
    );
    if (response.statusCode == 403) {
      return LoginResponse.signInFailed;
    }
    decodedData = jsonDecode(response.body);
    token = decodedData["token"];
    id = decodedData["id"];
  } catch (e) {
    return LoginResponse.customTokenFailedToGenerate;
  }

  try {
    // ignore: unused_local_variable
    final userCredential =
        await FirebaseAuth.instance.signInWithCustomToken(token);
    // print("user:${userCredential}");
  } catch (e) {
    return LoginResponse.signInFailed;
  }

  final LocalStorage storage = LocalStorage("centero");
  storage.setItem("uid", id);

  return LoginResponse.success;
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
    http.Client client = Provider.of<ConnectionService>(
      navigatorKey.currentContext!,
      listen: false,
    ).returnConnection();
    http.Response _ = await client.post(
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
