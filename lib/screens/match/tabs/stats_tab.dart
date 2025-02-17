import 'package:flutter/material.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: _buildStatBars(),
      ),
    );
  }

  List<Widget> _buildStatBars() {
    final List<Map<String, dynamic>> stats = [
      {"title": "Ball Possession (%)", "team1": 10, "team2": 90},
      {"title": "Shots on Target", "team1": 1, "team2": 2},
      {"title": "Shots off Target", "team1": 3, "team2": 0},
      {"title": "Corner Kicks", "team1": 3, "team2": 3},
      {"title": "Fouls", "team1": 3, "team2": 6},
      {"title": "Yellow Cards", "team1": 3, "team2": 3},
      {"title": "Throw-in(s)", "team1": 16, "team2": 7},
      {"title": "Crosses", "team1": 7, "team2": 7},
      {"title": "Counter Attacks", "team1": 1, "team2": 1},
      {"title": "Goalkeeper Saves", "team1": 2, "team2": 2},
      {"title": "Goal Kicks", "team1": 4, "team2": 2},
      {"title": "Other Stat", "team1": 3, "team2": 0},
      {"title": "Other Stat", "team1": 3, "team2": 6},
      {"title": "Other Stat", "team1": 2, "team2": 2},
    ];

    int maxValue = stats.fold<int>(
      0,
      (max, stat) => stat["team1"] > max || stat["team2"] > max
          ? (stat["team1"] > stat["team2"] ? stat["team1"] : stat["team2"])
          : max,
    );

    return stats.map((stat) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${stat['team1']}",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      stat["title"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  "${stat['team2']}",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Bar Graph
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[800],
                  ),
                ),
                Row(
                  children: [
                    _teamStatBar(stat["team1"], maxValue, Colors.blue),
                    _teamStatBar(stat["team2"], maxValue, Colors.grey),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _teamStatBar(int value, int maxValue, Color color) {
    double widthFactor = maxValue == 0 ? 0 : value / maxValue;
    return Expanded(
      flex: (widthFactor * 100).toInt(),
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
      ),
    );
  }
}
