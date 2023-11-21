import { sendmessage } from "./sendmessage";
type AlertType =
  | "call rejected"
  | "call accepted"
  | "incoming call"
  | "call cancelled";
async function alertmanager(
  alert: AlertType,
  recipient_token: string,
  sendername: string
): Promise<void> {
  if (alert == "call rejected" || "call accepted") {
    throw new Error("wrong function");
  }

  if (alert == "incoming call") {
    sendmessage(recipient_token, `incoming call from ${sendername}`);
  }
  if (alert == "call cancelled") {
    sendmessage(recipient_token, `call cancelled by ${sendername}`);
  }
}
export { alertmanager };
