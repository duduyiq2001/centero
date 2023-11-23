import * as admin from "firebase-admin";
import { logger } from "firebase-functions/v1";
async function sendmessage(
  device_token: string,
  message: string,
  data?: string
) {
  logger.log(`sending message${message}`);
  logger.log(`d_token:${device_token}`);
  if (data) {
    await admin.messaging().send({
      token: device_token,
      data: {
        message: message,
        data: data,
      },
    });
  } else {
    await admin.messaging().send({
      token: device_token,
      data: {
        message: message,
      },
    });
  }
}

export { sendmessage };
