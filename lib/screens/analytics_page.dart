import 'package:flutter/material.dart';
import 'match/match_details_page.dart';
import 'main_bottom/main_navigation_page.dart'; // Import your MainNavigationPage
import 'my_profile.dart'; // Import your MyProfilePage
import 'games_page.dart'; // Import your GamesPage
import 'home_page.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int selectedDateIndex = 3; // Default selected index for "Sat Today"
  final List<String> dates = ["Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue"];

  final List<Map<String, String>> matches = [
    {
      "team1": "team1",
      "team2": "team2",
      "score": "? - ?",
    },
    {
      "team1": "team1",
      "team2": "team2",
      "score": "? - ?",
    },
  ];

  void _openCalendar() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: CalendarDatePicker(
              initialDate: DateTime.now().isAfter(DateTime(2025, 1, 1))
                  ? DateTime(2025, 1, 1) // Ensure it's within the valid range
                  : DateTime.now(),
              firstDate: DateTime(2022),
              lastDate:
                  DateTime(2025, 12, 31), // Adjusted lastDate to a later time
              onDateChanged: (date) {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            "Analytics",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Date Tabs
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDateIndex = index;
                      });
                    },
                    child: Container(
                      width: 70,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: selectedDateIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dates[index],
                            style: TextStyle(
                              color: selectedDateIndex == index
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                          if (index == 3)
                            const Text(
                              "TODAY",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchDetailsPage(
                            matchTitle: match["team1"] ?? "Team 1",
                            matchSubtitle: match["team2"] ?? "Team 2",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              NetworkImage("https://via.placeholder.com/50"),
                        ),
                        title: Text(
                          "${match["team1"]} vs ${match["team2"]}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          match["score"] ?? "No Score",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        trailing: const Icon(
                          Icons.star_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: _openCalendar,
          child: const Icon(Icons.calendar_today, color: Colors.white),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedTabIndex: 3, // Index for Analytics tab
          onTabSelected: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamesPage()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainNavigationPage()),
                );
                break;
              case 3:
                // Already on Analytics page
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfilePage()),
                );
                break;
            }
          },
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
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
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
