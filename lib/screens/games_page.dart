import 'package:flutter/material.dart';
import 'main_bottom/main_navigation_page.dart';
import 'my_profile.dart';
import 'analytics_page.dart';
import 'home_page.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  int selectedTabIndex = 1; // Default index for Games tab
  int selectedTopTab = 0; // 0: Championships, 1: Minigames

  void _onBottomTabSelected(int index) {
    if (index != selectedTabIndex) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          break;
        case 1:
          // Already on Games page
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainNavigationPage()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AnalyticsPage()),
          );
          break;
        case 4:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyProfilePage()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Playground",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
          ),
        ),
        body: Column(
          children: [
            // Top Tabs: Championships and Minigames
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTopTab("Championships", 0),
                  _buildTopTab("Minigames", 1),
                ],
              ),
            ),
            // "Coming Soon!" instead of game content
            Expanded(
              child: Center(
                child: Text(
                  "Coming soon!",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedTabIndex: selectedTabIndex,
          onTabSelected: _onBottomTabSelected,
        ),
      ),
    );
  }

  Widget _buildTopTab(String label, int index) {
    bool isSelected = selectedTopTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTopTab = index;
        });
      },
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavIcon(Icons.video_library, 0, selectedTabIndex == 0),
            _buildNavIcon(Icons.videogame_asset, 1, selectedTabIndex == 1),
            _buildNavIcon(Icons.dashboard, 2, selectedTabIndex == 2,
                isSpecial: true),
            _buildNavIcon(Icons.pie_chart, 3, selectedTabIndex == 3),
            _buildNavIcon(Icons.person, 4, selectedTabIndex == 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index, bool isSelected,
      {bool isSpecial = false}) {
    return Container(
      height: isSpecial ? 60 : 50,
      width: isSpecial ? 60 : 50,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        shape: BoxShape.circle,
        border: isSpecial
            ? Border.all(color: Colors.black, width: 4)
            : Border.all(color: Colors.transparent),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () => onTabSelected(index),
      ),
    );
  }
}
