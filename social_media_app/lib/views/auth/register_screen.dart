import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/auth_provider.dart';
import 'package:social_media_app/views/auth/login_screen.dart';

// ignore: must_be_immutable
class Registerscreen extends StatelessWidget {
  Registerscreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Create Account Vietalk"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome To Vietalk!",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Register a new account to get started.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),

              // Username field
              TextFormField(
                decoration: _inputDecoration(
                  hint: "Username",
                  icon: Icons.person_outline,
                ),
                validator:
                    (value) => value!.isEmpty ? "Enter your username." : null,
                onSaved: (value) => username = value!,
              ),
              const SizedBox(height: 20),

              // Email field
              TextFormField(
                decoration: _inputDecoration(
                  hint: "Email",
                  icon: Icons.email_outlined,
                ),
                keyboardType: TextInputType.emailAddress,
                validator:
                    (value) => value!.isEmpty ? "Enter your email." : null,
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 20),

              // Password field
              TextFormField(
                obscureText: true,
                obscuringCharacter: "•",
                decoration: _inputDecoration(
                  hint: "Password",
                  icon: Icons.lock_outline,
                ),
                validator:
                    (value) => value!.isEmpty ? "Enter a password." : null,
                onSaved: (value) => password = value!,
              ),
              const SizedBox(height: 30),

              // Submit button or loading
              Center(
                child: Consumer<Authprovider>(
                  builder: (context, authProvider, child) {
                    return authProvider.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              final success = await authProvider.registerUser(
                                username,
                                email,
                                password,
                              );

                              if (success) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Registration successful! Please log in.',
                                    ),
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Navigation to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginscreen()),
                      );
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Colors.blueAccent.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }
}
