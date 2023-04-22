import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedVehicleList extends StatefulWidget {
  final List<Map<String, dynamic>> savedVehicles;

  const SavedVehicleList({Key? key, required this.savedVehicles}) : super(key: key);

  @override
  _SavedVehicleListState createState() => _SavedVehicleListState();
}

class _SavedVehicleListState extends State<SavedVehicleList> {
  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userDoc = snapshot.data!;
          final vehicles =
          List<Map<String, dynamic>>.from(userDoc['saved_vehicles']);

          return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];

              return Dismissible(
                key: Key(vehicle['vin']),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 16.0),
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) async {
                  vehicles.removeAt(index);

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .update({
                    'saved_vehicles': vehicles,
                  });
                },
                child: ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('${vehicle['make']} ${vehicle['model']}'),
                  subtitle: Text('VIN: ${vehicle['vin']}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Implement navigation to vehicle details page
                  },
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
