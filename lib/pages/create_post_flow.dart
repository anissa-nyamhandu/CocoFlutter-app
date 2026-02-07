import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(home: CreatePostFlow()));
}

class CreatePostFlow extends StatefulWidget {
  const CreatePostFlow({super.key});

  @override
  State<CreatePostFlow> createState() => _CreatePostFlowState();
}

class _CreatePostFlowState extends State<CreatePostFlow> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _SelectChannelStep(onNext: _nextPage),
            _CreateContentStep(onNext: _nextPage),
            _SchedulePostStep(onBack: _previousPage),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// STEP 1: Select Channels
// ---------------------------------------------------------
class _SelectChannelStep extends StatefulWidget {
  final VoidCallback onNext;
  const _SelectChannelStep({required this.onNext});

  @override
  State<_SelectChannelStep> createState() => _SelectChannelStepState();
}

class _SelectChannelStepState extends State<_SelectChannelStep> {
  // State to hold channel data
  List<Map<String, dynamic>> channels = [
    {
      'name': 'codewithraluca',
      'icon': 'images/instagram-icon.png',
      'isSelected': true,
    },
    {
      'name': 'codewithanisssa',
      'icon': 'images/tiktok-icon.png',
      'isSelected': false,
    },
  ];

  void _toggleChannel(int index) {
    setState(() {
      channels[index]['isSelected'] = !channels[index]['isSelected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDCEEDB),
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
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF412334),
                height: 1.1,
              ),
            ),
            const SizedBox(height: 32),

            // first channel
            GestureDetector(
              onTap: () => _toggleChannel(0),
              child: _buildChannelItem(
                channels[0]['name'],
                channels[0]['icon'],
                channels[0]['isSelected'],
              ),
            ),
            const Divider(height: 32, thickness: 1, color: Colors.black12),

            // second channel
            GestureDetector(
              onTap: () => _toggleChannel(1),
              child: _buildChannelItem(
                channels[1]['name'],
                channels[1]['icon'],
                channels[1]['isSelected'],
              ),
            ),
            const Divider(height: 32, thickness: 1, color: Colors.black12),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: const [
                  Icon(Icons.add, size: 28, color: Color(0xFF412334)),
                  SizedBox(width: 12),
                  Text(
                    'Connect a new channel',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF412334),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF412334),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Color.fromRGBO(220, 238, 219, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

  Widget _buildChannelItem(
    String name,
    String socialIconPath,
    bool isSelected,
  ) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/pfp.png'),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.transparent,
                child: Image.asset(socialIconPath),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF412334),
            ),
          ),
          const Spacer(),
          if (isSelected)
            const Icon(Icons.check, color: Color(0xFFBB4487), size: 33),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// STEP 2: Create Content
// ---------------------------------------------------------
class _CreateContentStep extends StatelessWidget {
  final VoidCallback onNext;
  const _CreateContentStep({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDCEEDB),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Create your\nContent now',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3D2E3B),
                              height: 1.1,
                            ),
                          ),
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('images/pfp.png'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F8F2),
                          borderRadius: BorderRadius.circular(10),
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
                              children: const [
                                Icon(
                                  Icons.attach_file,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Attach',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(width: 16),
                                Icon(Icons.copy, size: 20, color: Colors.grey),
                                SizedBox(width: 4),
                                Text(
                                  'Open draft',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'No idea what to post...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF698867),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _ideaChip('Share coding tips'),
                          _ideaChip('Post a day in the life'),
                          _ideaChip('Debugging process'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF412334),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFDCEEDB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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

  Widget _ideaChip(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFF8BB388),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFDCEEDB),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// ---------------------------------------------------------
// STEP 3: Schedule Post
// ---------------------------------------------------------
class _SchedulePostStep extends StatefulWidget {
  final VoidCallback onBack;
  const _SchedulePostStep({required this.onBack});

  @override
  State<_SchedulePostStep> createState() => _SchedulePostStepState();
}

class _SchedulePostStepState extends State<_SchedulePostStep> {
  DateTime _focusedDate = DateTime(
    2025,
    12,
    1,
  );

  //starting month that is displayed
  DateTime _selectedDate = DateTime(2025, 12, 31);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 23, minute: 46);

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  //changing month
  void _changeMonth(int offset) {
    setState(() {
      _focusedDate = DateTime(
        _focusedDate.year,
        _focusedDate.month + offset,
        1,
      );
    });
  }

  //when selecting time
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${_months[_selectedDate.month - 1].substring(0, 3)} ${_selectedDate.day}, ${_selectedDate.year}";
    String formattedTime =
        "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}";

    return Container(
      color: const Color(0xFFDCEEDB),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: widget.onBack,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D2E3B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // selecting months
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_left,
                      color: Color(0xFF412334),
                    ),
                    onPressed: () => _changeMonth(-1),
                  ),
                  Text(
                    '${_months[_focusedDate.month - 1]} ${_focusedDate.year}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF412334),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_right,
                      color: Color(0xFF412334),
                    ),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildDynamicCalendar(),

              const SizedBox(height: 25),

              // time picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Time',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: _pickTime,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 189, 189),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        formattedTime,
                        style: const TextStyle(
                          color: Color(0xFF412334),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              Center(
                child: Text(
                  'Your post(s) will be sent on $formattedDate at $formattedTime',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/homepage');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Post Scheduled!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF412334),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFDCEEDB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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

  Widget _buildDynamicCalendar() {
    int daysInMonth = DateTime(
      _focusedDate.year,
      _focusedDate.month + 1,
      0,
    ).day;
    int firstWeekday = DateTime(
      _focusedDate.year,
      _focusedDate.month,
      1,
    ).weekday; // 1=Mon, 7=Sun

    List<Widget> rows = [];

    // Header Row
    rows.add(
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
    );
    rows.add(const SizedBox(height: 16));

    List<Widget> dayCells = [];

    //empty slots for days before the 1st of the month
    for (int i = 1; i < firstWeekday; i++) {
      dayCells.add(const SizedBox(width: 40, height: 40));
    }

    //actual days
    for (int day = 1; day <= daysInMonth; day++) {
      bool isSelected =
          day == _selectedDate.day &&
          _focusedDate.month == _selectedDate.month &&
          _focusedDate.year == _selectedDate.year;

      dayCells.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = DateTime(
                _focusedDate.year,
                _focusedDate.month,
                day,
              );
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey[400] : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF3D2E3B).withValues(alpha: 0.7),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    for (int i = 0; i < dayCells.length; i += 7) {
      List<Widget> rowChildren = dayCells.sublist(
        i,
        (i + 7 > dayCells.length) ? dayCells.length : i + 7,
      );

      while (rowChildren.length < 7) {
        rowChildren.add(const SizedBox(width: 40, height: 40));
      }

      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowChildren,
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}
