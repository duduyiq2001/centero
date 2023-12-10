import {logger} from "firebase-functions/v1";
import {deleteToken, UserType} from "./deletetoken";
import {storeToken} from "./storetoken";
import * as admin from "firebase-admin";
/**
 * Refresh user's token in their respective
 * session store(key:uid value:(uid,token))
 * used when device token needs to be refreshed
 * (delete old and add new)
 * @param {string} newToken new token to be added
 * @param {UserType}user specify manager or client
 * @param {admin.firestore.Firestore} dbConnection
 * @param {string} uid uid of the token that needs to be refreshed
 * @return {boolean}
 * return true if suceed
 */
async function refreshToken(
  newToken: string,
  user: UserType,
  dbConnection: admin.firestore.Firestore,
  uid: string
): Promise<boolean> {
  try {
    const ifdelete: boolean = await deleteToken(uid, user, dbConnection);
    const ifrefresh: boolean = await storeToken(
      newToken,
      user,
      dbConnection,
      uid
    );
    if (!ifdelete) {
      logger.log("token not deleted");
      return false;
    }
    if (!ifrefresh) {
      logger.log("token not refreshed");
      return false;
    }
    return true;
  } catch (e) {
    logger.log(e);
    return false;
  }
}

export {refreshToken};
