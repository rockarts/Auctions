import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

export const scheduledFunction = functions.pubsub.schedule('* * * * *').onRun((context) => {
    console.log('This will be run every minute!');
    const db = admin.database();
    const ref = db.ref('auctions/');

    // Attach an asynchronous callback to read the data at our posts reference
    ref.on('value', (snapshot) => {
        snapshot.forEach((childSnapshot) => {
            const key = childSnapshot.key;
            const auction = childSnapshot.val();
            console.log(auction);

            const start = new Date(auction.start);
            const end = new Date(auction.end);
            const isActive = auction.isActive;
            const now = new Date();


            //Update the auction to active
            if(start < now && end > now && !isActive) {
                console.log(auction);
                console.log("ACTIVE");
                const auctionRef = ref.child(key!);
                    console.log("Updating auction to active!");
                    auctionRef.update({
                        'isActive': true
                    });
            }

            //Case for ended auctions. 
            if(end < now && isActive) {
                console.log(auction.title);
                console.log("Auction should be ended")
                const auctionRef = ref.child(key!);
                    console.log("Updating auction to active!");
                    auctionRef.update({
                        'isActive': false
                    });
            }
          });
    }, (errorObject) => {
        console.log('The read failed: ' + errorObject.name);
    }); 
    return null;
});