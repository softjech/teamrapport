const functions = require('firebase-functions');
const admin = require('firebase-admin');
const algoliasearch = require('algoliasearch');

const ALGOLIA_APP_ID = "FRJKM8D84N";
const ALGOLIA_ADMIN_KEY = "ab97d1f46c91b7fe8465b36c3e382bd0";
const ALGOLIA_INDEX_NAME="Name";

admin.initializeApp(functions.config().firebase);
exports.createName = functions.firestore
.document('users/{UserID}')
.onCreate(async (snap,context) => {
    const newValue = snap.data();
    newValue.objectID = snap.id;

    var client = algoliasearch(ALGOLIA_APP_ID,ALGOLIA_ADMIN_KEY);

    var index = client.initIndex(ALGOLIA_INDEX_NAME);
    index.saveObject(newValue);
    console.log("finished");
});

exports.updateName = functions.firestore
.document('users/{UserID}')
.onUpdate(async (snap,context) => {
    const afterUpdate = snap.after.data();
    afterUpdate.objectID = snap.after.id;

    var client = algoliasearch(ALGOLIA_APP_ID,ALGOLIA_ADMIN_KEY);

    var index = client.initIndex(ALGOLIA_INDEX_NAME);
    index.saveObject(afterUpdate);
    console.log("Updated");
});

exports.deleteName = functions.firestore
.document('users/{UserID}')
.onDelete(async (snap,context) => {
    const oldID = snap.id;

    var client = algoliasearch(ALGOLIA_APP_ID,ALGOLIA_ADMIN_KEY);

    var index = client.initIndex(ALGOLIA_INDEX_NAME);
    index.deleteObject(oldID);
    console.log("Deleted");
});

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
