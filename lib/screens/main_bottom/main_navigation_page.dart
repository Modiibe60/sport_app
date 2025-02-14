import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/home_page.dart';
import 'ranking_page.dart';
import 'facial_recognition_flow.dart';
import 'skill_analysis_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const RankingPage(),
    const FacialRecognitionCameraFlow(),
    const ProfileSkillPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to HomePage instead of popping the current screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return false; // Prevent default back behavior
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: "Rankings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: "Recognition",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }
}
