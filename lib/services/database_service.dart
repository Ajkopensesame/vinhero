import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static Future<void> saveVehicleToProfile(String vin) async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Get a reference to the user's document in the users collection
    DocumentReference userDocRef =
    FirebaseFirestore.instance.collection('users').doc(userId);

    // Update the saved_vehicles field to include the new VIN
    await userDocRef.update({'saved_vehicles': FieldValue.arrayUnion([vin])});
  }
}
