import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // We use a variable to track which day is selected
  int _selectedDay = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF8BB388,
      ), // Your specific Green Brand Color
      body: SafeArea(
        child: Column(
          children: [
            // 1. HEADER SECTION
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Content Calendar',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3D2E3B), // Dark Purple/Black
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D2E3B).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Color(0xFF3D2E3B)),
                  ),
                ],
              ),
            ),

            // 2. CALENDAR SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Month Navigator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.chevron_left, color: Color(0xFF3D2E3B)),
                      SizedBox(width: 16),
                      Text(
                        'December 2025',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3D2E3B),
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.chevron_right, color: Color(0xFF3D2E3B)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Days of Week Headers (M T W T F S S)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                        .map(
                          (d) => SizedBox(
                            width: 35,
                            child: Center(
                              child: Text(
                                d,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(
                                    0xFF3D2E3B,
                                  ).withValues(alpha: 0.6),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),

                  // The Actual Grid of Numbers
                  _buildCalendarGrid(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. AGENDA / UPCOMING LIST (White Sheet)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming for Dec $_selectedDay',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3D2E3B),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Scrollable List of Posts
                      Expanded(
                        child: ListView(
                          children: [
                            _buildScheduleCard(
                              time: '10:00 AM',
                              platform: 'Instagram',
                              title: 'Coding Tips Reel',
                              status: 'Scheduled',
                              color: const Color(0xFFFCE4EC), // Light Pink
                              iconPath: 'images/ig-icon.png',
                              iconFallback: Icons.camera_alt,
                            ),
                            const SizedBox(height: 16),
                            _buildScheduleCard(
                              time: '02:30 PM',
                              platform: 'TikTok',
                              title: 'Day in the Life v2',
                              status: 'Draft',
                              color: const Color(0xFFE0F2F1), // Light Teal
                              iconPath: 'images/tiktok-icon.png',
                              iconFallback: Icons.music_note,
                            ),
                            const SizedBox(height: 16),
                            _buildScheduleCard(
                              time: '06:00 PM',
                              platform: 'LinkedIn',
                              title: 'Career Update',
                              status: 'Posted',
                              color: const Color(0xFFE3F2FD), // Light Blue
                              iconPath: 'images/linkedin-icon.png',
                              iconFallback: Icons.work,
                            ),
                          ],
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
    );
  }

  // --- Helper Widgets to keep the code clean ---

  Widget _buildCalendarGrid() {
    return Column(
      children: [
        _calRow(['1', '2', '3', '4', '5', '6', '7']),
        _calRow(['8', '9', '10', '11', '12', '13', '14']),
        _calRow(['15', '16', '17', '18', '19', '20', '21'], hasEvent: true),
        _calRow(['22', '23', '24', '25', '26', '27', '28']),
        _calRow(['29', '30', '31', '', '', '', '']),
      ],
    );
  }

  Widget _calRow(List<String> days, {bool hasEvent = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: days.map((day) {
          if (day.isEmpty) return const SizedBox(width: 35);

          bool isSelected = day == _selectedDay.toString();
          bool isToday = day == '20'; // Mocking "Today" as the 20th

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDay = int.parse(day);
              });
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3D2E3B)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: isToday && !isSelected
                    ? Border.all(color: const Color(0xFF3D2E3B), width: 1)
                    : null,
              ),
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF3D2E3B),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildScheduleCard({
    required String time,
    required String platform,
    required String title,
    required String status,
    required Color color,
    required String iconPath,
    required IconData iconFallback,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Time Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3D2E3B).withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 4),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D2E3B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Divider Line
          Container(
            height: 40,
            width: 1,
            color: const Color(0xFF3D2E3B).withValues(alpha: 0.1),
          ),
          const SizedBox(width: 16),

          // Content Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      iconPath,
                      width: 16,
                      height: 16,
                      errorBuilder: (c, e, s) =>
                          Icon(iconFallback, size: 16, color: Colors.black54),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      platform,
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFF3D2E3B).withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D2E3B),
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.more_horiz, color: Color(0xFF3D2E3B)),
        ],
      ),
    );
  }
}
