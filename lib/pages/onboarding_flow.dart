import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  // --- Branding Colors ---
  final Color kBackground = const Color(0xFFE0EAD8); // Mint Green
  final Color kPrimary = const Color(0xFF3D2E3B);    // Deep Purple
  final Color kAccent = const Color(0xFF8BB388);     // Sage Green
  final Color kCard = const Color(0xFFF2F8F2);       // Pale White/Green
  final Color kPinkPop = const Color(0xFFFEB0DC);    // Pink Accent

  // --- State Management ---
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  // Form State
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Selections
  List<String> selectedNiches = [];
  String? selectedGoal;

  // Data Lists
  final List<String> niches = [
    'Fashion', 'Tech', 'Fitness', 'Food', 'Travel', 
    'Beauty', 'Gaming', 'Education', 'Lifestyle', 'Business'
  ];

  final List<Map<String, dynamic>> goals = [
    {'title': 'Grow Audience', 'icon': Icons.rocket_launch, 'desc': 'Reach 10k+ followers'},
    {'title': 'High Engagement', 'icon': Icons.favorite, 'desc': 'Build a loyal community'},
    {'title': 'Consistency', 'icon': Icons.calendar_month, 'desc': 'Post every single day'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      // Safe area ensures we don't hide behind notches
      body: SafeArea(
        child: Column(
          children: [
            // 1. PROGRESS INDICATOR (Visible on pages 1, 2, 3)
            if (_currentPage > 0 && _currentPage < 4)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) => _buildDot(index)),
                ),
              ),

            // 2. THE PAGE VIEW (Holds all screens)
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swiping so they use buttons
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildWelcomeScreen(),
                  _buildSignUpScreen(),
                  _buildNicheScreen(),
                  _buildGoalScreen(),
                  _buildSuccessScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET: Progress Dot ---
  Widget _buildDot(int index) {
    // Adjust index because page 0 (Welcome) doesn't have dots in this logic
    int actualStep = _currentPage - 1; 
    bool isActive = index == actualStep;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? kPrimary : kPrimary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // --- SCREEN 1: Welcome ---
  Widget _buildWelcomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Logo Placeholder
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: kCard,
              shape: BoxShape.circle,
              border: Border.all(color: kPrimary, width: 2),
            ),
            child: Icon(Icons.auto_graph, size: 60, color: kPrimary),
          ),
          const SizedBox(height: 40),
          Text(
            "Master Your\nSocial Media",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: kPrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Plan, schedule, and grow with ease. Your all-in-one marketing tool.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: kPrimary.withValues(alpha: 0.7),
            ),
          ),
          const Spacer(),
          _buildButton(
            label: "Get Started", 
            onTap: _nextPage,
            isPrimary: true
          ),
          const SizedBox(height: 16),
          _buildButton(
            label: "I already have an account", 
            onTap: () {
               // Navigate to a separate Login Page here
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text("Navigate to Login Page"))
               );
            },
            isPrimary: false
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- SCREEN 2: Sign Up ---
  Widget _buildSignUpScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: kPrimary),
            onPressed: () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
          ),
          const SizedBox(height: 20),
          Text("Let's get you\nset up.", style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: kPrimary)),
          const SizedBox(height: 40),
          _buildTextField("Full Name", false),
          const SizedBox(height: 20),
          _buildTextField("Email Address", false),
          const SizedBox(height: 20),
          _buildTextField("Password", true),
          const SizedBox(height: 40),
          _buildButton(label: "Create Account", onTap: _nextPage, isPrimary: true),
        ],
      ),
    );
  }

  // --- SCREEN 3: Niche Selection ---
  Widget _buildNicheScreen() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("What is your\nBusiness Niche?", style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: kPrimary)),
           const SizedBox(height: 8),
           Text("Select all that apply.", style: GoogleFonts.poppins(fontSize: 14, color: kPrimary.withValues(alpha: 0.6))),
           const SizedBox(height: 30),
           Expanded(
             child: SingleChildScrollView(
               child: Wrap(
                 spacing: 12,
                 runSpacing: 12,
                 children: niches.map((niche) {
                   final isSelected = selectedNiches.contains(niche);
                   return InkWell(
                     onTap: () {
                       setState(() {
                         isSelected ? selectedNiches.remove(niche) : selectedNiches.add(niche);
                       });
                     },
                     borderRadius: BorderRadius.circular(20),
                     child: AnimatedContainer(
                       duration: const Duration(milliseconds: 200),
                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                       decoration: BoxDecoration(
                         color: isSelected ? kAccent : kCard,
                         borderRadius: BorderRadius.circular(20),
                         border: Border.all(color: isSelected ? kAccent : Colors.transparent),
                         boxShadow: isSelected ? [BoxShadow(color: kAccent.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 4))] : [],
                       ),
                       child: Text(
                         niche,
                         style: GoogleFonts.poppins(
                           fontWeight: FontWeight.w600,
                           color: isSelected ? Colors.white : kPrimary,
                         ),
                       ),
                     ),
                   );
                 }).toList(),
               ),
             ),
           ),
           _buildButton(
             label: "Continue", 
             onTap: selectedNiches.isNotEmpty ? _nextPage : () {}, // Disable if empty
             isPrimary: selectedNiches.isNotEmpty
           ),
        ],
      ),
    );
  }

  // --- SCREEN 4: Goal Selection (Gamified) ---
  Widget _buildGoalScreen() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("What's your\nmain goal?", style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: kPrimary)),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
              itemCount: goals.length,
              separatorBuilder: (c, i) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final goal = goals[index];
                final isSelected = selectedGoal == goal['title'];
                
                return GestureDetector(
                  onTap: () => setState(() => selectedGoal = goal['title']),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack, // Gives it a bouncy "pop" effect
                    height: isSelected ? 110 : 100, // Grows when selected
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isSelected ? kAccent : kCard,
                      borderRadius: BorderRadius.circular(24),
                      border: isSelected ? Border.all(color: kPrimary, width: 2) : Border.all(color: Colors.transparent),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimary.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white.withValues(alpha: 0.2) : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(goal['icon'], color: isSelected ? Colors.white : kPrimary),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(goal['title'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: isSelected ? Colors.white : kPrimary)),
                              Text(goal['desc'], style: GoogleFonts.poppins(fontSize: 12, color: isSelected ? Colors.white.withValues(alpha: 0.9) : kPrimary.withValues(alpha: 0.6))),
                            ],
                          ),
                        ),
                        if (isSelected) 
                          Icon(Icons.check_circle, color: Colors.white, size: 28)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildButton(
             label: "Finish Setup", 
             onTap: selectedGoal != null ? _nextPage : () {},
             isPrimary: selectedGoal != null
           ),
        ],
      ),
    );
  }

  // --- SCREEN 5: Success/Praise ---
  Widget _buildSuccessScreen() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Simulated "Confetti" icon or use Lottie here
          Icon(Icons.celebration, size: 80, color: kPinkPop),
          const SizedBox(height: 24),
          Text(
            "You're all set!",
            style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: kPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            "Your personalized dashboard is ready.\nLet's start growing.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 16, color: kPrimary.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 60),
          _buildButton(
            label: "Open Dashboard", 
            onTap: () {
              // UX TIP: PushReplacement prevents going back to onboarding
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }, 
            isPrimary: true
          ),
        ],
      ),
    );
  }

  // --- HELPER: Buttons ---
  Widget _buildButton({required String label, required VoidCallback onTap, required bool isPrimary}) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? kPrimary : Colors.transparent,
          elevation: isPrimary ? 4 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary ? BorderSide.none : BorderSide(color: kPrimary, width: 2),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPrimary ? Colors.white : kPrimary,
          ),
        ),
      ),
    );
  }

  // --- HELPER: Text Field ---
  Widget _buildTextField(String hint, bool isPassword) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        obscureText: isPassword,
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