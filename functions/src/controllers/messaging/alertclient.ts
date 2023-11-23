import { logger } from "firebase-functions/v1";
import { sendmessage } from "./sendmessage";
type AlertType =
  | "call rejected"
  | "call accepted"
  | "incoming call"
  | "call cancelled";
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
    await sendmessage(recipient_token, `call accepted by ${sendername}`);
  }
  if (alert == "incoming call" || alert == "call cancelled") {
    throw new Error("wrong function");
  }
}
export { alertclient };
