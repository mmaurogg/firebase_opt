import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { getDatabase } from "firebase-admin/database";

export const onOrderCreated = onDocumentCreated("orders/{orderId}", async (event) => {
    const snapshot = event.data;
    const order = snapshot?.data();

    if (!order) {
        return;
    }

    const { appId, productId, quantity } = order as { appId: string, productId: string, quantity: number };

    if (!appId || !productId || !quantity) {
        return;
    }

    const stockRef = getDatabase().ref('stock').child(appId).child(productId);

    await stockRef.transaction((currentStock) => {
        if (currentStock === null) {
            return null;
        }
        if (currentStock < quantity) {
            return null;
        }
        return currentStock - quantity;
    });

});