import "package:firebase_messaging/firebase_messaging.dart";
import "package:localstorage/localstorage.dart";
import "dart:developer" as developer;

///
/// Get device token from firebase messaging service
/// token might refresh
Future<String> getdevicetoken() async {
//request permission
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    developer.log("User granted permission");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    developer.log("User granted provisional permission");
  } else {
    developer.log("User declined or has not accepted permission");
    return "declined";
  }
  // Get the token each time the application loads
  String? token = await FirebaseMessaging.instance.getToken();

  if (token == null) {
    return "token null";
  }
  final LocalStorage storage = LocalStorage("centero");
  storage.setItem("device_token", token);
  // Save the initial token to the database

  return token;

  // Any time the token refreshes, store this in the database too.
  //FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
}
