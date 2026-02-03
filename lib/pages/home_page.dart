import 'package:flutter/material.dart';
import 'package:my_app/pages/learning_page.dart';
import 'package:my_app/pages/track_performance_page.dart';
import 'package:my_app/pages/create_post_flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardTab(),
    const Center(child: Text("Schedule Page")),
    const CreatePostFlow(),
    LearningPage(),
    TrackPerformancePage(),
  ];

  // List of background colors
  final List<Color> _navColors = [
    const Color(0xFFE0EAD8), // Home
    const Color(0xFF8BB388), // Schedule
    const Color(0xFFDCEEDB), // Creation
    const Color(0xFF8BB388), // Learning
    const Color(0xFFDCEEDB), // Stats
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: _navColors[_currentIndex],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/home-icon.png',
              width: 25,
              height: 25,
              errorBuilder: (c, e, s) => const Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/schedule-icon.png',
              width: 25,
              height: 25,
              errorBuilder: (c, e, s) => const Icon(Icons.calendar_today),
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/pink-create-icon.png',
              width: 40,
              height: 40,
              errorBuilder: (c, e, s) => const Icon(Icons.add_circle),
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/learn-icon.png',
              width: 28,
              height: 28,
              errorBuilder: (c, e, s) => const Icon(Icons.school),
            ),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/stats-icon.png',
              width: 25,
              height: 25,
              errorBuilder: (c, e, s) => const Icon(Icons.bar_chart),
            ),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// DASHBOARD TAB (Sticky Header Version)
// ---------------------------------------------------------

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE0EAD8), // Main background color (sticky)
      child: SafeArea(
        // We switch to a Column to separate the Fixed part from the Scrolling part
        child: Column(
          children: [
            // 1. FIXED HEADER
            // This stays at the top because it's outside the ScrollView
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.menu,
                        size: 30,
                        color: Color(0xFF3D2E3B),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3D2E3B),
                            fontFamily: 'Arial',
                          ),
                          children: [
                            TextSpan(text: 'Hello\n'),
                            TextSpan(text: 'Raluca!'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://i.imgur.com/1Xz7y7o.jpeg',
                    ),
                  ),
                ],
              ),
            ),

            // 2. SCROLLABLE CONTENT
            // Expanded ensures this takes up all remaining space
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Space between the fixed header and the first card
                      const SizedBox(height: 10),

                      // Goal Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF885B73),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '20',
                                  style: TextStyle(
                                    fontSize: 96,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFFC1E3),
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  '%',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFFC1E3),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'closer to...',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            const Text(
                              'Your\nGoal',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFC1E3),
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Reach 10k Instagram followers in 6 months by posting consistent, niche content that builds credibility.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Posting Queue Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your posting\nQueue',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3D2E3B),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF885B73),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8FC89C),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8FC89C),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // No Posts Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 48,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8FC89C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              'No posts scheduled yet',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Schedule some posts and\nthey will appear here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Saved Ideas Button
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3D2E3B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.lightbulb_outline,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Saved ideas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Extra padding at the bottom for comfortable scrolling
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
