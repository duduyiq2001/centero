import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

///
/// Used by Manager Frontend
/// a eventhandler for when manager accepts the call
/// return true if succeed
Future<bool> acceptcall() async {
  //get device tokenimport 'package:firebase_auth/firebase_auth.dart';
  final LocalStorage storage = new LocalStorage('centero');
  String device_token = storage.getItem("device_token");
  //get access token
  String? access_token =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  var response;
  String managername = "";
  try {
    response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5001/centero-191ae/us-central1/onAcceptCall'),
        body: jsonEncode({"device_token": device_token}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $access_token'
        });
    print(response.body);
  } catch (e) {
    print(e);
    return false;
  }
  return true;
}
