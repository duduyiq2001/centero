import 'package:centero/models/resident.dart';

bool authenticate(String username, String password) {
  print("auth service accessed");
  for (var i = 0; i < dummyData.length; i++) {
    if (dummyData[i].username == username &&
        dummyData[i].password == password) {
      return true;
    }
  }
  return false;
}
