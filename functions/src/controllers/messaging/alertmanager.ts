import * as admin from "firebase-admin";
import {sendmessage} from "./sendmessage";

type AlertType =
  | "call rejected"
  | "call accepted"
  | "incoming call"
  | "call cancelled";
/**
 * Alert manager with firebase cloud messging
 * @param {AlertType}alert specify alert reason
 * @param {string}recipientToken token of the recipient
 * @param {admin.firestore.DocumentData | null}sender name
 * of the person who's sending out the message
 */
async function alertmanager(
  alert: AlertType,
  recipientToken: string,
  sender: admin.firestore.DocumentData | null
): Promise<void> {
  if (alert == "call rejected" || alert == "call accepted") {
    throw new Error("wrong function");
  }

  if (alert == "incoming call") {
    await sendmessage(
      recipientToken,
      `incoming call from ${sender ? sender.name : ""}`,
      "incoming call",
      JSON.stringify(sender)
    );
  } else if (alert == "call cancelled") {
    await sendmessage(
      recipientToken,
      `call cancelled by ${sender ? sender.name : ""}`,
      "call cancelled"
    );
  }
}

export {alertmanager};
