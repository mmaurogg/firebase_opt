import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_otp/config/flavors.dart';

class RealTimeDbService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Stream<int?> getStock(String productId) {
    final appId = F.appFlavor.name;
    return _dbRef.child('stock/$appId/$productId').onValue.map((event) {
      final data = event.snapshot.value;
      //final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      if (data != null) {
        //return data.map((key, value) => MapEntry(key.toString(), value as int));
        return data as int;
      } else {
        //return null;
      }
    });
  }

  Future<void> decrementStock(String productId) async {
    final productRef = _dbRef.child('stock/$productId');
    await productRef.runTransaction((currentValue) {
      final current = (currentValue as int?) ?? 0;
      if (current <= 0) return Transaction.abort();
      return Transaction.success(current - 1);
    });
  }
}
