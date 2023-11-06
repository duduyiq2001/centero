import { doc, setDoc } from "firebase/firestore";
type UserType = "client" | "manager";
async function store_token(
  device_token: string,
  user: UserType,
  db_connection: any,
  uid: string
): Promise<boolean> {
  var storeref: any;
  if (user == "client") {
    storeref = doc(db_connection, "clientstore");
  } else {
    storeref = doc(db_connection, "managerstore");
  }
  await setDoc(storeref, { uid: uid, device_token: device_token });
  return true;
}

export { store_token };
