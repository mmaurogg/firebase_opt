import * as admin from "firebase-admin";

admin.initializeApp();

export {setAppIdClaim} from "./auth/setAppIdClaim"
export {onOrderCreated} from "./orders/onOrderCreated"