import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vin Hero'),
      ),
      body: Stack(
          children: [
      Container(
      decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/vin_hero.png'),
      fit: BoxFit.cover,
    ),
    ),
    ),
    GridView.count(
    crossAxisCount: 2,
    padding: EdgeInsets.all(20.0),
    crossAxisSpacing: 20.0,
    mainAxisSpacing: 20.0,
        children: [
          _buildFeatureButton(
            context,
            icon: FontAwesomeIcons.user,
            label: 'My Profile',
            onPressed: () {Navigator.pushNamed(context, '/profile_page');},
          ),
          _buildFeatureButton(
            context,
            icon: FontAwesomeIcons.barcode,
            label: 'VIN Decoder',
            onPressed: () {Navigator.pushNamed(context, '/vin_decoder');
              },
          ),
          _buildFeatureButton(
            context,
            icon: FontAwesomeIcons.commentDollar,
            label: 'Quotes',
            onPressed: () {Navigator.pushNamed(context, '/quotes_page');
              // Add navigation to Quotes
            },
          ),
          _buildFeatureButton(
            context,
            icon: FontAwesomeIcons.wrench,
            label: 'Fixed',
            onPressed: () {Navigator.pushNamed(context, '/fixed_page');
              // Add navigation to Fixed
            },
          ),
          _buildFeatureButton(
            context,
            icon: FontAwesomeIcons.comments,
            label: 'Chat',
            onPressed: () {Navigator.pushNamed(context, '/chat_page');
              // Add navigation to Chat
            },
          ),
          _buildFeatureButton(
            context,
            icon: FontAwesomeIcons.book,
            label: 'Logbook',
            onPressed: () {Navigator.pushNamed(context, '/logbook_page');
              // Add navigation to Logbook
            },
          ),
          _buildFeatureButton(
            context,
            icon: FontAwesomeIcons.cogs,
            label: 'Parts',
            onPressed: () {Navigator.pushNamed(context, '/parts_page');
              // Add navigation to Parts
            },
          ),
          _buildFeatureButton(
            context,
            icon: FontAwesomeIcons.carAlt,
            label: 'OBD2',
            onPressed: () {Navigator.pushNamed(context, '/obd2_page');
              // Add navigation to OBD2
            },
          ),
        ],
      ),
  ]));
  }

  Widget _buildFeatureButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
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
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
