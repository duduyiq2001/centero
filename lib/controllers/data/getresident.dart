import "dart:convert";
import "package:localstorage/localstorage.dart";
import "package:provider/provider.dart";
import "package:http/http.dart" as http;
import "package:centero/main.dart";
import "package:centero/models/resident.dart";
import "package:centero/controllers/http/connectionservice.dart";
import "package:centero/serializers/residentserialzer.dart";
import "package:centero/utility/urlmanager.dart";

Future<Resident?> getResidentData() async {
  final LocalStorage storage = LocalStorage("centero");
  String uid = storage.getItem("uid");

  String data = jsonEncode({"uid": uid});
  http.Response response;

  http.Client client = Provider.of<ConnectionService>(
    navigatorKey.currentContext!,
    listen: false,
  ).returnConnection();
  response = await client.post(
    Uri.parse(getfunctionname("getResident")),
    body: data,
    headers: <String, String>{"Content-Type": "application/json"},
  );

  if (response.statusCode != 200) {
    return null;
  }

  Map<String, dynamic> residentData = jsonDecode(response.body);

  return residentFromData(residentData);
}
