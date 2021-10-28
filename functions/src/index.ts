// export {newConfirmation} from "./firestore";

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";


admin.initializeApp();
const db = admin.firestore();


export const updateFriendConfirmation = functions.firestore
    .document("FriendConfirmations/{confirmationId}")
    .onUpdate(async (change, _) => await updateConfirmation(change));

async function updateConfirmation(
    change: functions.Change<functions.firestore.DocumentSnapshot>) {
  const friendConfirmationRefAfter = change.after.ref;
  const refString = friendConfirmationRefAfter.path;
  const snap = await friendConfirmationRefAfter.get();
  const ConfirmedRequest1 = await snap.get("ConfirmedRequest1");
  const ConfirmedRequest2 = await snap.get("ConfirmedRequest2");
  const uid1 = await snap.get("Uid1");
  const uid2 = await snap.get("Uid2");
  if (snap.data !== undefined) {
    if ((ConfirmedRequest1 == true) && (ConfirmedRequest2 == true)) {
      db.collection(`UserProfileInfo/${uid1}/AllFriends`)
          .doc(uid2)
          .update({
            "FriendUid": uid2,
          });
      db.collection(`UserProfileInfo/${uid2}/AllFriends`)
          .doc(uid1)
          .update({
            "FriendUid": uid1,
          });
      db.collection("UserProfileInfo").doc(uid1).update(
          {"AllFriends": admin.firestore.FieldValue.arrayUnion(uid2)});
      db.collection("UserProfileInfo").doc(uid2).update(
          {"AllFriends": admin.firestore.FieldValue.arrayUnion(uid1)});
      db.doc(refString).delete();
    }
  }
}

export const updateReviewRatings = functions.firestore
    .document("UserProfileInfo/{profileId}/AllFriends/{friendId}")
    .onWrite(async (change, _) => await updateRatings(change));

async function updateRatings(
    change: functions.Change<functions.firestore.DocumentSnapshot>) {
  const userReviewRef = change.after.ref.parent;
  let numProfileRatingsTrue = 0;
  let totalProfileRatings = 0;
  let numSafetyRatingsTrue = 0;
  let totalSafetyRatings = 0;
  const docrefs = await userReviewRef.listDocuments();
  for (const docRef of docrefs) {
    const snapshot = await docRef.get();
    const profileAccuracyRatingReview = snapshot.get("ProfileIsAccurate");
    const safetyRatingReview = snapshot.get("IsSafe");
    if (profileAccuracyRatingReview == true) {
      numProfileRatingsTrue = numProfileRatingsTrue + 1;
      totalProfileRatings = totalProfileRatings + 1;
    } else {
      totalProfileRatings = totalProfileRatings + 1;
    }
    if (safetyRatingReview == true) {
      numSafetyRatingsTrue = numSafetyRatingsTrue + 1;
      totalSafetyRatings = totalSafetyRatings + 1;
    } else {
      totalSafetyRatings = totalSafetyRatings + 1;
    }
  }
  const profileAccuracyRating =
  (numProfileRatingsTrue / totalProfileRatings) * 100;
  const safetyRating = (numSafetyRatingsTrue / totalSafetyRatings) * 100;
  const userProfileRef = userReviewRef.parent!;
  await userProfileRef.update({
    "ProfileAccuracyRating": profileAccuracyRating,
    "SafetyRating": safetyRating,
    "ReviewCount": totalProfileRatings,
  });
}
