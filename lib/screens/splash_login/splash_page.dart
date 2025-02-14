import 'package:flutter/material.dart';
import 'dart:async';
import 'first_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the first screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => FirstScreen()),
      );
    });

    return Scaffold(
      body: Container(
        color: Colors.black, // Solid black background
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or splash image with a fade-in animation
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Image.asset(
                  "assets/images/splash.png",
                  width: 250, // Adjusted size for better visual balance
                  height: 250,
                ),
              ),
              SizedBox(height: 30),

              // Circular progress indicator with custom styling
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 6, // Thicker stroke for modern look
              ),
            ],
          ),
        ),
      ),
    );
  }
}
