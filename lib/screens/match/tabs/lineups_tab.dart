import 'package:flutter/material.dart';

class LineupsTab extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LineupsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for the full container
      body: Stack(
        children: [
          // Football field layout
          Positioned.fill(
            child: CustomPaint(
              painter: FootballFieldPainter(),
            ),
          ),
          // Players Positioned on the field
          _buildPlayers(context),
        ],
      ),
    );
  }

  Widget _buildPlayers(BuildContext context) {
    final List<Map<String, dynamic>> players = [
      // Red Team (Left Side, facing Blue Team)
      {
        "name": "M. Lamb",
        "number": "32",
        "x": 0.5,
        "y": 0.08,
        "color": Colors.red
      },
      {
        "name": "K. West",
        "number": "4",
        "x": 0.2,
        "y": 0.2,
        "color": Colors.red
      },
      {
        "name": "M. Keynote",
        "number": "18",
        "x": 0.4,
        "y": 0.2,
        "color": Colors.red
      },
      {
        "name": "A. Smith",
        "number": "3",
        "x": 0.6,
        "y": 0.2,
        "color": Colors.red
      },
      {
        "name": "K. Kinsey",
        "number": "6",
        "x": 0.8,
        "y": 0.2,
        "color": Colors.red
      },
      {
        "name": "K. Kinsey",
        "number": "6",
        "x": 0.8,
        "y": 0.4,
        "color": Colors.red
      },
      {
        "name": "D. Partey",
        "number": "34",
        "x": 0.3,
        "y": 0.3,
        "color": Colors.red
      },
      {
        "name": "G. Marten",
        "number": "5",
        "x": 0.7,
        "y": 0.3,
        "color": Colors.red
      },
      {
        "name": "K. West",
        "number": "8",
        "x": 0.35,
        "y": 0.4,
        "color": Colors.red
      },

      {
        "name": "A. Smith",
        "number": "35",
        "x": 0.65,
        "y": 0.4,
        "color": Colors.red
      },
      {
        "name": "A. Heard",
        "number": "9",
        "x": 0.5,
        "y": 0.3,
        "color": Colors.red
      },

      // Blue Team (Right Side, facing Red Team)
      {
        "name": "M. Lamb",
        "number": "32",
        "x": 0.1,
        "y": 0.5,
        "color": Colors.blue
      },
      {
        "name": "K. West",
        "number": "8",
        "x": 0.5,
        "y": 0.75,
        "color": Colors.blue
      },
      {
        "name": "A. Smith",
        "number": "35",
        "x": 0.9,
        "y": 0.5,
        "color": Colors.blue
      },
      {
        "name": "M. Keynote",
        "number": "7",
        "x": 0.3,
        "y": 0.5,
        "color": Colors.blue
      },
      {
        "name": "K. Kinsey",
        "number": "3",
        "x": 0.7,
        "y": 0.5,
        "color": Colors.blue
      },
      {
        "name": "G. Marten",
        "number": "5",
        "x": 0.7,
        "y": 0.6,
        "color": Colors.blue
      },
      {
        "name": "D. Partey",
        "number": "34",
        "x": 0.5,
        "y": 0.5,
        "color": Colors.blue
      },
      {
        "name": "K. West",
        "number": "14",
        "x": 0.35,
        "y": 0.6,
        "color": Colors.blue
      },
      {
        "name": "A. Smith",
        "number": "27",
        "x": 0.5,
        "y": 0.6,
        "color": Colors.blue
      },
      {
        "name": "M. Keynote",
        "number": "6",
        "x": 0.9,
        "y": 0.6,
        "color": Colors.blue
      },
      {
        "name": "M. Keynote",
        "number": "6",
        "x": 0.1,
        "y": 0.6,
        "color": Colors.blue
      },
    ];

    return Stack(
      children: players.map((player) {
        return Positioned(
          left: player["x"] * MediaQuery.of(context).size.width - 20,
          top: player["y"] * MediaQuery.of(context).size.height - 20,
          child: Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: player["color"],
                child: Text(
                  player["number"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                player["name"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// الملعب
class FootballFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fieldPaint = Paint()..color = Colors.blueGrey[900]!;
    final Paint linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw the field background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), fieldPaint);

    // Half-way line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      linePaint,
    );

    // Center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height * 0.08,
      linePaint,
    );

    // Penalty Boxes and Goals
    double goalWidth = size.width * 0.15;
    double penaltyWidth = size.width * 0.34;
    double penaltyHeight = size.height * 0.10;

    // Top Goal Area
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 2 - goalWidth / 2,
        0,
        goalWidth,
        size.height * 0.05,
      ),
      linePaint,
    );

    // Bottom Goal Area
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 2 - goalWidth / 2,
        size.height - size.height * 0.05,
        goalWidth,
        size.height * 0.05,
      ),
      linePaint,
    );

    // Top Penalty Box
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 2 - penaltyWidth / 2,
        0,
        penaltyWidth,
        penaltyHeight,
      ),
      linePaint,
    );

    // Bottom Penalty Box
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 2 - penaltyWidth / 2,
        size.height - penaltyHeight,
        penaltyWidth,
        penaltyHeight,
      ),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
