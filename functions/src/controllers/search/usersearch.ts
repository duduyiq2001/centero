import { logger } from "firebase-functions/v1";

async function searchuser(
  uid: string | null,
  db_connection: any
): Promise<[boolean, string]> {
  const ResidentRef = db_connection.collection("Residents");

  const q = ResidentRef.where("uid", "==", uid);
  logger.log(`uid       ${uid}`);
  let docs = await q.get();
  if (docs.empty) {
    return [false, "property not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.data().name];
}

async function searchmanager(
  uid: string,
  db_connection: any
): Promise<[boolean, string]> {
  const ResidentRef = db_connection.collection("Managers");

  const q = ResidentRef.where("uid", "==", uid);
  let docs = await q.get();
  if (docs.empty) {
    return [false, "property not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.name];
}
export { searchuser, searchmanager };
