import { logger } from "firebase-functions/v1";
import * as admin from "firebase-admin";
async function searchrequestsession(
  managertoken: string,
  db_conn: admin.firestore.Firestore
): Promise<string | null> {
  var storeref = db_conn.collection("requestsession");
  logger.log(`manager token search is${managertoken}`);
  var token: string = "";
  await storeref
    .doc(managertoken)
    .get()
    .then((doc) => {
      const data = doc.data();
      if (data != undefined) {
        token = data.clienttoken;
      }
    })
    .catch((error) => {
      logger.log(error);
      return null;
    });
  return token;
}
export { searchrequestsession };
