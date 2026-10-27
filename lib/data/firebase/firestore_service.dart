import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_otp/config/flavors.dart';
import 'package:firebase_otp/domain/models/product.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    final appId = F.appFlavor.name;

    return _firestore
        .collection('products')
        .where('appId', isEqualTo: appId)
        .snapshots()
        .map((snapshot) {
          final stream = snapshot.docs.where((e) => e.data().isNotEmpty).map((
            doc,
          ) {
            return Product.fromJson(doc.data());
          }).toList();

          return stream;
        });
  }

  Future<void> placeOrder({required String productId, required int quantity}) {
    final appId = F.appFlavor.name;
    return _firestore.collection('orders').add({
      'appId': appId,
      'productId': productId,
      'quantity': quantity,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
