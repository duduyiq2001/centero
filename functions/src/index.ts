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
export const clientsignin = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { property_name, unit_number, social, device_token } = req.body;
      logger.log("req boday:", req.body);
      logger.log("property", property_name);
      const conn = await getFirestore();
      const [isValidUser, uid] = await authenticate_client(
        property_name,
        unit_number,
        social,
        conn
      );
      logger.log("ekdmeedde");
      logger.log([isValidUser, uid]);
      if (isValidUser) {
        admin
          .auth()
          .createCustomToken(uid)
          .then((customToken) => {
            res.json({ token: customToken });
          });
        await store_token(device_token, "client", conn, uid);
      } else {
        //here to specify reasons for fail (if else)
        res.status(403).send("Invalid credentials");
      }
    } catch (error) {
      logger.log("Error creating custom token:", error);
      res.status(500).send("Internal server error");
    }
    res.status(200).send("success");
  });
});

exports.createManagerProfile = functions.auth.user().onCreate((user) => {
  // user is the newly created user
  const userRef = admin.firestore().collection("Managers").doc(user.uid);
  return userRef.set({
    email: user.email,
    uid: user.uid,
  });
});

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
        });
    } catch (error) {
      res.status(500).send("Internal server error");
    }
    res.status(200).send("success");
  });
});

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
        });
    } catch (error) {
      res.status(500).send("Internal server error");
    }
    res.status(200).send("success");
  });
});

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
      }
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
  });
});

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
    }
    res.status(200).send("success");
  });
});

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
        });
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
    res.status(200).send("success");
    return;
  });
});

exports.onRequestCall = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { device_token } = req.body;

      const conn = await getFirestore();

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
        }
      } catch {
        res.status(401).send("Unauthorized");
      }

      //route to manager
      var ifsucceed1: Boolean = false;
      var managertoken: string = "";
      var managername: string = "";
      try {
        var [ifsucceed, managertoken, muid] = await getmanager(conn);
        ifsucceed1 = ifsucceed;
        logger.log(`muid:  ${muid}`);
        var [ifexist, managername] = await search.searchmanager(muid, conn);
        if (!ifexist) {
          res.status(401).send("no manager available");
          return;
        }
      } catch (e) {
        logger.log(e);
        res.status(401).send("internal server error");
        return;
      }

      if (ifsucceed1) {
        //update_request_session
        logger.log(managername);
        if (await session.addrequestsession(device_token, managertoken, conn)) {
          try {
            await alertmanager("incoming call", managertoken, name);
            res.status(200).send(managername);
            return;
          } catch (e) {
            logger.log(e);
            res.status(401).send("Internal Server Error");
            return;
          }
        } else {
          res.status(401).send("Internal Server Error");
          return;
        }
      }
    } catch (error) {
      res.status(500).send("Internal server error");
      return;
    }
  });
});

exports.onAcceptCall = functions.https.onRequest(async (req, res) => {
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
        const clienttoken = await sessionsearch.searchrequestsession(
          device_token,
          conn
        );
        if (clienttoken) {
          await alertclient("call accepted", clienttoken, "");
        } else {
          res.status(401).send("client does not exist!");
          return;
        }

        if (await session.removerequestsession(device_token, conn)) {
          if (await session.addcallsession(clienttoken, device_token, conn)) {
            res.status(200).send("success");
            return;
          }
          res.status(401).send("can't add call session");
        } else {
          res.status(401).send("remove session failed");
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
