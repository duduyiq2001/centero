import { sendmessage } from "./sendmessage";
type AlertType =
  | "call rejected"
  | "call accepted"
  | "incoming call"
  | "call cancelled";

/**
 * Alert client with firebase cloud messging
 * @param alert specify alert reason
 * @param recipient_token token of the recipient
 */
export async function alertclient(
  alert: AlertType,
  recipient_token: string
): Promise<void> {
  if (alert == "call rejected") {
    await sendmessage(recipient_token, "call declined", "call declined");
  }
  if (alert == "call accepted") {
    await sendmessage(recipient_token, "call accepted", "call accepted");
  }
  if (alert == "incoming call" || alert == "call cancelled") {
    throw new Error("wrong function");
  }
}
