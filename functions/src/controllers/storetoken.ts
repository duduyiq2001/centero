type UserType = "client" | "manager";
async function store_token(
  device_token: string,
  user: UserType,
  db_connection: any,
  uid: string
): Promise<boolean> {
  var storeref: any;
  if (user == "client") {
    storeref = db_connection.collection("clientstore");
  } else {
    storeref = db_connection.collection("managerstore");
  }
  await storeref
    .doc(device_token)
    .set({ uid: uid, device_token: device_token });
  return true;
}

export { store_token };
