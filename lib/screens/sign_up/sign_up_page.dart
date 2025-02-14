import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  // Fields
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String phoneNumber = '';
  String gender = '';
  String birthday = '';
  double height = 0.0;
  double weight = 0.0;

  bool isHovering = false;

  // Variable to hold the selected birthday
  DateTime? selectedBirthday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black, // Black background
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and title
                SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Card Section with Gradient Background and Shadow
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
                  elevation: 12, // Slightly more elevation for better shadow
                  // ignore: deprecated_member_use
                  shadowColor: Colors.black.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title with gray color
                          const Text(
                            "Create your account",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey, // Gray title color
                            ),
                          ),
                          const SizedBox(height: 25),

                          // Name Field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your name'
                                : null,
                            onChanged: (value) => setState(() => name = value),
                          ),
                          const SizedBox(height: 10),

                          // Email Field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onChanged: (value) => setState(() => email = value),
                          ),
                          const SizedBox(height: 10),

                          // Password Field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                setState(() => password = value),
                          ),
                          const SizedBox(height: 10),

                          // Confirm Password Field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != password) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                setState(() => confirmPassword = value),
                          ),
                          const SizedBox(height: 10),

                          // Phone Number Field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                setState(() => phoneNumber = value),
                          ),
                          const SizedBox(height: 10),

                          // Gender Field
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Gender',
                              border: OutlineInputBorder(),
                            ),
                            value: gender.isNotEmpty ? gender : null,
                            items: ['Male', 'Female', 'Other']
                                .map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            validator: (value) =>
                                value == null ? 'Please select a gender' : null,
                            onChanged: (value) =>
                                setState(() => gender = value!),
                          ),
                          const SizedBox(height: 10),

                          // Updated Birthday Field with Date Picker
                          GestureDetector(
                            onTap: () async {
                              // Show date picker on tap
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              setState(() {
                                selectedBirthday = pickedDate;
                                birthday =
                                    '${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}';
                              });
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: TextEditingController(
                                  text: selectedBirthday != null
                                      ? '${selectedBirthday!.day}/${selectedBirthday!.month}/${selectedBirthday!.year}'
                                      : '',
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Birthday',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please select your birthday';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          // Sign Up Button
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isHovering ? Colors.blue[700] : Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onHover: (hovering) {
                                setState(() {
                                  isHovering = hovering;
                                });
                              },
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Sign-up successful!'),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
