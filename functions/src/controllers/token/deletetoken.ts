type UserType = "client" | "manager";
async function delete_token(
  device_token: string,
  user: UserType,
  db_connection: any
): Promise<boolean> {
  var storeref: any;
  if (user == "client") {
    storeref = db_connection.collection("clientstore");
  } else {
    storeref = db_connection.collection("managerstore");
  }
  await storeref.doc(device_token).delete();
  return true;
}

export { delete_token, UserType };
