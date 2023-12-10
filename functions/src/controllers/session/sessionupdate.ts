import {logger} from "firebase-functions/v1";
import * as admin from "firebase-admin";
/**
 * add a manager client pair in call session,update the callsession table
 * @param {string} clienttoken device token of the client
 * @param {string} managertoken device token of the manager
 * @param {any} dbConn database connection
 *
 *
 * @return {boolean}
 * return true if suceed
 */
export async function addcallsession(
  clienttoken: string,
  managertoken: string,
  dbConn: admin.firestore.Firestore
): Promise<boolean> {
  const storeref = dbConn.collection("callsession");
  try {
    await storeref.doc(managertoken).set({clienttoken: clienttoken});
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}

/**
 * remove a manager client pair in call session,update the callsession table
 * @param {string} managertoken
 * @param {any}dbConn
 *
 * @return {boolean}
 * return true if suceed
 */
export async function removecallsession(
  managertoken: string,
  dbConn: admin.firestore.Firestore
): Promise<boolean> {
  const storeref = dbConn.collection("callsession");
  try {
    await storeref.doc(managertoken).delete();
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}
