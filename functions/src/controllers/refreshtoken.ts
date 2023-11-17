import { logger } from "firebase-functions/v1";
import { delete_token } from "./deletetoken";
import { store_token } from "./storetoken";
type UserType = "client" | "manager";
async function refresh_token(
  device_token: string,
  new_token: string,
  user: UserType,
  db_connection: any,
  uid: string
): Promise<boolean> {
  try {
    let ifdelete: boolean = await delete_token(
      device_token,
      user,
      db_connection
    );
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
