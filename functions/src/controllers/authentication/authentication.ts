import { logger } from "firebase-functions";
import * as admin from "firebase-admin";
type Authresult = [boolean, string];
/**
 * Authenticate client with @param property_name @param unit_num @param social
 * @return {Authresult} to provide granularity
 * in event of success
 * return true and uid
 * in event of failure
 * return false and failure reason
 *
 */
async function authenticate_client(
  property_name: string,
  unit_num: number,
  social: string,
  db_connection: admin.firestore.Firestore
): Promise<Authresult> {
  const ResidentRef = db_connection.collection("Residents");

  const q = ResidentRef.where("property_name", "==", property_name).where(
    "unit_number",
    "==",
    unit_num
  );
  let docs = await q.get();
  logger.info("doc", docs);
  if (docs.empty) {
    return [false, "property not found"];
  }
  const matchingDoc = docs.docs.find((doc) => doc.data().social === social);
  if (matchingDoc) {
    logger.log(matchingDoc.id, " => ", matchingDoc.data().uid);
    logger.log("matches");
    return [true, matchingDoc.data().uid];
  } else {
    return [false, "social does not match"];
  }
}
export { authenticate_client };
