import 'package:flutter/material.dart';
import 'main_bottom/main_navigation_page.dart';
import 'analytics_page.dart';
import 'home_page.dart';
import 'games_page.dart';
import 'profile_setting/setting_profile.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final List<Map<String, dynamic>> posts = [
    {'video': 'assets/sample_post.png', 'certificates': 3},
    {'video': 'assets/sample_post.png', 'certificates': 5},
    {'video': 'assets/sample_post.png', 'certificates': 1},
    {'video': 'assets/sample_post.png', 'certificates': 0},
  ];

  int _selectedTabIndex = 4;

  void _onTabSelected(int index) {
    if (index == _selectedTabIndex) return;

    setState(() {
      _selectedTabIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GamesPage()));
        break;
      case 2:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MainNavigationPage()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AnalyticsPage()));
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) =>
                    false, // This removes all previous routes from the stack
              );
            },
          ),
          title:
              const Text("@user_name", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingProfilePage()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "POST"),
              Tab(text: "STATS"),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          children: [
            _buildPostsTab(),
            _buildStatsTab(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedTabIndex: _selectedTabIndex,
          onTabSelected: _onTabSelected,
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/profile_picture.png'),
          ),
          const SizedBox(height: 10),
          const Text(
            "@user_name",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "0 Following   0 Followers   0 Likes",
            style: TextStyle(color: Colors.grey[400]),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No bio yet",
                style: TextStyle(color: Colors.grey[400]),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  // Edit profile action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    if (posts.isEmpty) {
      return const Center(
        child: Text(
          "No posts yet",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return Column(
      children: [
        _buildProfileHeader(),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(post['video']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (post['certificates'] > 0)
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Chip(
                        label: Text(
                          "${post['certificates']} Certificates",
                          style: const TextStyle(color: Colors.white),
                        ),
                        // ignore: deprecated_member_use
                        backgroundColor: Colors.blue.withOpacity(0.8),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatsTab() {
    return Column(
      children: [
        _buildProfileHeader(),
        const SizedBox(height: 10),
        Expanded(
          child: const Center(
            child: Text(
              "Stats coming soon!",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isSpecial ? 60 : 50,
        width: isSpecial ? 60 : 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
