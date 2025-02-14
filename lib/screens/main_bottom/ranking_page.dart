import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  bool isFaceRecognitionDone = false;
  bool isAnalyzing = false;
  List<Map<String, String>> playerResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking Page"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeaderSection(),
            const SizedBox(height: 20),
            isAnalyzing ? _buildAnalyzingSection() : _buildShowSkillsButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          Text(
            "Welcome to Ranking Page",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "Analyze match videos and view player rankings.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildShowSkillsButton() {
    return ElevatedButton(
      onPressed: _onShowSkillsButtonPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "Show Your Skills",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  void _onShowSkillsButtonPressed() async {
    final choice = await _showAnalysisChoiceDialog();
    if (choice == "skills") {
      _startPlayerSkillsAnalysis();
    } else if (choice == "match") {
      final videoSelected = await _selectVideoForAnalysis();
      if (videoSelected) {
        _startMatchAnalysis();
      }
    }
  }

  Future<String?> _showAnalysisChoiceDialog() async {
    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose Analysis Type"),
          content: const Text(
              "Would you like to analyze only the player's skills or the entire match?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, "skills"),
              child: const Text("Player's Skills"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, "match"),
              child: const Text("Entire Match"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _selectVideoForAnalysis() async {
    // Simulate video selection process
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Select Video"),
              content: const Text("Please select a video for match analysis."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Select"),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _startPlayerSkillsAnalysis() {
    setState(() {
      isAnalyzing = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isAnalyzing = false;
      });

      // Navigate to the profile skills page
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/profile_skill_page');
    });
  }

  void _startMatchAnalysis() {
    setState(() {
      isAnalyzing = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isAnalyzing = false;
      });

      // Navigate to the profile skills page with match analysis data
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/profile_skill_page', arguments: {
        "analysisType": "match",
      });
    });
  }

  Widget _buildAnalyzingSection() {
    return Column(
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text(
          "Analyzing video...",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }
}
