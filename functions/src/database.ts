import { getFirestore } from "firebase/firestore";

// TODO: Replace the following with your app's Firebase project configuration
// See: https://support.google.com/firebase/answer/7015592

function connect_db(app: any): any {
  const db = getFirestore(app);
  return db;
}

export { connect_db };
