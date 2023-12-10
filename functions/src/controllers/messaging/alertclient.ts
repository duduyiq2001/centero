import {sendmessage} from "./sendmessage";
type AlertType =
  | "call rejected"
  | "call accepted"
  | "incoming call"
  | "call cancelled";

/**
 * Alert client with firebase cloud messging
 * @param {AlertType}alert specify alert reason
 * @param {string}recipientToken token of the recipient
 * @param {string}managerid the id of the manager
 */
export async function alertclient(
  alert: AlertType,
  recipientToken: string,
  managerid?: string
): Promise<void> {
  if (alert == "call rejected") {
    await sendmessage(
      recipientToken,
      "call rejected",
      "call rejected",
      managerid
    );
  }
  if (alert == "call accepted") {
    await sendmessage(recipientToken, "call accepted", "call accepted");
  }
  if (alert == "incoming call" || alert == "call cancelled") {
    throw new Error("wrong function");
  }
}
