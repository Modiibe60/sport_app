import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileSkillPage extends StatefulWidget {
  const ProfileSkillPage({super.key});

  @override
  _ProfileSkillPageState createState() => _ProfileSkillPageState();
}

class _ProfileSkillPageState extends State<ProfileSkillPage> {
  final Map<String, dynamic> _playerData = {
    "name": "user_name",
    "position": {"primary": "ST", "secondary": "LW"},
    "stats": {
      "Total minutes played": "90",
      "Saves": "0",
      "Goals prevented": "0.13",
      "Touches": "22",
      "Accurate passes": "14/18 (78%)",
      "Shots on goal": "0",
      "Evasion attempts (successful)": "5 (1)",
    },
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
            _buildStatSection("Match Statistics", _playerData['stats']),
            const SizedBox(height: 20),
            // _buildPerformanceSection(),
            const SizedBox(height: 20),
            _buildSkillsSection(),
            const SizedBox(height: 20),
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
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          const SizedBox(height: 10),
          ...stats.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key, style: const TextStyle(color: Colors.white)),
                  Text(entry.value, style: const TextStyle(color: Colors.blue)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // Widget _buildPerformanceSection() {
  //   return Column(
  //     children: [
  //       _buildSectionTitle("Performance Over Time"),
  //       SizedBox(
  //         height: 200,
  //         child: LineChart(
  //           LineChartData(
  //             gridData: FlGridData(show: true),
  //             titlesData: FlTitlesData(
  //               leftTitles: AxisTitles(
  //                   sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
  //               bottomTitles: AxisTitles(
  //                 sideTitles: SideTitles(
  //                   showTitles: true,
  //                   reservedSize: 30,
  //                   getTitlesWidget: (value, _) {
  //                     const labels = ["Apr", "Jun", "Aug", "Oct", "Dec"];
  //                     return Text(labels[value.toInt() % labels.length]);
  //                   },
  //                 ),
  //               ),
  //             ),
  //             lineBarsData: [
  //               LineChartBarData(
  //                 isCurved: true,
  //                 spots: _playerData['performance'],
  //                 belowBarData: BarAreaData(show: true),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSkillsSection() {
    final skills = _playerData['skills'] as Map<String, double>;
    return Column(
      children: [
        _buildSectionTitle("Skill Ratings"),
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
