// ignore_for_file: unused_import

import "package:localstorage/localstorage.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as developer;
import "package:provider/provider.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "package:centero/main.dart";

///
/// Used by Manager Frontend
/// a eventhandler for when manager rejects the call
Future<void> rejectCall(String residentID) async {
  // TODO
  return;
}
