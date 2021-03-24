const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { snapshotConstructor } = require('firebase-functions/lib/providers/firestore');

admin.initializeApp(functions.config().firebase);

var msgData;

exports.transactionTrigger = functions.firestore.document('transactions/{transactionId}').onCreate((snapshot, context)=> {
    msgData = snapshot.data();

    admin.firestore().collection('pushtoken').get().then(async (snapshot)=>{
        var tokens = [];
        if(snapshot.empty){
            console.log("Empty");
        }
            var payload = {
                "notification": {
                    "title": "New Transaction by " + msgData.user,
                    "body": "Transaction: "+ msgData.transactionType+" ("+msgData.amount+")",
                    "sound": "default",
                },
                "data": {
                    "sendername": msgData.customer,
                    "message": msgData.time,
                }
            };
            try {
                const response = await admin.messaging().sendToDevice(tokens, payload);
                console.log('Notififcation sent');
            } catch (err) {
                console.log(err);
            }
    })
});