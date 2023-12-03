/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
import { logger } from "firebase-functions";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { initializeApp } from "firebase-admin/app";
import { authenticate_client } from "./controllers/authentication/authentication";
import { store_token } from "./controllers/token/storetoken";
import { getFirestore } from "firebase-admin/firestore";
import * as corsLib from "cors";
import { delete_token } from "./controllers/token/deletetoken";
import { refresh_token } from "./controllers/token/refreshtoken";
import * as session from "./controllers/session/sessionupdate";
import { getmanager } from "./controllers/callrouting/callrouting";
import { alertmanager } from "./controllers/messaging/alertmanager";
import { alertclient } from "./controllers/messaging/alertclient";
import * as search from "./controllers/search/usersearch";
import * as sessionsearch from "./controllers/session/sessionsearch";
// Define an array of allowed origins

// Configure CORS with the specific origins
const corsOptions: corsLib.CorsOptions = {
  origin: function (origin, callback) {
    let allowedDomains =
      /https:\/\/centero-191ae\.web\.app$|http:\/\/localhost(:\d+)?$/;
    if (!origin) {
      callback(null, true);
    } else if (allowedDomains.test(origin)) {
      callback(null, true);
    } else {
      callback(new Error("Not allowed by CORS"));
    }
  },
};
const cors = corsLib(corsOptions);
initializeApp();
//http://localhost:35409/
/**
 * Signs in client, update client session
 * Don't worry about this one
 */
export const clientsignin = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const { property_name, unit_number, social, device_token } = req.body;
      const conn = getFirestore();
      const [isValidUser, uid] = await authenticate_client(
        property_name,
        unit_number,
        social,
        conn
      );
      if (isValidUser) {
        admin
          .auth()
          .createCustomToken(`${uid}`)
          .then((customToken) => {
            res.status(200).json({ token: customToken, id: uid });
          });
        await store_token(device_token, "client", conn, `${uid}`);
      } else {
        res.status(403).send("Invalid credentials");
        return;
      }
    } catch (error) {
      logger.log("Error creating custom token:", error);
      res.status(500).send("Internal server error");
      return;
    }
  });
});
/**
 * whenever manager account is added on firebase auth
 * firebase firestore will also be updated
 * don't worry about this one
 */
exports.createManagerProfile = functions.auth.user().onCreate((user) => {
  // user is the newly created user
  const userRef = admin.firestore().collection("Managers").doc(user.uid);
  return userRef.set({
    email: user.email,
    uid: user.uid,
  });
});
/**
 * Called after manager authenticates with firebase auth
 * add manager device token to managerstore
 */
exports.OnManagerLogin = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { device_token } = req.body;

      const conn = await getFirestore();

      const idToken = req.get("Authorization")?.split("Bearer ")[1];

      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }

      admin
        .auth()
        .verifyIdToken(idToken)
        .then((decodedToken) => {
          const uid = decodedToken.uid;
          store_token(device_token, "manager", conn, uid);
        })
        .catch((error) => {
          // The ID token is invalid or expired
          res.status(401).send("Unauthorized");
          return;
        });
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
    res.status(200).send("success");
  });
});
/**
 * manager logout
 * delete manager device token from session
 * don't worry about this one
 */
exports.OnManagerLogout = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const conn = await getFirestore();

      const idToken = req.get("Authorization")?.split("Bearer ")[1];

      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }

      admin
        .auth()
        .verifyIdToken(idToken)
        .then((decodedToken) => {
          const uid = decodedToken.uid;
          delete_token(uid, "manager", conn);
        })
        .catch((error) => {
          // The ID token is invalid or expired
          res.status(401).send("Unauthorized");
          return;
        });
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
    res.status(200).send("success");
  });
});
/**
 * manager token refresh
 * don't worry about this one
 */
exports.OnManagerTokenRefresh = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { new_token } = req.body;

      const conn = await getFirestore();

      const idToken = req.get("Authorization")?.split("Bearer ")[1];

      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }

      try {
        const decodedToken = await admin.auth().verifyIdToken(idToken);
        const uid = decodedToken.uid;
        if (await refresh_token(new_token, "manager", conn, uid)) {
          res.status(200).send("success");
          return;
        }
        res.status(401).send("can't refresh token");
        return;
      } catch (error) {
        res.status(401).send("Unauthorized");
        return;
      }
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
  });
});
/**
 * delete resident devicetoken from sessionstore when log out
 * don't worry about this one
 */
exports.OnResidentLogOut = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const conn = await getFirestore();

      const idToken = req.get("Authorization")?.split("Bearer ")[1];

      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }

      admin
        .auth()
        .verifyIdToken(idToken)
        .then((decodedToken) => {
          const uid = decodedToken.uid;
          delete_token(uid, "client", conn);
        })
        .catch((error) => {
          // The ID token is invalid or expired
          res.status(401).send("Unauthorized");
          return;
        });
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
    res.status(200).send("success");
  });
});
/**
 * refresh resident token
 * don't worry about this one
 */
