import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Map<String, bool> notifications = {
    "News": true,
    "Promotion": false,
    "Community": true,
    "Telegram": false,
    "Email": true,
    "WhatsApp": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true, // This centers the title
        title: const Text(
          'Notifications.',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: notifications.keys.map((key) {
          return _buildNotificationTile(key, notifications[key]!);
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationTile(String title, bool isEnabled) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: Switch(
          value: isEnabled,
          activeColor: Colors.redAccent,
          onChanged: (value) {
            setState(() {
              notifications[title] = value;
            });
          },
        ),
      ),
    );
  }
}
