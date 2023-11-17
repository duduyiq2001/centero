import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:centero/models/loginresponse.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> registerdevicetoken(String device_token) async {
  http.Response response;
  String? access_token =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  if (access_token == null) {
    throw Exception("not signed in");
  }
  try {
    response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5001/centero-191ae/us-central1/OnManagerLogin'),
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
}
