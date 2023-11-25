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
 *
 * *******
 * FUTURE PLAN:
 * instead of passing
 */
async function alertmanager(
  alert: AlertType,
  recipient_token: string,
  sendername: string
): Promise<void> {
  if (alert == "call rejected" || alert == "call accepted") {
    throw new Error("wrong function");
  }
  /*
  planning on pass a json object and serialize
  {
    reason:"incoming call",
    message:"xxxxxxxxxx"
  }
  */
  if (alert == "incoming call") {
    //here change the data sent as json (to include message type)
    await sendmessage(recipient_token, `incoming call from ${sendername}`);
  }
  if (alert == "call cancelled") {
    await sendmessage(recipient_token, `call cancelled by ${sendername}`);
  }
}
export { alertmanager };
