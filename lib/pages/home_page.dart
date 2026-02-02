import 'package:flutter/material.dart';
import 'package:my_app/pages/learning_page.dart';
import 'package:my_app/pages/track_performance_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text("Home Page")),
    const Center(child: Text("Schedule Page")),
    const Center(child: Text("Creation Page")),
    // const Center(child: Text("Learning Page")),
    // const Center(child: Text("Stats Page")),
    LearningPage(),
    TrackPerformancePage(),
  ];

  //list of background colors
  final List<Color> _navColors = [
    const Color(0xFFDCEEDB), // Home
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

        //dont show labels
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,

        elevation: 0,

        items: [
          BottomNavigationBarItem(
            //icon: Icon(Icons.home),
            icon: Image.asset(
              'images/home-icon.png',
              width: 25,
              height: 25,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image failed to load');
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            //icon: Icon(Icons.schedule),
            icon: Image.asset(
              'images/schedule-icon.png',
              width: 25,
              height: 25,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image failed to load');
              },
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            //icon: Icon(Icons.add),
            icon: Image.asset(
              'images/pink-create-icon.png',
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image failed to load');
              },
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            //icon: Icon(Icons.school),
            icon: Image.asset(
              'images/learn-icon.png',
              width: 28,
              height: 28,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image failed to load');
              },
            ),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            //icon: Icon(Icons.bar_chart),
            icon: Image.asset(
              'images/stats-icon.png',
              width: 25,
              height: 25,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image failed to load');
              },
            ),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