exports.OnResidentTokenRefresh = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { new_token } = req.body;

      const conn = await getFirestore();

      const idToken = req.get("Authorization")?.split("Bearer ")[1];

      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }

      admin
        .auth()
        .verifyIdToken(idToken)
        .then((decodedToken) => {
          const uid = decodedToken.uid;
          refresh_token(new_token, "client", conn, uid);
        })
        .catch((error) => {
          // The ID token is invalid or expired
          res.status(401).send("Unauthorized");
          return;
        });
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
    res.status(200).send("success");
    return;
  });
});
/**
 * Used when a CLIENT request a manager
 * CALLING @getmanager service to get routed to a manager
 * use @search service to search for resident name
 * @session will be use to add (manager,resident) pair to call session
 * @alertmanager manager be alerted by user's request
 */
exports.onRequestCall = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    try {
      const { property_name } = req.body;

      const conn = getFirestore();

      const idToken = req.get("Authorization")?.split("Bearer ")[1];
      var name: string = "";
      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }
      try {
        var decodetoken = await admin.auth().verifyIdToken(idToken);
        const uid = decodetoken.uid;
        var [userexist, name] = await search.searchuser(uid, conn);
        if (!userexist) {
          res.status(401).send("user does not exist");
          return;
        }
      } catch {
        res.status(401).send("Unauthorized");
        return;
      }

      //route to manager
      var succeeded: boolean = false;
      var ifexist: boolean = false;
      var managertoken: string = "";
      var managername: string = "";
      try {
        var [succeeded, managertoken, muid] = await getmanager(conn, property_name);
        if (succeeded) var [ifexist, managername] = await search.searchmanager(muid, conn);
        console.log(succeeded, ifexist, managertoken, muid, managername);
        if (!succeeded || !ifexist) {
          res.status(401).send("No Manager Available");
          return;
        }
      } catch (e) {
        logger.log(e);
        res.status(401).send("Internal Server Error");
        return;
      }

      try {
        await alertmanager("incoming call", managertoken, name);
        res.status(200).send(managername);
        return;
      } catch (e) {
        logger.log(e);
        res.status(401).send("Internal Server Error");
        return;
        }

    } catch (error) {
      res.status(500).send("Internal Server Error");
      return;
    }
  });
});

/**
 * Used when a MANAGER accept a recident's call request
 * @alertclient client be alerted by manager's acceptance
 *
 * *********
 * FUTURE PLAN: we will also initiate a actual video session
 * from this endpoint
 */
exports.onAcceptCall = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { device_token } = req.body;
      const conn = getFirestore();
      const idToken = req.get("Authorization")?.split("Bearer ")[1];
      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }
      try {
        const clienttoken = await sessionsearch.searchcallsession(
          device_token,
          conn
        );
        if (clienttoken) {
          await alertclient("call accepted", clienttoken, "");
          if (!await session.addcallsession(clienttoken, device_token, conn)) {
            console.log("Could not create session");
            res.status(401).send("Could not create session");
            return;
          }
        } else {
          res.status(401).send("client does not exist!");
          return;
        }
      } catch {
        res.status(401).send("Unauthorized");
        return;
      }
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
  });
});
/**
 * Used when a MANAGER reject a recident's call request
 * @alertclient client be alerted by manager's rejection
 * @removecallsession to remove (manager,client) sessionpair
 * *********
 * FUTURE PLAN:
 * on the client side display "rerouting to a another manager"
 * the manager that rejected by client can be
 * cached in client browser (managerid1,managerid2)
 * client will recalling the requestcall endpoint after
 * a cool down of let's say 10 seconds sending the cached manager ids
 * so that we can filter out mannger that just rejected
 */
exports.onRejectCall = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { device_token } = req.body;
      const conn = await getFirestore();
      const idToken = req.get("Authorization")?.split("Bearer ")[1];
      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }
      try {
        const clienttoken = await sessionsearch.searchcallsession(
          device_token,
          conn
        );
        if (clienttoken) {
          await alertclient("call rejected", clienttoken, "");
        } else {
          res.status(401).send("client does not exist!");
          return;
        }
        await session.removecallsession(device_token, conn);
      } catch {
        res.status(401).send("Unauthorized");
        return;
      }
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
  });
});
/**
 * Used when a CLIENT reject a recident's call request
 * @alertmanager alert manager that the call is cancelled
 * @removecallsession to remove (manager,client) sessionpair
 *********
 * frontend of the manager needs to handle the alert differently,
 * cancelling call before the manager click accept will simply remove
 * the popup message box
 * cancelling call during the call will lead manager back to the homepage
 */
exports.onCancelCall = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { device_token } = req.body;
      const conn = await getFirestore();
      const idToken = req.get("Authorization")?.split("Bearer ")[1];
      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }
      try {
        const managertoken = await sessionsearch.searchcallsessionfromclient(
          device_token,
          conn
        );
        if (managertoken) {
          await alertmanager("call cancelled", managertoken, "");
        } else {
          res.status(401).send("manager does not exist!");
          return;
        }
        await session.removecallsession(managertoken, conn);
      } catch {
        res.status(401).send("Unauthorized");
        return;
      }
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
  });
});
