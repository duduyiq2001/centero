async function searchuser(
  uid: string,
  db_connection: any
): Promise<[boolean, string]> {
  const ResidentRef = db_connection.collection("Residents");

  const q = ResidentRef.where("uid", "==", uid);
  let docs = await q.get();
  if (docs.empty) {
    return [false, "property not found"];
  }
  const matchingDoc = docs.docs[0];
  return [true, matchingDoc.name];
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
