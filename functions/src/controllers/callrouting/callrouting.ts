import { logger } from "firebase-functions";
import * as admin from "firebase-admin";
type RoutingResponse = [boolean, string];
async function getmanager(db_connection: any): Promise<RoutingResponse> {
  var managerref: any;
  try {
    managerref = db_connection.collection("managerstore");
    const q = managerref.where("uid", "!=", null);
    logger.log("abcdefg");
    let docs: admin.firestore.QuerySnapshot<admin.firestore.DocumentData> =
      await q.get();
    logger.info("doc", docs);
    if (docs.empty) {
      return [false, ""];
    }
    const matchingmanager = docs.docs[0];
    return [true, matchingmanager.data().device_token];
  } catch (e) {
    logger.log(e);
    return [false, "error"];
  }
}
export { getmanager };
