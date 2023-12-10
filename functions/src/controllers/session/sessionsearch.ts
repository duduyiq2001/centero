import {logger} from "firebase-functions/v1";
import * as admin from "firebase-admin";

/**
 * query the callsession (manager,client pair) with
 * @param {string}managertoken
 * @param {admin.firestore.Firestore} dbConn
 * the manager device token
 * @return {Promise<string | null>}
 */
export async function searchcallsession(
  managertoken: string,
  dbConn: admin.firestore.Firestore
): Promise<string | null> {
  const storeref = dbConn.collection("callsession");
  logger.log(`manager token search is ${managertoken}`);
  let token: string | null = null;
  await storeref
    .doc(managertoken)
    .get()
    .then((doc) => {
      const data = doc.data();
      if (data != undefined) {
        token = data.clienttoken;
      }
    })
    .catch((e) => {
      logger.log(e);
    });
  return token;
}

/**
 * query the callsession (manager,client pair) with
 * @param {string} clienttoken device token of the client
 * @param {string} dbConn database connection
 * the client (resident) device token
 * @return {Promise<string | null>}
 */
export async function searchcallsessionfromclient(
  clienttoken: string,
  dbConn: admin.firestore.Firestore
): Promise<string | null> {
  const storeref = dbConn.collection("callsession");
  logger.log(`client token search is ${clienttoken}`);
  const q = storeref.where("clienttoken", "==", clienttoken);
  const docs = await q.get();
  if (docs.empty) {
    logger.log("Manager not found");
    return null;
  }
  const matchingDoc = docs.docs[0];
  return matchingDoc.id;
}
