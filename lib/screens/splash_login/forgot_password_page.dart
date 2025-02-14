import 'package:flutter/material.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool emailSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: emailSent ? _buildEmailSentUI() : _buildResetPasswordUI(),
        ),
      ),
    );
  }

  Widget _buildResetPasswordUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reset password",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "We will send you an email with instructions. If you use the same email as your Google account, you can sign in.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1E1E1E),
            hintText: "Enter your email",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _onSendInstructionsPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0056FF),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Center(
            child: Text(
              "Send Instructions",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            // Add interactive "Sign in" functionality
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: const Text(
            "Sign in",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailSentUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.email, size: 100, color: Colors.blue),
        const SizedBox(height: 20),
        const Text(
          "Check your email",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "We have sent a password recovery link to ${_emailController.text}",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add open email app functionality
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0056FF),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text(
            "Open email app",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            // Add skip functionality
          },
          child: const Text(
            "Skip, I'll confirm later",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            // Add "Try another email" functionality
            setState(() {
              emailSent = false;
            });
          },
          child: const Text(
            "Try another email",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  void _onSendInstructionsPressed() {
    if (_emailController.text.isNotEmpty &&
        _emailController.text.contains("@")) {
      setState(() {
        emailSent = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
