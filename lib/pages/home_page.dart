import 'package:flutter/material.dart';
import 'package:my_app/pages/learning_page.dart';
import 'package:my_app/pages/track_performance_page.dart';
import 'package:my_app/pages/create_post_flow.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:my_app/pages/schedule_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardTab(),
    const SchedulePage(),
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
// DASHBOARD CONTENT
// ---------------------------------------------------------

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE0EAD8), // Main background color (sticky)
      child: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //hello user text + user pfp
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Stack(
                      children: [
                        //hello user text
                        Positioned(
                          top: 25,
                          child: Text(
                            'Hello\nRaluca!',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 65, 35, 52),
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                          ),
                        ),

                        //pfp
                        Positioned(
                          right: 5,
                          child: Image.asset(
                            'images/pfp.png',
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //goal card
                  Stack(
                    children: [
                      //purple box
                      Container(
                        height: 280,
                        margin: EdgeInsets.only(top: 25),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(133, 88, 114, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      //digits
                      Positioned(
                        top: 20,
                        left: 10,
                        child: Text(
                          '20',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 254, 176, 220),
                              fontSize: 110,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),

                      //percentage
                      Positioned(
                        top: 70,
                        left: 145,
                        child: Text(
                          '%',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 254, 176, 220),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 130,
                        left: 20,
                        child: Text(
                          'closer to...',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromRGBO(220, 238, 219, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 155,
                        left: 20,
                        child: Text(
                          'Your\nGoal',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 254, 176, 220),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 210,
                        left: 20,
                        child: SizedBox(
                          width: 315,
                          height: 80,
                          child: Text(
                            'Reach 10k Instagram followers in 6 months by posting consistent, niche content that builds credibility and grows your personal brand.',
                            softWrap: true,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //small headline
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Your posting\nQueue',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 65, 35, 52),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),
                  ),

                  //posting green space
                  Stack(
                    children: [
                      //green box
                      Container(
                        height: 160,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(139, 179, 136, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      //text
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 55),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                'No post scheduled yet',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color.fromRGBO(220, 238, 219, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    height: 1.1,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 155,
                                height: 60,
                                child: Text(
                                  'Schedule some posts and they will appear here.',
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Color.fromRGBO(220, 238, 219, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //saved ideas button
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/bestpostspage');
                      },

                      child: Stack(
                        children: [
                          //dark purple box
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 65, 35, 52),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(97, 16, 0, 22),
                                  spreadRadius: 2.5,
                                  blurRadius: 5,
                                  offset: Offset(2, 4),
                                ),
                              ],
                            ),
                          ),

                          //icon
                          Positioned(
                            top: 17,
                            right: 160,
                            child: Image.asset(
                              'images/light-bulb-icon.png',
                              height: 25,
                            ),
                          ),

                          //button text
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Text(
                              'Saved ideas',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(220, 238, 219, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
