///
/// Enum type for handling different login senarios
/// [devicetokenfailed] when user failed to fetch or register device token
/// [customtokenfailedtogenerate] when on the resident side, customtoken failed to be
/// generated from the user id(firebase auth error)
/// [sigininfailed] is when user credientialed did not match
/// control left click on those things for more details.

enum LoginResponse {
  devicetokenfailed,
  customtokenfailedtogenerate,
  sigininfailed,
  success
}
