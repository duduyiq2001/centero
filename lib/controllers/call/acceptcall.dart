// ignore_for_file: avoid_print

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
  final LocalStorage storage = LocalStorage('centero');
  String deviceToken = storage.getItem("device_token");
  //get access token
  String? accessToken =
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
  http.Response response;
  // ignore: unused_local_variable
  String managername = "";
  try {
    response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5001/centero-191ae/us-central1/onAcceptCall'),
        body: jsonEncode({"device_token": deviceToken}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    print(response.body);
  } catch (e) {
    print(e);
    return false;
  }
  return true;
}
