import 'package:flutter/material.dart';

class PlayerInfoPage extends StatelessWidget {
  final String playerName;

  PlayerInfoPage({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(playerName,
            style: TextStyle(color: Colors.white)), // Show player name
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage("https://via.placeholder.com/150"),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Player Stats for $playerName",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const Divider(color: Colors.grey),
            _playerStats(),
          ],
        ),
      ),
    );
  }

  Widget _playerStats() {
    return Column(
      children: const [
        ListTile(
          title: Text("Total minutes played",
              style: TextStyle(color: Colors.white)),
          trailing: Text("90", style: TextStyle(color: Colors.blue)),
        ),
        ListTile(
          title: Text("Goals Prevented", style: TextStyle(color: Colors.white)),
          trailing: Text("0.13", style: TextStyle(color: Colors.blue)),
        ),
        ListTile(
          title: Text("Accurate Passes", style: TextStyle(color: Colors.white)),
          trailing: Text("14/18 (78%)", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
