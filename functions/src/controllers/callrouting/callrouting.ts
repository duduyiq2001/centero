import { logger } from "firebase-functions";
import * as admin from "firebase-admin";
import { searchcallsession } from "../session/sessionsearch";
/**
 *
 * @return {RoutingResponse} to provide granularity
 * if no manager found return false
 * if find a manager
 * return true and managertoken and managerid
 */
type RoutingResponse = [boolean, string, string];
async function getmanager(db_connection: admin.firestore.Firestore, property: string): Promise<RoutingResponse> {
  try {
    const activeRef = db_connection.collection("managerstore");
    const q = activeRef.where("uid", "!=", null);
    let activeManagers = await q.get();
    const managerRef = db_connection.collection("Managers");
    const q2 = managerRef.where("property_name", "==", property);
    let propertyManagers = await q2.get();
    let matchingmanagers: admin.firestore.DocumentData[] = [];
    let manager: admin.firestore.DocumentData|null = null;

    for (let i = 0; i < activeManagers.size; ++i) {
      let uid = activeManagers.docs[i].data().uid;
      for (let j = 0; j < propertyManagers.size; ++j) {
        if (uid == propertyManagers.docs[j].data().uid) {
          matchingmanagers.push(activeManagers.docs[i]);
        }
      }
    }

    if (matchingmanagers.length == 0) {
      return [false, "no online managers for property", ""];
    }

    // loop through managers check if they are in a call
    for (let i = 0; i < matchingmanagers.length; ++i) {
      let managerToken = matchingmanagers[i].data().device_token;
      let inSession = await searchcallsession(managerToken, db_connection).then(clientToken => clientToken != null);
      if (!inSession) {
        manager = matchingmanagers[i];
        break;
      }
    }

    if (manager == null) {
      return [false, "managers are busy", ""];
    }

    return [
      true,
      manager!.data().device_token,
      manager!.data().uid,
    ];
  } catch (e) {
    logger.log(e);
    return [false, "error", ""];
  }
}
export { getmanager };
