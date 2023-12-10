String getfunctionname(String functionname) {
  const String mode = String.fromEnvironment("mode");
  const String localdomain =
      "http://127.0.0.1:5001/centerobackend/us-central1/";
  const String proddomain =
      " https://us-central1-centerobackend.cloudfunctions.net/";

  if (mode == "dev") {
    return localdomain + functionname;
  }
  return proddomain + functionname;
}
