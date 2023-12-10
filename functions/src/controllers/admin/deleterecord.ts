import {logger} from "firebase-functions";
import * as admin from "firebase-admin";
/**
 * delete a record(admin only)
 * @param {string}collection name of the collection
 * @param {string}dockey the key of the doc to delete
 * @param {admin.firestore.Firestore}dbConnection the database connection
 *
 */
async function deleteDocument(
  collection: string,
  dockey: string,
  dbConnection: admin.firestore.Firestore
) {
  await dbConnection.collection(collection).doc(dockey).delete();
  logger.log(`Document at ${dockey} deleted.`);
}
export {deleteDocument};
