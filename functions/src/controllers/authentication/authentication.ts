import * as admin from "firebase-admin";
import {logger} from "firebase-functions/v1";
type Authresult = [boolean, string];
/**
 * @param {string} propertyName the property name of the resident
 * @param {string} unitNum the unitnumber of the resident
 * @param {string} social the social security number of the resident
 * @param {admin.firestore.Firestore} dbConnection : database connection
 * @return {Authresult} to provide granularity
 * in event of success
 * return true and uid
 * in event of failure
 * return false and failure reason
 *
 */
async function authenticateClient(
  propertyName: string,
  unitNum: string,
  social: string,
  dbConnection: admin.firestore.Firestore
): Promise<Authresult> {
  const ResidentRef = dbConnection.collection("Residents");
  logger.log(" making query");
  logger.log(`res ref${ResidentRef != null}`);
  logger.log(`pname:${propertyName} unit ${unitNum}`);
  const q = ResidentRef.where("propertyName", "==", propertyName).where(
    "unit",
    "==",
    unitNum
  );

  const docs = await q.get();
  if (docs.empty) {
    return [false, "property not found"];
  }
  const matchingDoc = docs.docs.find((doc) => doc.data().social === social);
  if (matchingDoc) {
    return [true, matchingDoc.data().uid];
  } else {
    return [false, "social does not match"];
  }
}
export {authenticateClient};
