import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vinhero/profile_header.dart';
import 'package:vinhero/vehicle_details_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          ProfileHeader(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .collection('saved_vehicles')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot vehicleDoc = snapshot.data!.docs[index];
                    Map<String, dynamic>? vehicleData = vehicleDoc.get('vehicleData') as Map<String, dynamic>?;

                    print('Debug: Vehicle Data: $vehicleData'); // Added this line
                    print('Debug: Firestore Field Names: ${vehicleData?.keys}');

                    String year = vehicleData?['Model Year']?.toString() ?? 'Unknown Year';
                    String make = vehicleData?['Make'] ?? 'Unknown Make';
                    String model = vehicleData?['Model'] ?? 'Unknown Model';

                    print('Debug: Year: $year, Make: $make, Model: $model'); // Added this line

                    return ListTile(
                      title: Text('$year $make $model'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VehicleDetailsPage(
                              vehicleDoc: vehicleDoc,
                              vehicleData: vehicleData as Map<dynamic, dynamic>,
                              make: make,
                              vin: vehicleData?['VIN'],
                              model: model,
                              year: year,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
