import {logger} from "firebase-functions";
import * as admin from "firebase-admin";
import {searchcallsession} from "../session/sessionsearch";

/**
 * @type {RoutingResponse}
 * return true if routing is successful, along with
 * the manager 's id and device token
 *
 */
type RoutingResponse = [boolean, string, string];

/**
 * @return {RoutingResponse} to provide granularity
 * if no manager found return false
 * if find a manager
 * return true and managertoken and managerid
 * @param {admin.firestore.Firestore} dbConnection
 * @param {string}property name of the property for the client
 * @param {string}managerToExclude is the uid of the
 * manager we need to exclude here
 */
async function getmanager(
  dbConnection: admin.firestore.Firestore,
  property: string,
  managerToExclude?: string
): Promise<RoutingResponse> {
  try {
    const activeRef = dbConnection.collection("managerstore");
    const q = activeRef.where("uid", "!=", null);
    const activeManagers = await q.get();
    const managerRef = dbConnection.collection("Managers");
    const q2 = managerRef.where("propertyName", "==", property);
    const propertyManagers = await q2.get();
    const matchingmanagers: admin.firestore.DocumentData[] = [];
    let manager: admin.firestore.DocumentData | null = null;
    const hashMap = new Map<string, number>();
    // optimize using hash join?
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
    if (managerToExclude) {
      for (let i = 0; i < propertyManagers.size; ++i) {
        const uid = propertyManagers.docs[i].data().uid;
        if (uid != managerToExclude) {
          hashMap.set(uid, 1);
        }
      }
    } else {
      for (let i = 0; i < propertyManagers.size; ++i) {
        const uid = propertyManagers.docs[i].data().uid;
        hashMap.set(uid, 1);
      }
    }
    for (let j = 0; j < activeManagers.size; ++j) {
      const id = activeManagers.docs[j].data().uid;
      if (hashMap.has(id)) {
        matchingmanagers.push(activeManagers.docs[j]);
        logger.log(`id ${id}`);
      }
    }
    // if no manager is available
    if (matchingmanagers.length == 0) {
      return [false, "no online managers for property", ""];
    }
    logger.log("checking session");
    // loop through managers check if they are in a call
    for (let i = 0; i < matchingmanagers.length; ++i) {
      const managerToken = matchingmanagers[i].data().deviceToken;
      const inSession = await searchcallsession(
        managerToken,
        dbConnection
      ).then((clientToken) => clientToken != null);
      if (!inSession) {
        manager = matchingmanagers[i];
        break;
      }
    }

    if (manager == null) {
      return [false, "managers are busy", ""];
    }

    return [true, manager.data().deviceToken, manager.data().uid];
  } catch (e) {
    logger.log(e);
    return [false, "error", ""];
  }
}
export {getmanager};
