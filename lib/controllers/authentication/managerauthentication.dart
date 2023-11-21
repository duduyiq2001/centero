import 'package:centero/models/loginresponse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:centero/utility/getdevicetoken.dart';
import 'package:centero/utility/registerdevicetoken.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

Future<LoginResponse> managerlogin(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return LoginResponse.sigininfailed;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return LoginResponse.sigininfailed;
    }
  }
  String device_token = "";
  try {
    device_token = await getdevicetoken();
  } catch (e) {
    print("failed to fetch device token");
    print(e);
    return LoginResponse.devicetokenfailed;
  }

  try {
    await registerdevicetoken(device_token);
  } catch (e) {
    print(e);
    return LoginResponse.sigininfailed;
  }
  return LoginResponse.success;
}

Future<void> managerlogout() async {
  //delete device token in database
  final LocalStorage storage = new LocalStorage('centero');
  String device_token = storage.getItem("device_token");
  http.Response response;
  String? access_token =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  try {
    response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5001/centero-191ae/us-central1/OnManagerLogout'),
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
