///
/// Enum type for handling different login senarios
/// [deviceTokenFailed] when user failed to fetch or register device token
/// [customTokenFailedToGenerate] when on the resident side, customtoken failed to be
/// generated from the user id(firebase auth error)
/// [signInFailed] is when user credientialed did not match
/// control left click on those things for more details.

enum LoginResponse {
  deviceTokenFailed,
  customTokenFailedToGenerate,
  signInFailed,
  success
}
