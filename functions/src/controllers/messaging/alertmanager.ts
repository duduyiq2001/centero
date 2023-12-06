import * as admin from "firebase-admin";
import { sendmessage } from "./sendmessage";

type AlertType =
  | "call rejected"
  | "call accepted"
  | "incoming call"
  | "call cancelled";
/**
 * Alert manager with firebase cloud messging
 * @param alert specify alert reason
 * @param recipient_token token of the recipient
 * @param sendername name of the person who's sending out the message
 */
async function alertmanager(alert: AlertType, recipient_token: string, sender: admin.firestore.DocumentData|null) : Promise<void> {
  if (alert == "call rejected" || alert == "call accepted") {
    throw new Error("wrong function");
  }

  if (alert == "incoming call") {
    await sendmessage(recipient_token, `incoming call from ${(sender) ? sender.name : ""}`, JSON.stringify(sender!));
  }
  else if (alert == "call cancelled") {
    await sendmessage(recipient_token, `call cancelled by ${(sender) ? sender.name : ""}`);
  }
}

export { alertmanager };