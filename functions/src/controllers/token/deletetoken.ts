type UserType = "client" | "manager";
/**
 * delete a user from their respective session store(clientstore vs managerstore)
 * used when device token needs to be refreshed or
 * user log out
 * @param uid uid to delete
 * @param UserType specify manager or client
 * @param db_connection
 *
 * @return {boolean}
 * return true if suceed
 */
async function delete_token(
  uid: string,
  user: UserType,
  db_connection: any
): Promise<boolean> {
  var storeref: any;
  if (user == "client") {
    storeref = db_connection.collection("clientstore");
  } else {
    storeref = db_connection.collection("managerstore");
  }
  await storeref.doc(uid).delete();
  return true;
}

export { delete_token, UserType };
