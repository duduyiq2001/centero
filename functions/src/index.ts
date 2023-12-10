/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
import {logger} from "firebase-functions";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {initializeApp} from "firebase-admin/app";
import {authenticateClient} from "./controllers/authentication/authentication";
import {storeToken} from "./controllers/token/storetoken";
import {getFirestore} from "firebase-admin/firestore";
import * as corsLib from "cors";
import {deleteToken} from "./controllers/token/deletetoken";
import {refreshToken} from "./controllers/token/refreshtoken";
import * as session from "./controllers/session/sessionupdate";
import {getmanager} from "./controllers/callrouting/callrouting";
import {alertmanager} from "./controllers/messaging/alertmanager";
import {alertclient} from "./controllers/messaging/alertclient";
import * as search from "./controllers/search/usersearch";
import * as sessionsearch from "./controllers/session/sessionsearch";
import {deleteDocument} from "./controllers/admin/deleterecord";
// Define an array of allowed origins

// Configure CORS with the specific origins
const corsOptions: corsLib.CorsOptions = {
  origin: function(origin, callback) {
    const allowedDomains =
      /https:\/\/centerobackend\.web\.app$|http:\/\/localhost(:\d+)?$/;
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

// http://localhost:35409/
/**
 * Signs in client, update client session
 * Don't worry about this one
 */
exports.clientsignin = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const {propertyName, unitNumber, social, deviceToken} = req.body;
      const conn = getFirestore();
      const [isValidUser, uid] = await authenticateClient(
        propertyName,
        unitNumber,
        social,
        conn
      );
      logger.log("herererereree");
      logger.log(`uid${uid}`);
      if (isValidUser) {
        admin
          .auth()
          .createCustomToken(`${uid}`)
          .then((customToken) => {
            res.status(200).json({token: customToken, id: uid});
          });
        await storeToken(deviceToken, "client", conn, `${uid}`);
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
    try {
      const {deviceToken} = req.body;

      const conn = getFirestore();

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
          storeToken(deviceToken, "manager", conn, uid);
        })
        .catch(() => {
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
    try {
      const conn = getFirestore();

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
          deleteToken(uid, "manager", conn);
        })
        .catch(() => {
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
    try {
      const {newToken} = req.body;

      const conn = getFirestore();

      const idToken = req.get("Authorization")?.split("Bearer ")[1];

      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }

      try {
        const decodedToken = await admin.auth().verifyIdToken(idToken);
        const uid = decodedToken.uid;
        if (await refreshToken(newToken, "manager", conn, uid)) {
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
    try {
      const conn = getFirestore();

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
          deleteToken(uid, "client", conn);
        })
        .catch(() => {
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
    try {
      const {newToken} = req.body;

      const conn = getFirestore();

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
          refreshToken(newToken, "client", conn, uid);
        })
        .catch(() => {
          // The ID token is invalid or expired
          res.status(401).send("Unauthorized");
          return;
        });
    } catch (error) {
      logger.log(error);
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
    // initializeApp();
    try {
      const body = req.body;
      const deviceToken = body.deviceToken;
      const rejected = body.rejected;
      const idToken = req.get("Authorization")?.split("Bearer ")[1];
      const conn = getFirestore();
      let id;
      if (idToken) {
        try {
          const decodedToken = await admin.auth().verifyIdToken(idToken);
          id = decodedToken.uid;
          logger.log(`id :${id}`);
        } catch (e) {
          res.status(401).send("Unauthorized");
          return;
        }
      } else {
        res.status(401).send("Unauthorized");
        return;
      }
      // get resident
      logger.log("getting the resident");
      logger.log(`id is ${id}`);
      const q = await conn.collection("Residents").where("uid", "==", id).get();
      if (q.size < 1) {
        res.status(401).send("User does not exist");
        return;
      }
      const resident = q.docs[0].data();
      logger.log("got resident");
      // route to manager
      let succeeded = false;
      let ifexist = false;
      let managertoken = "";
      let managername = "";
      let muid;
      // Call routing
      try {
        logger.log("routing to manager");
        if (rejected) {
          [succeeded, managertoken, muid] = await getmanager(
            conn,
            resident.propertyName,
            rejected
          );
        } else {
          logger.log("here!");
          logger.log(resident.propertyName);
          [succeeded, managertoken, muid] = await getmanager(
            conn,
            resident.propertyName
          );
        }
        if (succeeded) {
          [ifexist, managername] = await search.searchmanager(muid, conn);
        }
        // console.log(succeeded, ifexist, managertoken, muid, managername);
        if (!succeeded || !ifexist) {
          res.status(401).send("No Manager Available");
          return;
        }
      } catch (e) {
        logger.log(e);
        res.status(401).send("Internal Server Error");
        return;
      }
      // add session
      if (!(await session.addcallsession(deviceToken, managertoken, conn))) {
        logger.log("Could not create session");
        res.status(401).send("Could not create session");
        return;
      }
      // alert manager
      try {
        alertmanager("incoming call", managertoken, resident);
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
    try {
      const {deviceToken} = req.body;
      const conn = await getFirestore();
      const idToken = req.get("Authorization")?.split("Bearer ")[1];
      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }
      if (idToken) {
        try {
          await admin.auth().verifyIdToken(idToken);
        } catch (e) {
          logger.log(e);
          res.status(401).send("Unauthorized");
          return;
        }
      } else {
        res.status(401).send("Unauthorized");
        return;
      }
      try {
        const clienttoken = await sessionsearch.searchcallsession(
          deviceToken,
          conn
        );
        if (clienttoken) {
          await alertclient("call accepted", clienttoken);
          res.status(200).send("success!");
          return;
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
    try {
      const {deviceToken} = req.body;
      const conn = getFirestore();
      const idToken = req.get("Authorization")?.split("Bearer ")[1];
      let managerid: string;

      if (idToken) {
        try {
          const decodedToken = await admin.auth().verifyIdToken(idToken);
          managerid = decodedToken.uid;
          logger.log(`id :${managerid}`);
        } catch (e) {
          res.status(401).send("Unauthorized");
          return;
        }
      } else {
        res.status(401).send("Unauthorized");
        return;
      }
      try {
        const clienttoken = await sessionsearch.searchcallsession(
          deviceToken,
          conn
        );
        if (clienttoken) {
          await alertclient("call rejected", clienttoken, managerid);
          res.status(200).send("sucess!");
        } else {
          res.status(401).send("client does not exist!");
          return;
        }
        await session.removecallsession(deviceToken, conn);
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
 * Used when a CLIENT cancel a call during the middle of the call
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
    try {
      const {deviceToken} = req.body;
      const conn = getFirestore();
      const idToken = req.get("Authorization")?.split("Bearer ")[1];
      if (!idToken) {
        res.status(401).send("Unauthorized");
        return;
      }
      try {
        const managertoken = await sessionsearch.searchcallsessionfromclient(
          deviceToken,
          conn
        );
        if (managertoken) {
          logger.log(`manager token is fetched ${managertoken}`);
          await alertmanager("call cancelled", managertoken, null);
        } else {
          res.status(401).send("manager does not exist!");
          return;
        }
        await session.removecallsession(managertoken, conn);
        res.status(200).send("sucess!");
        return;
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

exports.getResident = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    try {
      const {uid} = req.body;
      const query = await admin
        .firestore()
        .collection("Residents")
        .where("uid", "==", uid)
        .get();
      if (query.size < 1) {
        res.status(404).send("User id not found");
      } else if (query.size > 1) {
        res.status(403).send("Error: Duplicate users");
      } else {
        const data = query.docs[0].data();
        res.status(200).json({
          name: data.name,
          unit: data.unit,
          uid: uid,
          propertyName: data.propertyName,
          address: data.address,
          leaseStart: data.leaseStart,
          leaseEnd: data.leaseEnd,
          rent: data.rent,
          rentDueDate: data.rentDueDate,
          deposit: data.deposit,
          petRent: data.petRent,
          lastCall: data.lastCall,
        });
      }
    } catch (error) {
      res.status(500).send("Internal Server Error");
    }
  });
});

/**
 * delete resident devicetoken from sessionstore when log out
 * don't worry about this one
 */
exports.AdminDeleteRecord = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    // initializeApp();
    try {
      const conn = await getFirestore();
      const collection = req.body.collection;
      const doc = req.body.doc;
      await deleteDocument(collection, doc, conn);
    } catch (error) {
      res.status(500).send("Internal server error");
    }
    res.status(200).send("success");
  });
});
