import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

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

  // STEP 1 DATA
  List<String> selectedChannels = [];

  // STEP 2 DATA
  String postContent = '';
  String? postMediaUrl; // Store the uploaded URL here

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

  // Handler for Step 1
  void _handleChannelsSelected(List<String> channels) {
    setState(() {
      selectedChannels = channels;
    });
    developer.log("Step 1 Complete: $selectedChannels", name: 'CreatePostFlow');
    _nextPage();
  }

  // Handler for Step 2
  void _handleContentSaved(String content, String? mediaUrl) {
    setState(() {
      postContent = content;
      postMediaUrl = mediaUrl;
    });
    developer.log("Step 2 Complete: $postContent, URL: $postMediaUrl",
        name: 'CreatePostFlow');
    _nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: const Color(0xFF3D2E3B),
        scaffoldBackgroundColor: const Color(0xFFDCEEDB),
      ),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _SelectChannelStep(onNext: _handleChannelsSelected),
            _CreateContentStep(onNext: _handleContentSaved),
            _SchedulePostStep(
              onBack: _previousPage,
              channels: selectedChannels,
              content: postContent,
              mediaUrl: postMediaUrl, // Pass URL to final step
            ),
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
  final ValueChanged<List<String>> onNext;

  const _SelectChannelStep({required this.onNext});

  @override
  State<_SelectChannelStep> createState() => _SelectChannelStepState();
}

class _SelectChannelStepState extends State<_SelectChannelStep> {
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
            GestureDetector(
              onTap: () => _toggleChannel(0),
              child: _buildChannelItem(
                channels[0]['name'],
                channels[0]['icon'],
                channels[0]['isSelected'],
              ),
            ),
            const Divider(height: 32, thickness: 1, color: Colors.black12),
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
                onPressed: () {
                  List<String> selected = channels
                      .where((element) => element['isSelected'] == true)
                      .map((element) => element['name'] as String)
                      .toList();
                  widget.onNext(selected);
                },
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

  Widget _buildChannelItem(String name, String socialIconPath, bool isSelected) {
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
class _CreateContentStep extends StatefulWidget {
  final Function(String, String?) onNext;

  const _CreateContentStep({required this.onNext});

  @override
  State<_CreateContentStep> createState() => _CreateContentStepState();
}

class _CreateContentStepState extends State<_CreateContentStep> {
  final TextEditingController _contentController = TextEditingController();
  bool _isNextEnabled = false;

  File? _mediaFile;
  String? _mediaUrl;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _contentController.addListener(() {
      setState(() {
        _isNextEnabled = _contentController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickMedia() async {
    final ImagePicker picker = ImagePicker();

    // 1. Await the picker
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;
    
    // ✅ FIX 1: Check mounted before using context
    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to upload.')),
      );
      return;
    }

    setState(() => _isUploading = true);

    final File file = File(pickedFile.path);
    final fileName = path.basename(file.path);
    final storageRef =
        FirebaseStorage.instance.ref().child('uploads/${user.uid}/$fileName');

    try {
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      
      // ✅ FIX 2: Check mounted again before setting state
      if (!mounted) return;

      setState(() {
        _mediaFile = file;
        _mediaUrl = url;
      });
    } catch (e) {
      if (!mounted) return; // Guard
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

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
                            TextField(
                              controller: _contentController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: 'What would you like to share?',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.black38),
                              ),
                            ),
                            if (_mediaFile != null)
                              Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                height: 120,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child:
                                      Image.file(_mediaFile!, fit: BoxFit.cover),
                                ),
                              ),
                            const Divider(),
                            GestureDetector(
                              onTap: _isUploading ? null : _pickMedia,
                              child: Row(
                                children: [
                                  const Icon(Icons.attach_file,
                                      size: 20, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  const Text('Attach',
                                      style: TextStyle(color: Colors.grey)),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.copy,
                                      size: 20, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  const Text('Open draft',
                                      style: TextStyle(color: Colors.grey)),
                                  if (_isUploading)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                    ),
                                  if (_mediaFile != null && !_isUploading)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.check_circle,
                                          color: Colors.green, size: 20),
                                    ),
                                ],
                              ),
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
                  onPressed: _isNextEnabled
                      ? () {
                          widget.onNext(
                              _contentController.text.trim(), _mediaUrl);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF412334),
                    disabledBackgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          color: _isNextEnabled
                              ? const Color(0xFFDCEEDB)
                              : Colors.white70,
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
  final List<String> channels;
  final String content;
  final String? mediaUrl;

  const _SchedulePostStep({
    required this.onBack,
    required this.channels,
    required this.content,
    this.mediaUrl,
  });

  @override
  State<_SchedulePostStep> createState() => _SchedulePostStepState();
}

class _SchedulePostStepState extends State<_SchedulePostStep> {
  final Color kBackground = const Color(0xFFDCEEDB);
  final Color kTextPrimary = const Color(0xFF3D2E3B);
  final Color kTextSecondary = const Color(0xFF6E6E6E);
  final Color kAccent = const Color(0xFF3D2E3B); // Deep Purple

