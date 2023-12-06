import * as admin from "firebase-admin";

/**
 * This module contains methods for searching names of manager and user based on id
 */
/**
 * Search client based on id
 * @param uid
 * @return {boolean,string}
 * I handle this thing with @return {string | null} in some other
 * places, which would be more convenient now I think about it
 *
 */
async function searchuser(uid: string, db_connection: admin.firestore.Firestore) : Promise<[boolean, string]> {
  const ResidentRef = db_connection.collection("Residents");
  const q = ResidentRef.where("uid", "==", uid);
  let docs = await q.get();
  if (docs.empty) {
    return [false, "user not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.data().name];
}

/**
 * query the clientstore (device token, uid) with
 * @param clientID
 * the client id
 * @return {Promise<string | null>}
 * the client's device token
 */
export async function searchclientstore(clientID: string, db_conn: admin.firestore.Firestore) : Promise<string | null> {
  var storeref = db_conn.collection("clientstore");
  var token: string|null = null;
  await storeref.doc(clientID).get().then((doc) => {
    const data = doc.data();
    if (data != undefined) {
      token = data.device_token;
    }
  }).catch(() => {});
  return token;
}

/**
 * Search manager based on id
 * @param uid
 * @return {boolean,string}
 * I handle this thing with @return {string | null} in some other
 * places, which would be more convenient now I think about it
 *
 */
async function searchmanager(uid: string, db_connection: admin.firestore.Firestore) : Promise<[boolean, string]> {
  const ResidentRef = db_connection.collection("Managers");
  const q = ResidentRef.where("uid", "==", uid);
  let docs = await q.get();
  if (docs.empty) {
    return [false, "Manager not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.data().name];
}
export { searchuser, searchmanager };
