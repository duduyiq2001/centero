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
import { config_app } from "./firebase_config";
import { connect_db } from "./database";
import { authenticate_client } from "./controllers/authentication";
import { store_token } from "./controllers/storetoken";

const fireapp = admin.initializeApp(config_app);

export const cliengsignin = functions.https.onRequest(async (req, res) => {
  try {
    const { property_name, unit_num, social, device_token } = req.body;
    logger.log(property_name);
    const conn = connect_db(fireapp);

    const [isValidUser, uid] = await authenticate_client(
      property_name,
      unit_num,
      social,
      conn
    );

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
  try {
    const { device_token } = req.body;

    const conn = connect_db(fireapp);

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
});
