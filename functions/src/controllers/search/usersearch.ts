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
    return [false, "user not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.data().name];
}

async function searchmanager(
  uid: string,
  db_connection: any
): Promise<[boolean, string]> {
  const ResidentRef = db_connection.collection("Managers");
  logger.log(`searched uid == ${uid}`);
  const q = ResidentRef.where("uid", "==", uid);
  let docs = await q.get();
  if (docs.empty) {
    logger.log("Manager not found");
    return [false, "Manager not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.data().name];
}
export { searchuser, searchmanager };
