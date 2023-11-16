import { getFirestore } from "firebase/firestore";
import { logger } from "firebase-functions/v1";

// TODO: Replace the following with your app's Firebase project configuration
// See: https://support.google.com/firebase/answer/7015592

function connect_db(app: any): any {
  logger.log("at db");
  const db = getFirestore(app);
  return db;
}

export { connect_db };
