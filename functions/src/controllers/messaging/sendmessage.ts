import * as admin from "firebase-admin";
import { logger } from "firebase-functions/v1";

/**
 * Send message to a device
 * do not directly call this function
 * @param device_token device token
 * @param message message to be sent
 * @param data additional data to be sent to client (optional)
 *
 */
async function sendmessage(
  device_token: string,
  message: string,
  reason: string,
  data?: any
) {
  logger.log(`sending message ${message}`);
  logger.log(`device_token: ${device_token}`);
  if (data) {
    await admin.messaging().send({
      token: device_token,
      data: {
        message: message,
        data: data.toString(),
        reason: reason,
      },
    });
  } else {
    logger.log(`reason is :${reason}`);
    await admin.messaging().send({
      token: device_token,
      data: {
        message: message,
        reason: reason,
      },
    });
  }
}

export { sendmessage };
