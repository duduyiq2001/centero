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
      address: data["address"],
      leasestart: DateTime.fromMillisecondsSinceEpoch(
        data["leaseStart"]["_seconds"] * 1000 +
            data["leaseStart"]["_nanoseconds"] / 1000,
      ),
      leaseend: DateTime.fromMillisecondsSinceEpoch(
        data["leaseEnd"]["_seconds"] * 1000 +
            data["leaseEnd"]["_nanoseconds"] / 1000,
      ),
      monthlyRent: data["rent"],
      rentDueDate: DateTime.fromMillisecondsSinceEpoch(
        data["rentDueDate"]["_seconds"] * 1000 +
            data["rentDueDate"]["_nanoseconds"] / 1000,
      ),
      deposit: data["deposit"],
      petRent: data["petRent"],
      lastCall: DateTime.fromMillisecondsSinceEpoch(
        data["lastCall"]["_seconds"] * 1000 +
            data["lastCall"]["_nanoseconds"] / 1000,
      ),
    );
  } catch (e) {
    developer.log(e.toString());
    return null;
  }
}
