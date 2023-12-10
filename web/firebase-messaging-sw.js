//Give the service worker access to Firebase Messaging.
// Note that you can only use Firebase Messaging here. Other Firebase libraries
// are not available in the service worker.
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js"
);

// Initialize the Firebase app in the service worker by passing in
// your app's Firebase config object.
// https://firebase.google.com/docs/web/setup#config-object
firebase.initializeApp({
  apiKey: "AIzaSyCNJs_VyFxI7OFAaNxOIoL4KEPtSF0mKUc",
  authDomain: "centerobackend.firebaseapp.com",
  projectId: "centerobackend",
  storageBucket: "centerobackend.appspot.com",
  messagingSenderId: "780428703318",
  appId: "1:780428703318:web:670d5ac13609f2e9fb6df7",
  measurementId: "G-VDDP4KG3DZ",
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
