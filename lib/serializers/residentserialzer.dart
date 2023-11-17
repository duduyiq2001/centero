import 'dart:convert';

String residentserializer(
    String propertyname, int unit_number, String social, String device_token) {
  return jsonEncode({
    "property_name": propertyname,
    "unit_number": unit_number,
    "social": social,
    "device_token": device_token
  });
}
