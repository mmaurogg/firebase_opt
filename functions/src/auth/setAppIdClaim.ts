import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";

const ALLOWED_APP_IDS = ["apple", "banana"];

export const setAppIdClaim = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError("unauthenticated", "You are not authenticated");
    }

    const { appId } = request.data as { appId?: string };

    if (!appId || !ALLOWED_APP_IDS.includes(appId)) {
        throw new HttpsError("invalid-argument", "Invalid appId");
    }

    const uid = request.auth.uid;

    await admin.auth().setCustomUserClaims(uid, { appId });

    return { success: true };
});