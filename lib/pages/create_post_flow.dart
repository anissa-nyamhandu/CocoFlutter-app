import 'package:flutter/material.dart';

class CreatePostFlow extends StatefulWidget {
  const CreatePostFlow({super.key});

  @override
  State<CreatePostFlow> createState() => _CreatePostFlowState();
}

class _CreatePostFlowState extends State<CreatePostFlow> {
  final PageController _pageController = PageController();

  // Function to go to the next slide
  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Function to go to the previous slide
  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(), // Stops manual swiping
      children: [
        // STEP 1: Channels
        _SelectChannelStep(onNext: _nextPage),

        // STEP 2: Content
        _CreateContentStep(onNext: _nextPage),

        // STEP 3: Schedule
        _SchedulePostStep(onBack: _previousPage),
      ],
    );
  }
}

// ---------------------------------------------------------
// STEP 1: Select Channels
// ---------------------------------------------------------
class _SelectChannelStep extends StatelessWidget {
  final VoidCallback onNext;
  const _SelectChannelStep({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE0EAD8),
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.menu, size: 30, color: Color(0xFF3D2E3B)),
            const SizedBox(height: 24),
            const Text(
              'Select or\nAdd channels',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3D2E3B),
                height: 1.1,
              ),
            ),
            const SizedBox(height: 32),
            _buildChannelItem('anissaandraluca', 'images/ig-icon.png', true),
            const Divider(height: 32, thickness: 1, color: Colors.black12),
            _buildChannelItem(
              'nissaandraluca',
              'images/tiktok-icon.png',
              false,
            ),
            const Divider(height: 32, thickness: 1, color: Colors.black12),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: const [
                  Icon(Icons.add, size: 28, color: Colors.black54),
                  SizedBox(width: 12),
                  Text(
                    'Connect a new channel',
                    style: TextStyle(fontSize: 18, color: Color(0xFF3D2E3B)),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D2E3B),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelItem(String name, String iconPath, bool isSelected) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage('https://i.imgur.com/1Xz7y7o.jpeg'),
            ),
            const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(Icons.camera_alt, size: 12, color: Colors.purple),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3D2E3B),
          ),
        ),
        const Spacer(),
        if (isSelected)
          const Icon(Icons.check, color: Color(0xFF885B73), size: 28),
      ],
    );
  }
}

// ---------------------------------------------------------
// STEP 2: Create Content
// ---------------------------------------------------------
class _CreateContentStep extends StatelessWidget {
  final VoidCallback onNext;

  const _CreateContentStep({required this.onNext});

  void _showScriptDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      // FIX 1: Using .withValues instead of .withOpacity
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F8F2),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3D2E3B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.video_camera_back,
                      color: Color(0xFF3D2E3B),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Video Plan: “$title”',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3D2E3B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3D2E3B),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE0EAD8),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu, size: 30, color: Color(0xFF3D2E3B)),
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            'https://i.imgur.com/1Xz7y7o.jpeg',
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.add, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Create your\nContent now',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3D2E3B),
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F8F2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'What would you like to share?',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black38),
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          _actionIcon(Icons.attach_file, 'Attach'),
                          const SizedBox(width: 16),
                          _actionIcon(Icons.copy, 'Open draft'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'No idea what to post...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5A7060),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _ideaChip(
                      context,
                      'Share coding tips and tricks',
                      r'''🎬 Hook (0–2 seconds)...''',
                    ),
                    _ideaChip(
                      context,
                      'Post a day in the life',
                      'Script here...',
                    ),
                    _ideaChip(context, 'Debugging process', 'Script here...'),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3D2E3B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon, String label) => Row(
    children: [
      Icon(icon, size: 20, color: Colors.grey),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(color: Colors.grey)),
    ],
  );

  Widget _ideaChip(BuildContext context, String label, String scriptContent) {
    return GestureDetector(
      onTap: () => _showScriptDialog(context, label, scriptContent),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF8BB388),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// STEP 3: Schedule Post
// ---------------------------------------------------------
class _SchedulePostStep extends StatelessWidget {
  final VoidCallback onBack;

  const _SchedulePostStep({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE0EAD8),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Navigation Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: onBack,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D2E3B),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Month Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'December 2025',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF3D2E3B),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right, color: Color(0xFF3D2E3B)),
                ],
              ),
              const SizedBox(height: 24),

              // Calendar Grid
              _buildCalendarGrid(),

              const SizedBox(height: 40),

              // Time Picker Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Time',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A4A4A), // Dark grey box
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '23:46',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Bottom Section
              const Center(
                child: Text(
                  'Your post(s) will be sent on Dec 31, 2025 at 23:46 PM CET',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to home or show success
                    Navigator.of(context).pushNamed('/homepage');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Post Scheduled!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF757575),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // A helper to draw the Calendar numbers visually
  Widget _buildCalendarGrid() {
    return Column(
      children: [
        // Days of week
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map(
                (d) => SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(d, style: const TextStyle(color: Colors.grey)),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
        // Calendar Rows
        _calRow(['1', '2', '3', '4', '5', '6', '7']),
        _calRow(['8', '9', '10', '11', '12', '13', '14']),
        _calRow(['15', '16', '17', '18', '19', '20', '21']),
        _calRow(['22', '23', '24', '25', '26', '27', '28']),
        _calRow([
          '29',
          '30',
          '31',
          '',
          '',
          '',
          '',
        ], selectedIndex: 2), // 31 is selected
      ],
    );
  }

  Widget _calRow(List<String> days, {int selectedIndex = -1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: days.asMap().entries.map((entry) {
          int idx = entry.key;
          String day = entry.value;
          bool isSelected = idx == selectedIndex;

          if (day.isEmpty) return const SizedBox(width: 40);

          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.grey[400]
                  : Colors.transparent, // Grey circle for selected
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 16,
                  // FIX 2: Using .withValues instead of .withOpacity
                  color: const Color(0xFF3D2E3B).withValues(alpha: 0.7),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
