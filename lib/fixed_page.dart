import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinhero/common_problems_page.dart';
import 'package:vinhero/services/user_service.dart';

class FixedPage extends StatefulWidget {
  const FixedPage({Key? key}) : super(key: key);

  @override
  _FixedPageState createState() => _FixedPageState();
}

class _FixedPageState extends State<FixedPage> {
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
          const SizedBox(height: 16.0),
          Expanded(
            child: _savedVehiclesStream == null
                ? const Center(child: Text('No user is logged in.'))
                : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _savedVehiclesStream!,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return const Center(
                    child: Text('An error occurred.'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final savedVehiclesDocs = snapshot.data!.docs;

                if (savedVehiclesDocs.isEmpty) {
                  return const Center(
                    child: Text('No saved vehicles.'),
                  );
                }

                return ListView.builder(
                  itemCount: savedVehiclesDocs.length,
                  itemBuilder: (context, index) {
                    final document = savedVehiclesDocs[index];

                    final vehicleData = document.get('vehicleData') as Map<String, dynamic>?;
                    final make = vehicleData?['Make'] ?? 'Unknown';
                    final model = vehicleData?['Model'] ?? 'Unknown';
                    final year = vehicleData?['Model Year'] ?? 'Unknown';
                    final vin = document.get('vin') ?? '';
                    final engine = vehicleData?['Engine'] ?? 'Unknown';


                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text('$make $model $year'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommonProblemsPage(
                                vin: vin,
                                make: make,
                                model: model,
                                year: year,
                                engine: engine,

                              ),
                            ),
                          );
                        },
                      ),
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
