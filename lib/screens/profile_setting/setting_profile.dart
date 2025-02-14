import 'package:flutter/material.dart';

class SettingProfilePage extends StatelessWidget {
  const SettingProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to Edit Profile Page
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150', // Replace with actual image
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Implement Change Photo functionality
                  },
                  child: Text(
                    'Change Photo',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              // Navigate to My Profile Page
            },
          ),
          ListTile(
            leading: Icon(Icons.details),
            title: Text('Details'),
            onTap: () {
              // Navigate to Details Page
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('General Settings'),
            onTap: () {
              // Navigate to General Settings Page
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language Options'),
            onTap: () {
              // Navigate to Language Options Page
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Rate Us'),
            onTap: () {
              // Implement Rate Us functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help Center'),
            onTap: () {
              // Navigate to Help Center Page
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {
              // Navigate to Feedback Page
            },
          ),
        ],
      ),
    );
  }
}
