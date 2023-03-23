import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final String? userId;

  UserService({required this.userId});

  CollectionReference<Map<String, dynamic>> get savedVehicles {
    if (userId == null) {
      throw Exception('User not logged in.');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('saved_vehicles');
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get savedVehiclesStream {
    return savedVehicles.snapshots();
  }
}
