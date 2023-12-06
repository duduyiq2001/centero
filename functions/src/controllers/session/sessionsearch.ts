import { logger } from "firebase-functions/v1";
import * as admin from "firebase-admin";

/**
 * query the callsession (manager,client pair) with
 * @param managertoken
 * the manager device token
 * @return {Promise<string | null>}
 */
export async function searchcallsession(managertoken: string, db_conn: admin.firestore.Firestore) : Promise<string|null> {
  var storeref = db_conn.collection("callsession");
  logger.log(`manager token search is ${managertoken}`);
  var token: string|null = null;
  await storeref.doc(managertoken).get().then((doc) => {
    const data = doc.data();
    if (data != undefined) {
      token = data.clienttoken;
    }
  }).catch(() => {});
  return token;
}

/**
 * query the callsession (manager,client pair) with
 * @param clienttoken
 * the client (resident) device token
 * @return {Promise<string | null>}
 */
export async function searchcallsessionfromclient(clienttoken: string, db_conn: admin.firestore.Firestore) : Promise<string|null> {
  var storeref = db_conn.collection("callsession");
  logger.log(`client token search is ${clienttoken}`);
  const q = storeref.where("clienttoken", "==", clienttoken);
  let docs = await q.get();
  if (docs.empty) {
    logger.log("Manager not found");
    return null;
  }
  const matchingDoc = docs.docs[0];
  return matchingDoc.id;
}
