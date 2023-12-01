import "dart:convert";

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
