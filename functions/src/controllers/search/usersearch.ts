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
async function searchuser(
  uid: string,
  db_connection: admin.firestore.Firestore,
): Promise<[boolean, string]> {
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
 * Search manager based on id
 * @param uid
 * @return {boolean,string}
 * I handle this thing with @return {string | null} in some other
 * places, which would be more convenient now I think about it
 *
 */
async function searchmanager(
  uid: string,
  db_connection: admin.firestore.Firestore,
): Promise<[boolean, string]> {
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
