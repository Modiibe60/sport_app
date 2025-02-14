import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileSkillPage extends StatefulWidget {
  const ProfileSkillPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileSkillPageState createState() => _ProfileSkillPageState();
}

class _ProfileSkillPageState extends State<ProfileSkillPage> {
  bool _isFaceRecognitionDone = false;

  final Map<String, dynamic> _playerData = {
    "name": "John Doe",
    "position": {"primary": "ST", "secondary": "LW"},
    "stats": {"championships": "2", "minigames": "10"},
    "skills": {
      "Speed": 4.5,
      "Shooting": 3.5,
      "Dribbling": 4.0,
      "Passing": 3.8,
      "Defense": 4.2,
      "Stamina": 4.0,
    },
    "performance": [
      FlSpot(0, 1),
      FlSpot(1, 1.5),
      FlSpot(2, 1.2),
      FlSpot(3, 1.8),
      FlSpot(4, 1.5),
      FlSpot(5, 2),
      FlSpot(6, 1.8),
    ],
  };

  void _checkFaceRecognition() {
    if (_isFaceRecognitionDone) {
      _startMatchAnalysis();
    } else {
      _showFaceRecognitionPrompt();
    }
  }

  void _startMatchAnalysis() {
    // Simulated analysis
    // ignore: avoid_print
    print("Match analysis started...");
    _showAnalysisResults();
  }

  void _showAnalysisResults() {
    setState(() {
      _isFaceRecognitionDone = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Analysis complete. Results and player skills updated."),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showFaceRecognitionPrompt() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Face recognition not done. Please complete it first.",
        ),
        action: SnackBarAction(
          label: 'Go to Face Recognition',
          onPressed: () {
            Navigator.pushNamed(context, '/faceRecognitionPage');
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player Profile"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildStatSection("Player Stats", _playerData['stats']),
            const SizedBox(height: 20),
            _buildStatSection("Position", _playerData['position']),
            const SizedBox(height: 20),
            _buildPerformanceSection(),
            const SizedBox(height: 20),
            _buildSkillsSection(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkFaceRecognition,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text("Show Your Skills"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage("https://via.placeholder.com/150"),
          ),
          const SizedBox(height: 10),
          Text(
            _playerData['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Professional Player",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatSection(String title, Map<String, String> stats) {
    return Column(
      children: [
        _buildSectionTitle(title),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: stats.entries.map((entry) {
            return _buildStatCard(entry.key, entry.value);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Column(
      children: [
        _buildSectionTitle("Performance"),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, _) {
                      const labels = ["Apr", "Jun", "Aug", "Oct", "Dec"];
                      return Text(labels[value.toInt() % labels.length]);
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  spots: _playerData['performance'],
                  belowBarData: BarAreaData(show: true),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    final skills = _playerData['skills'] as Map<String, double>;
    return Column(
      children: [
        _buildSectionTitle("Skills"),
        SizedBox(
          height: 300,
          child: RadarChart(
            RadarChartData(
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(color: Colors.blue, width: 2),
              tickBorderData: const BorderSide(color: Colors.grey, width: 1),
              gridBorderData: const BorderSide(color: Colors.grey, width: 1),
              dataSets: [
                RadarDataSet(
                  // ignore: deprecated_member_use
                  fillColor: Colors.blue.withOpacity(0.3),
                  borderColor: Colors.blue,
                  dataEntries: skills.entries
                      .map((entry) => RadarEntry(value: entry.value))
                      .toList(),
                ),
              ],
              getTitle: (index, _) {
                return RadarChartTitle(
                  text: skills.keys.toList()[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
