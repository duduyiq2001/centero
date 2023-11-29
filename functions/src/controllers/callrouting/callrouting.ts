import { logger } from "firebase-functions";
import * as admin from "firebase-admin";
/**
 *
 * @return {RoutingResponse} to provide granularity
 * if no manager found return false
 * if find a manager
 * return true and managertoken and managerid
 * currently only finds the first manager from the manager table
 *  ***************
 * To do:
 * 1.modify database schema so that each manager get associated with a propetyname
 *  and here we only return a manager with the property name matching the client
 * 2.whenever user request a manager, we need to query the callsession table
 * to make sure manager is not in call with anyone else
 * if so we should return false
 */
type RoutingResponse = [boolean, string, string];
async function getmanager(db_connection: any): Promise<RoutingResponse> {
  try {
    const managerref = db_connection.collection("managerstore");
    const q = managerref.where("uid", "!=", null);
    let docs: admin.firestore.QuerySnapshot<admin.firestore.DocumentData> =
      await q.get();
    logger.info("doc", docs);
    if (docs.empty) {
      return [false, "", ""];
    }
    const matchingmanager = docs.docs[0];
    return [
      true,
      matchingmanager.data().device_token,
      matchingmanager.data().uid,
    ];
  } catch (e) {
    logger.log(e);
    return [false, "error", ""];
  }
}
export { getmanager };
