import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true, // This centers the title
        title: const Text(
          'FAQ.',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Questions",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFAQItem("How can I reset my password?",
                "Go to the login page and click 'Forgot Password'."),
            _buildFAQItem("How can I change my email?",
                "Navigate to settings and update your email."),
            _buildFAQItem("How can I unsubscribe from emails?",
                "Go to notification settings and disable emails."),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      backgroundColor: Colors.grey[900],
      collapsedBackgroundColor: Colors.grey[850],
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      textColor: Colors.white,
      collapsedTextColor: Colors.white,
      title: Text(question, style: const TextStyle(color: Colors.white)),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(answer, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
