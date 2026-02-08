import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/services/auth_service.dart'; // Ensure this import exists

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // --- Branding Colors (Matches Onboarding) ---
  final Color kBackground = const Color(0xFFE0EAD8); // Mint Green
  final Color kPrimary = const Color(0xFF3D2E3B);    // Deep Purple
  final Color kCard = const Color(0xFFF2F8F2);       // Pale White/Green

  // --- Controllers ---
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Login Logic ---
  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Call your existing AuthService
      await AuthService().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;
      // Success: Go to Home and clear history so they can't "back" into login
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: ${e.toString()}")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // --- Header ---
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kPrimary.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.waving_hand, size: 40, color: kPrimary),
              ),
              const SizedBox(height: 24),
              Text(
                "Welcome Back!",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kPrimary,
                ),
              ),
              Text(
                "Let's get back to growing your brand.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: kPrimary.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 40),

              // --- Form Fields ---
              Text(
                "Email",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: kPrimary,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "Enter your email",
                false,
                controller: _emailController,
              ),
              const SizedBox(height: 20),

              Text(
                "Password",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: kPrimary,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "Enter your password",
                true,
                controller: _passwordController,
              ),

              // --- Forgot Password ---
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add forgot password logic here if needed
                  },
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.poppins(
                      color: kPrimary.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // --- Login Button ---
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Log In",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // --- Sign Up Link ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.poppins(color: kPrimary),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate back to Onboarding (which has Sign Up)
                      // Or to a specific Sign Up page if you have one separate
                      Navigator.pushNamed(context, '/onboarding');
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: kPrimary,
                        decoration: TextDecoration.underline,
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

  // --- Helper Widget: Text Field ---
  Widget _buildTextField(String hint, bool isPassword, {required TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: GoogleFonts.poppins(color: kPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: kPrimary.withValues(alpha: 0.4)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}