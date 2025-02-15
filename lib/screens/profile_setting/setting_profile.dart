import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'edit_profile_page.dart';
import 'faq_page.dart';
import 'notifications_page.dart';
import 'language_page.dart';

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingProfilePageState createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  File? _profileImage;

  // Future<void> _pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _profileImage = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          // Profile Picture
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const NetworkImage('https://via.placeholder.com/150')
                          as ImageProvider,
                ),
                const SizedBox(height: 10),
                // TextButton(
                //   onPressed: _pickImage,
                //   child: const Text(
                //     'Change Photo',
                //     style: TextStyle(
                //         color: Colors.redAccent,
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildSettingsCard(),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () => Navigator.push(context,
                _pageRoute(EditProfilePage(profileImage: _profileImage))),
          ),
          _buildListTile(
            icon: Icons.question_answer,
            title: 'FAQ',
            onTap: () => Navigator.push(context, _pageRoute(const FAQPage())),
          ),
          _buildListTile(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () =>
                Navigator.push(context, _pageRoute(const NotificationsPage())),
          ),
          _buildListTile(
            icon: Icons.language,
            title: 'Language Options',
            onTap: () =>
                Navigator.push(context, _pageRoute(const LanguagePage())),
          ),
        ],
      ),
    );
  }
}

Widget _buildListTile(
    {required IconData icon,
    required String title,
    required VoidCallback onTap}) {
  return Column(
    children: [
      ListTile(
        leading: Icon(icon, color: Colors.white, size: 26),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        onTap: onTap,
      ),
      Divider(color: Colors.grey.shade800, thickness: 0.5),
    ],
  );
}

PageRouteBuilder _pageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    },
  );
}
