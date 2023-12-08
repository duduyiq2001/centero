import "dart:convert";
import "dart:developer" as developer;
import "package:centero/models/resident.dart";

///serialize the resident data for authentication
String residentserializer(
    String propertyname, String unitNumber, String social, String deviceToken) {
  return jsonEncode({
    "property_name": propertyname,
    "unit_number": unitNumber,
    "social": social,
    "device_token": deviceToken
  });
}

Resident? residentFromData(Map<String, dynamic> data) {
  try {
    return Resident(
      name: data["name"],
      unit: data["unit"],
      id: data["uid"],
      propertyname: data["property_name"],
    );
  } catch (e) {
    developer.log(e.toString());
    return null;
  }
}
