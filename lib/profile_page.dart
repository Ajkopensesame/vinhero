import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vinhero/profile_header.dart';
import 'package:vinhero/services/user_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _savedVehiclesStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userService = UserService(userId: user.uid);
      _savedVehiclesStream = userService.savedVehiclesStream;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          ProfileHeader(),
          SizedBox(height: 16.0),
          Expanded(
            child: _savedVehiclesStream == null
                ? Center(child: Text('No user is logged in.'))
                : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _savedVehiclesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Center(child: Text('An error occurred.'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No saved vehicles.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
                    final vehicleData = document.data()['vehicleData'];
                    final make = vehicleData['Make'] ?? 'Unknown';
                    final model = vehicleData['Model'] ?? 'Unknown';
                    final year = vehicleData['Model Year'] ?? 'Unknown';
                    return ListTile(
                      title: Text('$make $model $year'),
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
