import 'package:flutter/material.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Background color
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: _buildTimeline(),
      ),
    );
  }

  List<Widget> _buildTimeline() {
    final List<Map<String, dynamic>> events = [
      {"time": "FT", "score": "2-0", "isDivider": true},
      {
        "time": "86'",
        "icon": Icons.swap_horiz,
        "playerIn": "Pablo Rosario",
        "playerOut": "Hicham Boudaoui"
      },
      {
        "time": "84'",
        "icon": Icons.swap_horiz,
        "playerIn": "Evann Guessand",
        "playerOut": "Gaetan Laborde"
      },
      {
        "time": "84'",
        "icon": Icons.warning,
        "event": "Foul",
        "player": "Ibrahima Sissoko"
      },
      {
        "time": "83'",
        "icon": Icons.swap_horiz,
        "playerIn": "Evann Guessand",
        "playerOut": "Gaetan Laborde"
      },
      {
        "time": "82'",
        "icon": Icons.swap_horiz,
        "playerIn": "Evann Guessand",
        "playerOut": "Gaetan Laborde"
      },
      {"time": "77'", "icon": Icons.sports_soccer, "score": "2-0"},
      {
        "time": "68'",
        "icon": Icons.swap_horiz,
        "playerIn": "Evann Guessand",
        "playerOut": "Gaetan Laborde"
      },
      {
        "time": "64'",
        "icon": Icons.swap_horiz,
        "playerIn": "Marvin Sanaya",
        "playerOut": "Loubadhe Abakar Sylla"
      },
      {"time": "FT", "score": "1-0", "isDivider": true},
      {"time": "45+2'", "icon": Icons.sports_soccer, "score": "1-0"},
      {
        "time": "6'",
        "icon": Icons.swap_horiz,
        "playerIn": "Evann Guessand",
        "playerOut": "Gaetan Laborde"
      },
    ];

    return events.map((event) {
      if (event["isDivider"] == true) {
        return _matchDivider(event["score"]);
      }

      return _timelineEvent(
        time: event["time"],
        icon: event["icon"],
        playerIn: event["playerIn"],
        playerOut: event["playerOut"],
        event: event["event"],
        score: event["score"],
      );
    }).toList();
  }

  Widget _matchDivider(String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[700])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "FT $score",
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _timelineEvent({
    required String time,
    IconData? icon,
    String? playerIn,
    String? playerOut,
    String? event,
    String? score,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(time,
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child:
                icon != null ? Icon(icon, color: Colors.white, size: 16) : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (playerIn != null && playerOut != null)
                  Text(
                    "In: $playerIn\nOut: $playerOut",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                if (event != null && playerIn != null)
                  Text(
                    "$playerIn - $event",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                if (score != null)
                  Text(
                    score,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
