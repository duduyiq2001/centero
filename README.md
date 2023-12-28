# Centero

Full-stack web app for Centero property management, built using Flutter and firebase cloud functions. The code is modularized using the model-view-controller design philosophy.

## Frontend

The Flutter code is contained in the /lib/ directory.

The code is modularized as follows:

- `main.dart` is the app entry point.
- `themes.dart` defines the app's themes for consistent design.
- The `/controllers/` directory defines controller functions for:
  - Authentication
  - Call management
  - Data retrieval
  - HTTP connections
- The `/models/` directory defines the data models for:
  - Login responses
  - Manager Class
  - Resident Class
- The `/serializers/` directory defines the data serializers.
- The `/utility/` directory defines some utility functions for token management.
- The `/views/` directory defines the following views:
  - Manager Login
  - Manager Home
  - Resident Login
  - Resident Home
  - Footer
  - Notification

## Backend

The Firebase Cloud Functions code is contained in the /functions/src/ directory.

The code is modularized as follows:

- `index.ts` defines the Firebase Cloud Functions endpoints and functions.
- The `/controllers/` directory defines controller functions for accessing and updating the Firebase Firestore database.
## For developers: 
please refer to https://github.com/duduyiq2001/centero/wiki/Guide-for-all-developers
