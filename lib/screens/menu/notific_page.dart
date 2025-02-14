import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const NotificationList(),
    );
  }
}

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "Congratulations, John!",
      "description": "Keep up the fantastic work!",
      "icon": Icons.emoji_events,
      "time": "Now",
      "isNew": true,
    },
    {
      "title": "Aska challenges you to a plank challenge!",
      "description": "See who can hold the longest. Are you up for it?",
      "icon": Icons.fitness_center,
      "time": "1 min",
      "isNew": true,
    },
    {
      "title": "Exciting news!",
      "description": "Challenge yourself today!",
      "icon": Icons.star,
      "time": "12 min",
      "isNew": false,
    },
    {
      "title": "You're making great progress, John!",
      "description": "Your consistency is paying off. Keep it up!",
      "icon": Icons.thumb_up,
      "time": "1 h",
      "isNew": false,
    },
    {
      "title": "Exclusive offer for our loyal users!",
      "description":
          "Upgrade to premium and unlock personalized workout plans. Limited time only!",
      "icon": Icons.mail_outline,
      "time": "1 h",
      "isNew": false,
    },
    {
      "title": "Rest is just as important as exercise.",
      "description":
          "Don't forget to give your body the rest it deserves today. You've earned it!",
      "icon": Icons.bedtime,
      "time": "2 h",
      "isNew": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, const Color.fromARGB(255, 0, 0, 0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                notifications[index]["isNew"] = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Notification '${notification['title']}' marked as read.",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: notification["isNew"]
                    ? Colors.grey[850]
                    // ignore: deprecated_member_use
                    : Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (notification["isNew"])
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    notification["icon"],
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                title: Text(
                  notification["title"],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification["description"],
                        style: TextStyle(color: Colors.grey[300], fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notification["time"],
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {
                    _showOptions(context, index);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.blue),
                title: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    notifications.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.mark_as_unread, color: Colors.yellow),
                title: const Text(
                  "Mark as Unread",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    notifications[index]["isNew"] = true;
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading:
                    const Icon(Icons.notifications_off, color: Colors.grey),
                title: const Text(
                  "Turn off Notifications",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
