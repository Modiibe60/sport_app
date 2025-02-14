import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = "English (USA)";

  final List<String> languages = [
    "English (USA)",
    "English (UK)",
    "Indonesia",
    "Español",
    "Français",
    "Italiano",
    "Chinese"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true, // This centers the title
        title: const Text(
          'Language Options.',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text("Your Current Language",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          ListTile(
            title: Text(selectedLanguage,
                style: const TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.check, color: Colors.redAccent),
          ),
          const Divider(color: Colors.grey),
          const Text("All Languages",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          ...languages.map((language) => _buildLanguageTile(language)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement language change logic
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Change Language",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(String language) {
    return ListTile(
      title: Text(language, style: const TextStyle(color: Colors.white)),
      trailing: selectedLanguage == language
          ? const Icon(Icons.check, color: Colors.redAccent)
          : null,
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
      },
    );
  }
}