  DateTime _focusedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isSaving = false;

  final List<String> _months = const [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  void _changeMonth(int offset) {
    setState(() {
      _focusedDate = DateTime(
        _focusedDate.year,
        _focusedDate.month + offset,
        1,
      );
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kAccent,
              onPrimary: Colors.white,
              onSurface: kTextPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kAccent,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    // ✅ FIX 3: Check mounted
    if (!mounted) return;

    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _schedulePost() async {
    setState(() => _isSaving = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final scheduledDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      await FirebaseFirestore.instance.collection('posts').add({
        'userId': user.uid,
        'content': widget.content,
        'channels': widget.channels,
        'status': 'scheduled',
        'scheduledAt': Timestamp.fromDate(scheduledDateTime),
        'imageUrl': widget.mediaUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // ✅ FIX 4: Guard before usage
      if (!mounted) return; 

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post scheduled!')),
      );

      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e) {
      if (!mounted) return; // ✅ Guard
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}";
    String fullDateString =
        "${_months[_selectedDate.month - 1].substring(0, 3)} ${_selectedDate.day}, ${_selectedDate.year}";

    return Container(
      color: kBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: widget.onBack,
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: kTextSecondary,
                      ),
                    ),
                  ),
                  Text(
                    'Schedule',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: _isSaving ? null : _schedulePost,
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: kTextSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.black12),
              const SizedBox(height: 24),

              // --- Month Selector ---
              Row(
                children: [
                  Text(
                    '${_months[_focusedDate.month - 1]} ${_focusedDate.year}',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: kTextPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.chevron_left, color: kTextPrimary),
                    onPressed: () => _changeMonth(-1),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, color: kTextPrimary),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- Calendar Grid ---
              _buildCalendarGrid(),

              const SizedBox(height: 32),

              // --- Time Selector ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: kTextSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickTime,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: kAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        formattedTime,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // --- Footer Info ---
              Center(
                child: Text(
                  'Your post(s) will be sent on $fullDateString at $formattedTime',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: kTextSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // --- Big Confirm Button ---
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _schedulePost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Schedule Post',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // --- Custom Calendar Builder ---
  Widget _buildCalendarGrid() {
    int daysInMonth =
        DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    int firstWeekday =
        DateTime(_focusedDate.year, _focusedDate.month, 1).weekday;

    // Weekday Headers
    List<Widget> weekdayWidgets =
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
            .map((day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: GoogleFonts.poppins(
                        color: kTextSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ))
            .toList();

    // Day Cells
    List<Widget> dayCells = [];
    for (int i = 1; i < firstWeekday; i++) {
      dayCells.add(const SizedBox());
    }
    for (int day = 1; day <= daysInMonth; day++) {
      bool isSelected = day == _selectedDate.day &&
          _focusedDate.month == _selectedDate.month &&
          _focusedDate.year == _selectedDate.year;

      dayCells.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate =
                  DateTime(_focusedDate.year, _focusedDate.month, day);
            });
          },
          child: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isSelected ? kAccent : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : kTextPrimary,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(children: weekdayWidgets),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.0,
          children: dayCells,
        ),
      ],
    );
  }
}