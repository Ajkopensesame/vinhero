import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vinhero/safety_ratings_page.dart';

class VehicleDetailsPage extends StatelessWidget {
  final Map<dynamic, dynamic> vehicleData;
  final String make;

  const VehicleDetailsPage({
    required this.vehicleData,
    required this.make,
    Key? key,
    required dynamic vin,
    required dynamic model,
    required dynamic year,
    required DocumentSnapshot<Object?> vehicleDoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String model = vehicleData['Model'] ?? 'Unknown';
    final String year = vehicleData['Model Year'] ?? 'Unknown';
    final String assetPath =
        'assets/car_logos/logos/optimized/${make.toLowerCase()}.png';

    final String unsplashUrl =
        'https://source.unsplash.com/random/?car,${make.replaceAll(' ', '+')}';

    return Scaffold(
      appBar: AppBar(title: Text('Vehicle Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.network(unsplashUrl, width: double.infinity,
                  height: 250.0,
                  fit: BoxFit.cover),
              Positioned(
                bottom: 10,
                left: 10,
                child: Image.asset(assetPath, width: 100, fit: BoxFit.cover),
              ),
            ]),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/vin_hero.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                children: [
                  _buildFeatureButton(
                    context,
                    icon: FontAwesomeIcons.user,
                    label: 'Safety Ratings',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SafetyRatingsPage(
                                make: make,
                                model: model,
                                year: year,
                              ),
                        ),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    context,
                    icon: FontAwesomeIcons.barcode,
                    label: 'Recalls',
                    onPressed: () {},
                  ),
                  _buildFeatureButton(
                    context,
                    icon: FontAwesomeIcons.commentDollar,
                    label: 'Complaints',
                    onPressed: () {},
                  ),
                  _buildFeatureButton(
                    context,
                    icon: FontAwesomeIcons.wrench,
                    label: 'Car Seat Inspection Locator',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(BuildContext context,
      {required IconData icon,
        required String label,
        required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Theme
            .of(context)
            .primaryColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(icon, size: 40),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// provide code using proper python format to add the possible causes to each 'code' as above to the following code