import { logger } from "firebase-functions";
import * as admin from "firebase-admin";
import { searchcallsession } from "../session/sessionsearch";
/**
 *
 * @return {RoutingResponse} to provide granularity
 * if no manager found return false
 * if find a manager
 * return true and managertoken and managerid
 * @param property name of the property for the client
 * @param manager_to_exclude is the uid of the manager we need to exclude here
 */
type RoutingResponse = [boolean, string, string];
async function getmanager(
  db_connection: admin.firestore.Firestore,
  property: string,
  manager_to_exclude?: string
): Promise<RoutingResponse> {
  try {
    const activeRef = db_connection.collection("managerstore");
    const q = activeRef.where("uid", "!=", null);
    let activeManagers = await q.get();
    const managerRef = db_connection.collection("Managers");
    const q2 = managerRef.where("property_name", "==", property);
    let propertyManagers = await q2.get();
    let matchingmanagers: admin.firestore.DocumentData[] = [];
    let manager: admin.firestore.DocumentData | null = null;
    let hashMap = new Map<string, Number>();
    //optimize using hash join?
    /*
    for (let i = 0; i < activeManagers.size; ++i) {
      let uid = activeManagers.docs[i].data().uid;
      for (let j = 0; j < propertyManagers.size; ++j) {
        if (uid == propertyManagers.docs[j].data().uid) {
          matchingmanagers.push(activeManagers.docs[i]);
        }
      }
    }
*/
    if (manager_to_exclude) {
      for (let i = 0; i < propertyManagers.size; ++i) {
        let uid = propertyManagers.docs[i].data().uid;
        if (uid != manager_to_exclude) {
          hashMap.set(uid, 1);
        }
      }
    } else {
      for (let i = 0; i < propertyManagers.size; ++i) {
        let uid = propertyManagers.docs[i].data().uid;
        hashMap.set(uid, 1);
      }
    }
    for (let j = 0; j < activeManagers.size; ++j) {
      var id = activeManagers.docs[j].data().uid;
      if (hashMap.has(id)) {
        matchingmanagers.push(activeManagers.docs[j]);
        logger.log(`id ${id}`);
      }
    }
    // if no manager is available
    if (matchingmanagers.length == 0) {
      return [false, "no online managers for property", ""];
    }

    // loop through managers check if they are in a call
    for (let i = 0; i < matchingmanagers.length; ++i) {
      let managerToken = matchingmanagers[i].data().device_token;
      let inSession = await searchcallsession(managerToken, db_connection).then(
        (clientToken) => clientToken != null
      );
      if (!inSession) {
        manager = matchingmanagers[i];
        break;
      }
    }

    if (manager == null) {
      return [false, "managers are busy", ""];
    }

    return [true, manager!.data().device_token, manager!.data().uid];
  } catch (e) {
    logger.log(e);
    return [false, "error", ""];
  }
}
export { getmanager };
