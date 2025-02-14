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

  // Dummy Data
  final List<Map<String, String>> championships = [
    {"title": "SESSION I", "image": "assets/images/kick_soccer.png"},
  ];

  final List<Map<String, String>> minigames = [
    {"title": "Kick soccer ball.", "image": "assets/images/kick_soccer.png"},
    {"title": "Heading ball.", "image": "assets/images/heading_ball.png"},
  ];

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: const [
                  Text(
                    "points",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "0",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
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
            // Content Based on Selected Top Tab
            Expanded(
              child: selectedTopTab == 0
                  ? _buildGrid(championships)
                  : _buildGrid(minigames),
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

  Widget _buildGrid(List<Map<String, String>> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            // Show detailed task view when tapping a grid item
            showModalBottomSheet(
              context: context,
              builder: (context) => _buildTaskDetails(item),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      item["image"]!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item["title"]!,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "0 / 15",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskDetails(Map<String, String> task) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(task["image"]!, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(
            task["title"]!,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            "0 / 15",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/camera'); // Navigate to camera
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text("Start Now"),
          ),
        ],
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
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
