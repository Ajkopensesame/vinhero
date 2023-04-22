import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String? fullName;
  final String? email;
  final Function(String?, String?)? onUpdateProfile;

  const ProfileHeader({
    Key? key,
    this.fullName,
    this.email,
    this.onUpdateProfile,
  }) : super(key: key);

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
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                hintText: fullName,
                              ),
                              onChanged: (value) {
                                onUpdateProfile!(value, email);
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                hintText: email,
                              ),
                              onChanged: (value) {
                                onUpdateProfile!(fullName, value);
                              },
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName ?? '',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                email ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Implement logout functionality
                              Navigator.pop(context);
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}