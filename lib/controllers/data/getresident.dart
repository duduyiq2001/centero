import "dart:convert";
import "package:localstorage/localstorage.dart";
import "package:provider/provider.dart";
import "package:http/http.dart" as http;
import "package:centero/main.dart";
import "package:centero/models/resident.dart";
import "package:centero/controllers/http/connectionservice.dart";

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
    Uri.parse("http://127.0.0.1:5001/centero-191ae/us-central1/getResident"),
    body: data,
    headers: <String, String>{"Content-Type": "application/json"},
  );

  if (response.statusCode != 200) {
    return null;
  }

  Map<String, dynamic> residentData = jsonDecode(response.body);

  try {
    return Resident(
      username: residentData["username"],
      password: residentData["password"],
      name: residentData["name"],
      unit: residentData["unit"],
      id: residentData["id"],
      propertyname: residentData["propertyName"],
      address: residentData["address"],
      leasestart: residentData["leaseStart"],
      leaseend: residentData["leaseEnd"],
      monthlyRent: residentData["rent"],
      rentDueDate: residentData["rentDueDate"],
      deposit: residentData["deposit"],
      petRent: residentData["petRent"],
      lastCall: residentData["lastCall"],
    );
  } catch (e) {
    print(e);
    return null;
  }
}
