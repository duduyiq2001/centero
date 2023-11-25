import { logger } from "firebase-functions/v1";
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
 * @param sendername name of the person who's sending out the message
 *
 */
async function alertclient(
  alert: AlertType,
  recipient_token: string,
  sendername: string
): Promise<void> {
  logger.log(
    `alert ${alert}, recipient ${recipient_token}, sendername${sendername}`
  );
  if (alert == "call rejected") {
    await sendmessage(recipient_token, "rerouting");
  }
  if (alert == "call accepted") {
    await sendmessage(recipient_token, `call accepted by manager`);
  }
  if (alert == "incoming call" || alert == "call cancelled") {
    throw new Error("wrong function");
  }
}
export { alertclient };
