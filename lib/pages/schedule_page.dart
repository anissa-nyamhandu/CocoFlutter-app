import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

// --- Branding Colors ---
final Color kBackground = const Color(0xFF8BB388);
final Color kPrimary = const Color(0xFF3D2E3B); // Deep Purple
final Color kAccent = const Color(0xFF8BB388); // Sage Green
final Color kCard = const Color(0xFFF2F8F2); // Pale White/Green
final Color kPinkPop = const Color(0xFFFEB0DC); // Pink Accent (Posts)
final Color kImportant = const Color(0xFFFEB0DC); // Red/Pink - Important
final Color kSortOfImportant = const Color(0xFFFFD580); // Yellow - Sort of
// ✅ GREEN for "Not that" important
final Color kNotThatImportant = const Color(0xFF00822D); 

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildEventListHeader(),
            Expanded(child: _buildUnifiedList()), 
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateEventModal(context),
        backgroundColor: kPrimary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // --- Widgets ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('MMMM yyyy').format(_focusedDay),
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, color: kPrimary),
                onPressed: () {},
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('images/pfp.png'),
                radius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kPrimary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() => _calendarFormat = format);
        },
        onPageChanged: (focusedDay) {
          setState(() => _focusedDay = focusedDay);
        },
        eventLoader: (day) {
          return [];
        },
        calendarStyle: CalendarStyle(
          defaultTextStyle: GoogleFonts.poppins(color: kPrimary),
          weekendTextStyle: GoogleFonts.poppins(color: kPrimary),
          outsideTextStyle:
              GoogleFonts.poppins(color: kPrimary.withValues(alpha: 0.4)),
          selectedDecoration: BoxDecoration(
            color: kPrimary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: kAccent.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: kPinkPop,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kPrimary,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: kPrimary),
          rightChevronIcon: Icon(Icons.chevron_right, color: kPrimary),
        ),
      ),
    );
  }

  Widget _buildEventListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('dd MMMM').format(_selectedDay!),
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
          ),
          Text(
            'Timeline',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: kPrimary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ UNIFIED LIST WITH SORTING LOGIC
  Widget _buildUnifiedList() {
    if (_userId == null) {
      return const Center(child: Text("Please log in."));
    }

    final startOfDay = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Stream 1: Events
    final eventStream = FirebaseFirestore.instance
        .collection('events')
        .where('userId', isEqualTo: _userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('date', isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots();

    // Stream 2: Posts
    final postStream = FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: _userId)
        .where('scheduledAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('scheduledAt', isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: eventStream,
      builder: (context, eventSnapshot) {
        return StreamBuilder<QuerySnapshot>(
          stream: postStream,
          builder: (context, postSnapshot) {
            
            if (eventSnapshot.connectionState == ConnectionState.waiting || 
                postSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Events
            final events = eventSnapshot.data?.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                ...data,
                'id': doc.id,
                'dataType': 'event',
                'sortTime': (data['startTime'] as Timestamp).toDate(),
              };
            }).toList() ?? [];

            // Posts
            final posts = postSnapshot.data?.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                ...data,
                'id': doc.id,
                'dataType': 'post',
                'sortTime': (data['scheduledAt'] as Timestamp).toDate(),
              };
            }).toList() ?? [];

            // Merge
            final allItems = [...events, ...posts];

            // ✅ SORTING LOGIC: Posts First, Then Time
            allItems.sort((a, b) {
              bool isPostA = a['dataType'] == 'post';
              bool isPostB = b['dataType'] == 'post';

              // If A is post and B is not, A comes first (-1)
              if (isPostA && !isPostB) return -1;
              
              // If B is post and A is not, B comes first (1)
              if (!isPostA && isPostB) return 1;

              // Otherwise (both posts or both events), sort by time
              return (a['sortTime'] as DateTime).compareTo(b['sortTime'] as DateTime);
            });

            if (allItems.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Nothing scheduled.',
                    style: GoogleFonts.poppins(color: kPrimary.withValues(alpha: 0.6)),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: allItems.length,
              itemBuilder: (context, index) {
                final item = allItems[index];
                if (item['dataType'] == 'event') {
                  return EventCard(event: item, eventId: item['id']);
                } else {
                  return PostScheduleCard(post: item, postId: item['id']);
                }
              },
            );
          },
        );
      },
    );
  }

  void _showCreateEventModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateEventForm(selectedDate: _selectedDay!),
    );
  }
}

