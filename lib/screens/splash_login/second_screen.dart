import 'package:flutter/material.dart';
import 'login_page.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient with depth
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[800]!, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Language Selector
          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showLanguageSelector(context);
                  },
                  child: Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "English",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),

          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageIndicator(isActive: false),
                  _buildPageIndicator(isActive: true),
                ],
              ),
              const SizedBox(height: 16),

              // Card with text and button
              Container(
                padding: const EdgeInsets.all(25),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Compete with best players and analyze your skills.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // Button color
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white, // Arrow color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Language Selector Dialog
  void _showLanguageSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("English"),
                onTap: () {
                  Navigator.of(context).pop();
                  // Set English language logic here
                },
              ),
              ListTile(
                title: const Text("Arabic"),
                onTap: () {
                  Navigator.of(context).pop();
                  // Set Arabic language logic here
                },
              ),
              ListTile(
                title: const Text("Français"),
                onTap: () {
                  Navigator.of(context).pop();
                  // Set French language logic here
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Page Indicator Widget
  Widget _buildPageIndicator({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
