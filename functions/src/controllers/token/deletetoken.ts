import * as admin from "firebase-admin";
type UserType = "client" | "manager";
/**
 * delete a user from their respective session
 * store(clientstore vs managerstore)
 * used when device token needs to be refreshed or
 * user log out
 * @param {string} uid uid to delete
 * @param {UserType} user specify manager or client
 * @param {admin.firestore.Firestore} dbConnection
 *
 * @return {boolean}
 * return true if suceed
 */
async function deleteToken(
  uid: string,
  user: UserType,
  dbConnection: admin.firestore.Firestore
): Promise<boolean> {
  let storeref;
  if (user == "client") {
    storeref = dbConnection.collection("clientstore");
  } else {
    storeref = dbConnection.collection("managerstore");
  }
  await storeref.doc(uid).delete();
  return true;
}

export {deleteToken, UserType};
