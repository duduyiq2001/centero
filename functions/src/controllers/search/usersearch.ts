import * as admin from "firebase-admin";
import {logger} from "firebase-functions/v1";

/**
 * This module contains methods for searching na
 * mes of manager and user based on id
 */
/**
 * Search client based on id
 * @param {string} uid user id of the resident to be searched
 * @param { admin.firestore.Firestore} dbConnection
 * @return {Promise<[boolean, string]>}
 * I handle this thing with @return {string | null} in some other
 * places, which would be more convenient now I think about it
 *
 */
async function searchuser(
  uid: string,
  dbConnection: admin.firestore.Firestore
): Promise<[boolean, string]> {
  const ResidentRef = dbConnection.collection("Residents");
  const q = ResidentRef.where("uid", "==", uid);
  const docs = await q.get();
  if (docs.empty) {
    return [false, "user not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.data().name];
}

/**
 * query the clientstore (device token, uid) with
 * @param {string}clientID
 * @param {admin.firestore.Firestore} dbConn database connection
 * the client id
 * @return {Promise<string | null>}
 * the client's device token
 */
export async function searchclientstore(
  clientID: string,
  dbConn: admin.firestore.Firestore
): Promise<string | null> {
  const storeref = dbConn.collection("clientstore");
  let token: string | null = null;
  await storeref
    .doc(clientID)
    .get()
    .then((doc) => {
      const data = doc.data();
      if (data != undefined) {
        token = data.deviceToken;
      }
    })
    .catch((e) => {
      logger.log(e);
    });
  return token;
}

/**
 * Search manager based on id
 * @param {string}uid
 * @param {admin.firestore.Firestore} dbConnection
 * @return {Promise<[boolean, string]>}
 * I handle this thing with @return {string | null} in some other
 * places, which would be more convenient now I think about it
 *
 */
async function searchmanager(
  uid: string,
  dbConnection: admin.firestore.Firestore
): Promise<[boolean, string]> {
  const ResidentRef = dbConnection.collection("Managers");
  const q = ResidentRef.where("uid", "==", uid);
  const docs = await q.get();
  if (docs.empty) {
    return [false, "Manager not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.data().name];
}
export {searchuser, searchmanager};
