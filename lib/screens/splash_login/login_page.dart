import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import '../home_page.dart';
import '../sign_up/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Fix for keyboard overflow
      body: SingleChildScrollView(
        // Makes content scrollable
        child: Container(
          height: MediaQuery.of(context).size.height, // Full screen height
          decoration: BoxDecoration(color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                // Language Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.language, color: Colors.white),
                      onPressed: () => _showLanguageSelector(context),
                    ),
                    SizedBox(width: 10),
                    Text("English", style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 40),
                // Title
                Text(
                  "WELCOME BACK",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Login to Dive into the World of Football",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                // Email Input
                _buildTextField(
                    controller: _emailController,
                    hintText: "Email",
                    icon: Icons.email),
                SizedBox(height: 20),
                // Password Input
                _buildTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  icon: Icons.lock,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                    child: Text("Forgot Password?",
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                ),
                SizedBox(height: 30),
                // Sign In Button
                ElevatedButton(
                  onPressed: () {
                    if (_emailController.text == '123' &&
                        _passwordController.text == '123') {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid email or password')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    // ignore: deprecated_member_use
                    shadowColor: Colors.blueAccent.withOpacity(0.5),
                    elevation: 8,
                  ),
                  child: Text("Sign In",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                SizedBox(height: 20),
                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white54)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child:
                          Text("Or", style: TextStyle(color: Colors.white70)),
                    ),
                    Expanded(child: Divider(color: Colors.white54)),
                  ],
                ),
                SizedBox(height: 20),
                // Social Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(Icons.g_mobiledata),
                    SizedBox(width: 20),
                    _buildSocialIcon(Icons.facebook),
                  ],
                ),
                Expanded(child: Container()), // Dynamic space
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child:
                          Text("Sign Up", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey[800],
      child: Icon(icon, color: Colors.white),
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
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: const Text("Arabic"),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: const Text("Français"),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
