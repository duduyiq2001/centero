import { logger } from "firebase-functions";
import * as admin from "firebase-admin";
// Function to delete a document
async function deleteDocument(
  collection: string,
  dockey: string,
  db_connection: admin.firestore.Firestore
) {
  await db_connection.collection(collection).doc(dockey).delete();
  logger.log(`Document at ${dockey} deleted.`);
}
export { deleteDocument };
