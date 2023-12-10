import * as admin from "firebase-admin";
import {logger} from "firebase-functions/v1";

/**
 * Send message to a device
 * do not directly call this function
 * @param {string}deviceToken device token
 * @param {string}message message to be sent
 * @param {string}reason reason for sending the message
 * @param {string}data additional data to be sent to client (optional
 * data needs be SERIALIZED before passing into this function
 * )
 *
 */
async function sendmessage(
  deviceToken: string,
  message: string,
  reason: string,
  data?: string
) {
  logger.log(`sending message ${message}`);
  logger.log(`device_token: ${deviceToken}`);
  logger.log(`data: ${data}`);
  if (data) {
    await admin.messaging().send({
      token: deviceToken,
      data: {
        message: message,
        data: data,
        reason: reason,
      },
    });
  } else {
    logger.log(`reason is :${reason}`);
    await admin.messaging().send({
      token: deviceToken,
      data: {
        message: message,
        reason: reason,
      },
    });
  }
}

export {sendmessage};