// ---------------------------------------------------------
// POST CARD (Pink Tag - For Schedule Page)
// ---------------------------------------------------------
class PostScheduleCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final String postId;

  const PostScheduleCard({super.key, required this.post, required this.postId});

  void _openEditSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditPostSheet(post: post, postId: postId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheduledAt = (post['scheduledAt'] as Timestamp).toDate();
    final imageUrl = post['imageUrl'];
    final content = post['content'] ?? '';

    return GestureDetector(
      onTap: () => _openEditSheet(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(16),
          // White border to make it pop slightly
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Time
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('hh:mm').format(scheduledAt),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: kPrimary,
                    ),
                  ),
                  Text(
                    DateFormat('a').format(scheduledAt),
                    style: GoogleFonts.poppins(fontSize: 12, color: kPrimary.withValues(alpha: 0.6)),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              
              // Pink Line Tag
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: kPinkPop, 
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: kPinkPop.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "SOCIAL POST",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: kPinkPop, 
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (imageUrl != null)
                          const Icon(Icons.image, size: 16, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content.isEmpty ? 'Image Post' : content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: kPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// EDIT POST SHEET (Full Editing Capability)
// ---------------------------------------------------------
class EditPostSheet extends StatefulWidget {
  final Map<String, dynamic> post;
  final String postId;

  const EditPostSheet({super.key, required this.post, required this.postId});

  @override
  State<EditPostSheet> createState() => _EditPostSheetState();
}

class _EditPostSheetState extends State<EditPostSheet> {
  late TextEditingController _contentController;
  late DateTime _scheduledDate;
  late TimeOfDay _scheduledTime;
  String? _imageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.post['content']);
    _imageUrl = widget.post['imageUrl'];
    
    final Timestamp ts = widget.post['scheduledAt'];
    _scheduledDate = ts.toDate();
    _scheduledTime = TimeOfDay.fromDateTime(_scheduledDate);
  }

  Future<void> _pickNewImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final file = File(picked.path);
      final fileName = 'updated_${path.basename(picked.path)}';
      final ref = FirebaseStorage.instance.ref().child('uploads/${user.uid}/$fileName');
      
      await ref.putFile(file);
      final newUrl = await ref.getDownloadURL();

      if(!mounted) return;
      setState(() {
        _imageUrl = newUrl;
      });
    } catch (e) {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: kPrimary)), child: child!),
    );
    if (date == null) return;
    if (!mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: _scheduledTime,
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: kPrimary)), child: child!),
    );
    if (time == null) return;
    if (!mounted) return;

    setState(() {
      _scheduledDate = date;
      _scheduledTime = time;
    });
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);
    final newDateTime = DateTime(
      _scheduledDate.year, _scheduledDate.month, _scheduledDate.day,
      _scheduledTime.hour, _scheduledTime.minute,
    );

    try {
      await FirebaseFirestore.instance.collection('posts').doc(widget.postId).update({
        'content': _contentController.text.trim(),
        'imageUrl': _imageUrl,
        'scheduledAt': Timestamp.fromDate(newDateTime),
      });
    } catch(e) { /* handle error */ }

    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }

  Future<void> _deletePost() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Post?', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: const Text('This will remove it from your queue permanently.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      await FirebaseFirestore.instance.collection('posts').doc(widget.postId).delete();
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post deleted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(color: kCard, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: controller,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit Post', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimary)),
                  IconButton(onPressed: _deletePost, icon: const Icon(Icons.delete_outline, color: Colors.red)),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true, fillColor: Colors.white,
                  hintText: 'Post caption...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickNewImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), image: _imageUrl != null ? DecorationImage(image: NetworkImage(_imageUrl!), fit: BoxFit.cover) : null),
                  child: _imageUrl == null ? Center(child: Icon(Icons.add_a_photo, color: kPrimary.withValues(alpha: 0.5))) : null,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Schedule Time', style: GoogleFonts.poppins(color: kPrimary)),
                trailing: Text("${DateFormat('MMM dd').format(_scheduledDate)}, ${_scheduledTime.format(context)}", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                onTap: _pickDateTime,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity, height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveChanges,
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Text('Save Changes', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- Event Card Widget ---
class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  final String eventId;

  const EventCard({super.key, required this.event, required this.eventId});

  Color _getImportanceColor(String? importance) {
    switch (importance) {
      case 'important':
        return kImportant;
      case 'sort_of':
        return kSortOfImportant;
      case 'not_that':
        return kNotThatImportant; // ✅ Green
      default:
        return kAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final importanceColor = _getImportanceColor(event['importance']);
    final isAllDay = event['isAllDay'] ?? false;
    final startTime = (event['startTime'] as Timestamp?)?.toDate();
    final type = event['type'] ?? 'task';

    return Dismissible(
      key: Key(eventId),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        FirebaseFirestore.instance.collection('events').doc(eventId).delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event deleted')),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Time Column
            if (!isAllDay && startTime != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('hh:mm').format(startTime),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: kPrimary,
                    ),
                  ),
                  Text(
                    DateFormat('a').format(startTime),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: kPrimary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              )
            else if (isAllDay)
              Text(
                'All\nDay',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: kPrimary.withValues(alpha: 0.6),
                ),
              ),

            const SizedBox(width: 16),
            
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'] ?? 'No Title',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kPrimary,
                    ),
                  ),
                  if (event['description'] != null &&
                      event['description'].isNotEmpty)
                    Text(
                      event['description'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: kPrimary.withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            
            // Importance Icon/Dot
            Column(
              children: [
                Icon(
                  type == 'task' ? Icons.task_alt : Icons.event,
                  color: importanceColor,
                ),
                const SizedBox(height: 4),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: importanceColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Create Event Form Widget ---
class CreateEventForm extends StatefulWidget {
  final DateTime selectedDate;

  const CreateEventForm({super.key, required this.selectedDate});

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _type = 'task';
  String _importance = 'not_that';
  bool _isAllDay = true;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    // Guard for async gap
    if (!mounted) return;

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
        _isAllDay = false;
      });
    }
  }

  Future<void> _saveEvent() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      DateTime date = widget.selectedDate;
      DateTime? startDateTime;
      DateTime? endDateTime;

      if (!_isAllDay && _startTime != null) {
        startDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          _startTime!.hour,
          _startTime!.minute,
        );
        if (_endTime != null) {
          endDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            _endTime!.hour,
            _endTime!.minute,
          );
        }
      } else {
        // For all-day, set time to start of day
        startDateTime = DateTime(date.year, date.month, date.day);
      }

      await FirebaseFirestore.instance.collection('events').add({
        'userId': userId,
        'title': _titleController.text.trim(),
        'description': _descController.text.trim(),
        'date': Timestamp.fromDate(startDateTime),
        'startTime': Timestamp.fromDate(startDateTime),
        'endTime': endDateTime != null ? Timestamp.fromDate(endDateTime) : null,
        'isAllDay': _isAllDay,
        'type': _type,
        'importance': _importance,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: kBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ListView(
              controller: controller,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: kPrimary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // --- Type Toggle ---
                Row(
                  children: [
                    _buildTypeButton('Task', Icons.task_alt, 'task'),
                    const SizedBox(width: 16),
                    _buildTypeButton('Event', Icons.event, 'event'),
                  ],
                ),
                const SizedBox(height: 20),
                // --- Title & Description ---
                _buildTextField(_titleController, 'Title', true),
                const SizedBox(height: 16),
                _buildTextField(_descController, 'Description', false, maxLines: 3),
                const SizedBox(height: 20),
                // --- Date & Time ---
                _buildDateTimePicker(),
                const SizedBox(height: 20),
                // --- Importance ---
                Text('Importance',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, color: kPrimary)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildImportanceChoice(
                        'Important', kImportant, 'important'),
                    _buildImportanceChoice(
                        'Sort of', kSortOfImportant, 'sort_of'),
                    _buildImportanceChoice(
                        'Not that', kNotThatImportant, 'not_that'),
                  ],
                ),
                const SizedBox(height: 30),
                // --- Save Button ---
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Create ${_type == 'task' ? 'Task' : 'Event'}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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

  // --- Form Components ---

  Widget _buildTypeButton(String label, IconData icon, String value) {
    final isSelected = _type == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? kPrimary : kCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? kPrimary : Colors.transparent, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Colors.white : kPrimary),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : kPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, bool required,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: required
          ? (value) => value!.isEmpty ? '$hint is required' : null
          : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: kPrimary.withValues(alpha: 0.4)),
        filled: true,
        fillColor: kCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('All Day',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: kPrimary)),
            Switch(
              value: _isAllDay,
              onChanged: (val) => setState(() => _isAllDay = val),
              activeTrackColor: kPrimary,
            ),
          ],
        ),
        if (!_isAllDay) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTimeButton(
                  'Start Time',
                  _startTime,
                  () => _selectTime(context, true),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTimeButton(
                  'End Time',
                  _endTime,
                  () => _selectTime(context, false),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTimeButton(String label, TimeOfDay? time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time != null ? time.format(context) : label,
              style: GoogleFonts.poppins(
                color: time != null ? kPrimary : kPrimary.withValues(alpha: 0.4),
              ),
            ),
            Icon(Icons.access_time, color: kPrimary.withValues(alpha: 0.6)),
          ],
        ),
      ),
    );
  }

  Widget _buildImportanceChoice(String label, Color color, String value) {
    final isSelected = _importance == value;
    return GestureDetector(
      onTap: () => setState(() => _importance = value),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? color : Colors.transparent,
                width: 2,
              ),
            ),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: kPrimary.withValues(alpha: isSelected ? 1.0 : 0.6),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}