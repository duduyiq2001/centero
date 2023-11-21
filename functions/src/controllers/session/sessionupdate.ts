import { logger } from "firebase-functions/v1";
async function addrequestsession(
  clienttoken: string,
  managertoken: string,
  db_conn: any
) {
  var storeref = db_conn.collection("requestsession");
  try {
    await storeref.doc(managertoken).set({ clienttoken: clienttoken });
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}
async function removerequestsession(managertoken: string, db_conn: any) {
  var storeref = db_conn.collection("requestsession");
  try {
    await storeref.doc(managertoken).delete();
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}

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

export {
  addcallsession,
  removecallsession,
  addrequestsession,
  removerequestsession,
};
