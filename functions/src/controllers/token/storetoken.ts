import {logger} from "firebase-functions/v1";
import {UserType} from "./deletetoken";
import * as admin from "firebase-admin";

/**
 * add a user to their respective session store(clientstore vs managerstore)
 * used when device token needs to be refreshed or
 * user log in
 * @param {string} deviceToken the token to be stored in the corresponding
 * @param {UserType} user specify manager or client
 * @param {any} dbConnection
 * @param {string}uid uid of the user to be added
 * store (client or manager)
 *
 * @return {boolean}
 * return true if suceed
 */
export async function storeToken(
  deviceToken: string,
  user: UserType,
  dbConnection: admin.firestore.Firestore,
  uid: string
): Promise<boolean> {
  let storeref;
  try {
    if (user == "client") {
      storeref = dbConnection.collection("clientstore");
    } else {
      storeref = dbConnection.collection("managerstore");
    }
    await storeref.doc(uid).set({uid: uid, deviceToken: deviceToken});
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}
