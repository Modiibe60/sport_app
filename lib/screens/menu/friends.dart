import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  int _selectedTabIndex = 0;

  Future<List<Map<String, String>>> fetchFriendsList() async {
    // Simulate a database or API call for friends list
    await Future.delayed(const Duration(seconds: 2)); // Simulated delay
    return [
      {"name": "AHMED MAHMOUD", "status": "now"},
      {"name": "ZXZZZ XXXXX", "status": "Last login: 20 hours ago"},
      {"name": "SSSS MAHMOUD", "status": "Last login: 2 hours ago"},
      {"name": "MODY MAHMOUD", "status": "now"},
    ];
  }

  Future<List<Map<String, String>>> fetchFriendRequests() async {
    // Simulate a database or API call for friend requests
    await Future.delayed(const Duration(seconds: 2)); // Simulated delay
    return [
      {"name": "AHMED MAHMOUD"},
      {"name": "ENG MEKO"},
      {"name": "mejor mohamed"},
    ];
  }

  void _acceptRequest(String name) {
    setState(() {
      // Update the state to reflect acceptance (for local testing)
      // Normally, you would send a request to the backend to update the database
    });
  }

  void _rejectRequest(String name) {
    setState(() {
      // Update the state to reflect rejection (for local testing)
      // Normally, you would send a request to the backend to update the database
    });
  }

  Widget _buildFriendsList() {
    return FutureBuilder<List<Map<String, String>>>(
      future: fetchFriendsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching friends list"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No friends found"));
        }

        final friendsList = snapshot.data!;
        return ListView.builder(
          itemCount: friendsList.length,
          itemBuilder: (context, index) {
            final friend = friendsList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://via.placeholder.com/50"), // Placeholder image
              ),
              title: Text(friend["name"]!,
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                friend["status"]!,
                style: TextStyle(
                  color:
                      friend["status"] == "now" ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Navigate to friend's profile or chat (implement as needed)
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFriendRequests() {
    return FutureBuilder<List<Map<String, String>>>(
      future: fetchFriendRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching friend requests"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No friend requests"));
        }

        final friendRequests = snapshot.data!;
        return ListView.builder(
          itemCount: friendRequests.length,
          itemBuilder: (context, index) {
            final request = friendRequests[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://via.placeholder.com/50"), // Placeholder image
              ),
              title: Text(request["name"]!,
                  style: const TextStyle(color: Colors.white)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () => _acceptRequest(request["name"]!),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () => _rejectRequest(request["name"]!),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("friends", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _selectedTabIndex = 0),
                  child: Column(
                    children: [
                      Text(
                        "Friends list",
                        style: TextStyle(
                          color: _selectedTabIndex == 0
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_selectedTabIndex == 0)
                        Container(
                          height: 3,
                          width: 60,
                          color: Colors.blue,
                        )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _selectedTabIndex = 1),
                  child: Column(
                    children: [
                      Text(
                        "Requests",
                        style: TextStyle(
                          color: _selectedTabIndex == 1
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_selectedTabIndex == 1)
                        Container(
                          height: 3,
                          width: 60,
                          color: Colors.blue,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildFriendsList()
                : _buildFriendRequests(),
          ),
        ],
      ),
    );
  }
}
