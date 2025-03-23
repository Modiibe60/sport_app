import 'dart:io';
import 'package:flutter/material.dart';

class PostVideoPage extends StatelessWidget {
  final File videoFile;
  const PostVideoPage({super.key, required this.videoFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Post Video"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Caption"),
            TextField(
              decoration: const InputDecoration(hintText: "Write a caption..."),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Switch(value: true, onChanged: (val) {}),
                const Text("Allow Duets"),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {}, // TODO: Implement posting logic
                child:
                    const Text("Post", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
