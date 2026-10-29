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
}
