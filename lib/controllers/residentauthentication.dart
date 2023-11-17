import 'package:centero/controllers/getdevicetoken.dart';
import 'package:centero/serializers/residentserialzer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:centero/models/loginresponse.dart';
import 'package:localstorage/localstorage.dart';

Future<LoginResponse> residentlogin(
    String propertyname, int unit_number, String social) async {
  //fetch device token
  String device_token = "";
  try {
    device_token = await getdevicetoken();
  } catch (e) {
    print("failed to fetch device token");
    print(e);
    return LoginResponse.devicetokenfailed;
  }
  print(device_token);
  String data =
      residentserializer(propertyname, unit_number, social, device_token);

  // get custom token
  http.Response response;
  String token = "";
  try {
    response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5001/centero-191ae/us-central1/clientsignin'),
        body: data,
        headers: <String, String>{'Content-Type': 'application/json'});
    String body = response.body;
    print("response body $body");
    Map<String, dynamic> decodedData = jsonDecode(response.body);
    if (response.body == "invalid credential") {
      return LoginResponse.customtokenfailedtogenerate;
    }
    token = decodedData['token'];
    print('Token: $token');
  } catch (e) {
    print("failed to get custom token");

    print(e);
    return LoginResponse.customtokenfailedtogenerate;
  }
  //sign in with custom token

  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithCustomToken(token);
    print('user:$userCredential');
  } catch (e) {
    print("failed to sign in with token");
    return LoginResponse.sigininfailed;
  }
  return LoginResponse.success;
}

Future<void> residentlogout() async {
  //delete device token in database
  final LocalStorage storage = new LocalStorage('centero');
  String device_token = storage.getItem("device_token");
  http.Response response;
  String? access_token =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  try {
    response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5001/centero-191ae/us-central1/OnResidentLogOut'),
        body: jsonEncode({"device_token": device_token}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $access_token'
        });
    print(response.body);
  } catch (e) {
    print(e);
    throw Exception("request failed");
  }

  //signout
  await FirebaseAuth.instance.signOut();
}
