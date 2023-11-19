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
import { authenticate_client } from "./controllers/authentication";
import { store_token } from "./controllers/storetoken";
import { getFirestore } from "firebase-admin/firestore";
import * as corsLib from "cors";
import { delete_token } from "./controllers/deletetoken";
import { refresh_token } from "./controllers/refreshtoken";
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
          //const uid = decodedToken.uid;
          delete_token(device_token, "manager", conn);
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
      const { device_token, new_token } = req.body;

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
          refresh_token(device_token, new_token, "manager", conn, uid);
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

exports.OnResidentLogOut = functions.https.onRequest(async (req, res) => {
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
          //const uid = decodedToken.uid;
          delete_token(device_token, "client", conn);
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

exports.OnResidentTokenRefresh = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    //initializeApp();
    try {
      const { device_token, new_token } = req.body;

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
          refresh_token(device_token, new_token, "client", conn, uid);
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