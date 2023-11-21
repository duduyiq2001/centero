import * as admin from "firebase-admin";

async function sendmessage(
  device_token: string,
  message: string,
  data?: string
) {
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
