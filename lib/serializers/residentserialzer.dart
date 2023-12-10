import "dart:convert";
import "dart:developer" as developer;
import "package:centero/models/resident.dart";

///serialize the resident data for authentication
String residentserializer(
    String propertyname, String unitNumber, String social, String deviceToken) {
  return jsonEncode({
    "propertyName": propertyname,
    "unitNumber": unitNumber,
    "social": social,
    "deviceToken": deviceToken
  });
}

Resident? residentFromData(Map<String, dynamic> data) {
  try {
    return Resident(
      name: data["name"],
      unit: data["unit"],
      id: data["uid"],
      propertyname: data["propertyName"],
    );
  } catch (e) {
    developer.log(e.toString());
    return null;
  }
}
