import { logger } from "firebase-functions/v1";
import { UserType } from "./deletetoken";
/**
 * add a user to their respective session store(clientstore vs managerstore)
 * used when device token needs to be refreshed or
 * user log in
 * @param uid uid of the user to be added
 * @param UserType specify manager or client
 * @param db_connection
 *
 * @return {boolean}
 * return true if suceed
 */
async function store_token(
  device_token: string,
  user: UserType,
  db_connection: any,
  uid: string
): Promise<boolean> {
  var storeref: any;
  try {
    if (user == "client") {
      storeref = db_connection.collection("clientstore");
    } else {
      storeref = db_connection.collection("managerstore");
    }
    await storeref.doc(uid).set({ uid: uid, device_token: device_token });
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}

export { store_token };
