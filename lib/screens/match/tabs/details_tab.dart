import 'package:flutter/material.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _highlightedPlayer(),
          const SizedBox(height: 20),
          _highestRatedPlayers(),
        ],
      ),
    );
  }

  Widget _highlightedPlayer() {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "The Best Player of the Match",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage:
                    NetworkImage("https://via.placeholder.com/150"),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Mohamed Salah",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text("Rating: 8.6",
                      style: TextStyle(color: Colors.blue, fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _highestRatedPlayers() {
    final players = [
      {"name": "Mohamed Salah", "rating": "8.6"},
      {"name": "Trent Alexander-Arnold", "rating": "8.4"},
      {"name": "Virgil van Dijk", "rating": "8.3"},
      {"name": "Alisson Becker", "rating": "8.2"},
    ];

    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Highest Rated Players",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Column(
            children: players.map((player) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage:
                      NetworkImage("https://via.placeholder.com/150"),
                ),
                title: Text(player["name"]!,
                    style: const TextStyle(color: Colors.white)),
                trailing: Text(player["rating"]!,
                    style: const TextStyle(color: Colors.blue)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
