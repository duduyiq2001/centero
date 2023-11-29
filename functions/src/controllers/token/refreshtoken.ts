import { logger } from "firebase-functions/v1";
import { delete_token, UserType } from "./deletetoken";
import { store_token } from "./storetoken";
/**
 * Refresh user's token in their respective session store(key:uid value:(uid,token))
 * used when device token needs to be refreshed(delete old and add new)
 * @param uid uid of the token that needs to be refreshed
 * @param UserType specify manager or client
 * @param db_connection
 * @param new_token new token to be added
 *
 * @return {boolean}
 * return true if suceed
 */
async function refresh_token(
  new_token: string,
  user: UserType,
  db_connection: any,
  uid: string
): Promise<boolean> {
  try {
    let ifdelete: boolean = await delete_token(uid, user, db_connection);
    let ifrefresh: boolean = await store_token(
      new_token,
      user,
      db_connection,
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

export { refresh_token };
