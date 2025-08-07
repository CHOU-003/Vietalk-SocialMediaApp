// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/auth_provider.dart';
import 'package:social_media_app/views/auth/register_screen.dart';
import 'package:social_media_app/views/home/dashboard.dart';

// ignore: must_be_immutable
class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.lock_outline, size: 64, color: Colors.deepPurple),
              const SizedBox(height: 16),
              Text(
                "Welcome Back Vietalk 👋",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Login to your account to continue",

                style: theme.textTheme.bodyMedium,

                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email", style: theme.textTheme.labelLarge),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: _inputDecoration("Enter your email"),
                      validator:
                          (value) =>
                              value!.isEmpty ? "Please enter email" : null,
                      onSaved: (value) => email = value!,
                    ),
                    const SizedBox(height: 20),

                    Text("Password", style: theme.textTheme.labelLarge),
                    const SizedBox(height: 6),
                    TextFormField(
                      obscureText: true,
                      decoration: _inputDecoration("Enter your password"),
                      validator:
                          (value) =>
                              value!.isEmpty ? "Please enter password" : null,
                      onSaved: (value) => password = value!,
                    ),
                    const SizedBox(height: 30),

                    // Login button with loading
                    Consumer<Authprovider>(
                      builder: (context, authprovider, _) {
                        return authprovider.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    bool result = await authprovider.loginUser(
                                      email,
                                      password,
                                    );
                                    if (result) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (_) => const Dashboard(),
                                        ),
                                        (route) => false,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Login failed. Try again.",
                                          ),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Divider(height: 1),
              const SizedBox(height: 16),

              // Register navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black38),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Registerscreen()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.deepPurple,
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
