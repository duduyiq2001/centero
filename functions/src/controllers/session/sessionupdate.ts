import { logger } from "firebase-functions/v1";
/**
 * add a manager client pair in call session,update the callsession table
 * @param managertoken
 * @param clienttoken
 *
 * @return {boolean}
 * return true if suceed
 */
async function addcallsession(
  clienttoken: string,
  managertoken: string,
  db_conn: any
) {
  var storeref = db_conn.collection("callsession");
  try {
    await storeref.doc(managertoken).set({ clienttoken: clienttoken });
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}

/**
 * remove a manager client pair in call session,update the callsession table
 * @param managertoken
 * @param clienttoken
 *
 * @return {boolean}
 * return true if suceed
 */
async function removecallsession(managertoken: string, db_conn: any) {
  var storeref = db_conn.collection("callsession");
  try {
    await storeref.doc(managertoken).delete();
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}

export { addcallsession, removecallsession };
