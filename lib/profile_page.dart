import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage('https://example.com/profile-image.jpg'),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Name', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text('Email Address', style: TextStyle(fontSize: 16.0)),
                      TextButton(
                        onPressed: () {
                          // Implement logout functionality
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('My Vehicles', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text('Vehicle Make and Model'),
                    subtitle: Text('VIN: 12345678901234567'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to vehicle details page
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
