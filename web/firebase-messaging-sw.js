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
  apiKey: "AIzaSyCukdY8KFDS7WRyOCoC3VQZncP0rKuPYXw",
  appId: "1:478226578656:web:d94b6d1b9e25a39448a485",
  messagingSenderId: "478226578656",
  projectId: "centero-191ae",
  authDomain: "centero-191ae.firebaseapp.com",
  storageBucket: "centero-191ae.appspot.com",
  measurementId: "G-7P4DKVJLBT",
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
