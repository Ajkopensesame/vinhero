import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200.0,
          child: Image.network(
            'https://source.unsplash.com/800x200/?car',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Hero(
                tag: 'profile-image',
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                    'https://source.unsplash.com/100x100/?car',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // Implement edit profile functionality
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text('Email Address', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Logout'),
                        content: Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Implement logout functionality
                              Navigator.pop(context);
                            },
                            child: Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}