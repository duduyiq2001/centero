import * as admin from "firebase-admin";
type Authresult = [boolean, string];
/**
 * Authenticate client with @param propertyName @param unitNum @param social
 * @return {Authresult} to provide granularity
 * in event of success
 * return true and uid
 * in event of failure
 * return false and failure reason
 *
 */
async function authenticate_client(
  propertyName: string,
  unitNum: String,
  social: string,
  db_connection: admin.firestore.Firestore
): Promise<Authresult> {
  const ResidentRef = db_connection.collection("Residents");

  const q = ResidentRef
    .where("property_name", "==", propertyName)
    .where("unit_number", "==", unitNum);
  let docs = await q.get();
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
export { authenticate_client };
