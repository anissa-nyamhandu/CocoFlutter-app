import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

// Your page imports
import 'package:my_app/pages/learning_page.dart';
import 'package:my_app/pages/track_performance_page.dart';
import 'package:my_app/pages/create_post_flow.dart';
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

  final List<Color> _navColors = [
    const Color(0xFFE0EAD8),
    const Color(0xFF8BB388),
    const Color(0xFFDCEEDB),
    const Color(0xFF8BB388),
    const Color(0xFFDCEEDB),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: _navColors[_currentIndex],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/home-icon.png', width: 25, height: 25, errorBuilder: (c,e,s)=>const Icon(Icons.home)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/schedule-icon.png', width: 25, height: 25, errorBuilder: (c,e,s)=>const Icon(Icons.calendar_today)),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/pink-create-icon.png', width: 40, height: 40, errorBuilder: (c,e,s)=>const Icon(Icons.add_circle)),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/learn-icon.png', width: 28, height: 28, errorBuilder: (c,e,s)=>const Icon(Icons.school)),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/stats-icon.png', width: 25, height: 25, errorBuilder: (c,e,s)=>const Icon(Icons.bar_chart)),
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
      color: const Color(0xFFE0EAD8),
      child: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header ---
                  _buildHeader(),

                  // --- Goal Card ---
                  _buildGoalCard(),

                  // --- Queue Headline ---
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your posting\nQueue',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF412334),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                          ),
                        ),
                        // Dots indicator (Visual only)
                        Row(
                          children: [
                            Container(width: 20, height: 8, decoration: BoxDecoration(color: const Color(0xFF855872), borderRadius: BorderRadius.circular(4))),
                            const SizedBox(width: 4),
                            Container(width: 8, height: 8, decoration: BoxDecoration(color: const Color(0xFF8BB388), shape: BoxShape.circle)),
                            const SizedBox(width: 4),
                            Container(width: 8, height: 8, decoration: BoxDecoration(color: const Color(0xFF8BB388), shape: BoxShape.circle)),
                          ],
                        )
                      ],
                    ),
                  ),

                  // --- POSTING QUEUE (Firestore) ---
                  _buildPostingQueue(),

                  // --- Saved Ideas Button ---
                  _buildSavedIdeasButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostingQueue() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return const SizedBox();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'scheduled')
          .orderBy('scheduledAt')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 160, child: Center(child: CircularProgressIndicator()));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        final posts = snapshot.data!.docs;

        return SizedBox(
          height: 180, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final postDoc = posts[index];
              final postData = postDoc.data() as Map<String, dynamic>;
              // Pass both data and the ID so we can edit/delete
              return _buildPostCard(postData, postDoc.id, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, String postId, BuildContext context) {
    final content = post['content'] ?? '';
    final Timestamp? ts = post['scheduledAt'];
    final date = ts?.toDate() ?? DateTime.now();
    
    final String? imageUrl = post['imageUrl'];
    final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;
    
    final dayName = DateFormat('EEEE').format(date);
    final dayMonthYear = DateFormat('MMM d yyyy').format(date);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => EditPostDashboardSheet(post: post, postId: postId),
        );
      },
      child: Container(
        width: 320, 
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF8BB388), 
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // LEFT SIDE: Text Info
            Expanded(
              flex: hasImage ? 5 : 1, // Expand to fill if no image
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Header
                    Text(
                      '$dayName,\n$dayMonthYear',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF3D2E3B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const Spacer(),
                    // Post Content
                    Text(
                      content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        // Uses .withValues instead of deprecated .withOpacity
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // RIGHT SIDE: Image (Only render if hasImage is true)
            if (hasImage)
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black12,
                        image: DecorationImage(
                          image: NetworkImage(imageUrl), 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Small "Edit" pencil visual cue
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 12),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(139, 179, 136, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No post scheduled yet',
              style: GoogleFonts.poppins(
                color: const Color.fromRGBO(220, 238, 219, 1),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 180,
              child: Text(
                'Schedule some posts and they will appear here.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(220, 238, 219, 1),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Extracted Widgets ---

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 25,
            child: Text(
              'Hello\nRaluca!',
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 65, 35, 52),
                fontSize: 36,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ),
          Positioned(
            right: 5,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: const AssetImage('images/pfp.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard() {
    return Stack(
      children: [
        Container(
          height: 280,
          margin: const EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(133, 88, 114, 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: Text(
            '20',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 254, 176, 220),
              fontSize: 110,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: 145,
          child: Text(
            '%',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 254, 176, 220),
              fontSize: 50,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
        ),
        Positioned(
          top: 130,
          left: 20,
          child: Text(
            'closer to...',
            style: GoogleFonts.poppins(
              color: const Color.fromRGBO(220, 238, 219, 1),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
        ),
        Positioned(
          top: 155,
          left: 20,
          child: Text(
            'Your\nGoal',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 254, 176, 220),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 1,
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
              'Reach 10k Instagram followers in 6 months by posting consistent, niche content.',
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: const Color.fromRGBO(220, 238, 219, 1),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSavedIdeasButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 30),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 65, 35, 52),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(97, 16, 0, 22),
                spreadRadius: 2.5,
                blurRadius: 5,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 17,
                right: 160,
                child: Image.asset(
                  'images/light-bulb-icon.png',
                  height: 25,
                  errorBuilder: (c,e,s) => const Icon(Icons.lightbulb, color: Colors.white),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Text(
                  'Saved ideas',
                  style: GoogleFonts.poppins(
                    color: const Color.fromRGBO(220, 238, 219, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
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
// EDIT POST SHEET (For Dashboard)
// ---------------------------------------------------------
class EditPostDashboardSheet extends StatefulWidget {
  final Map<String, dynamic> post;
  final String postId;

  const EditPostDashboardSheet({super.key, required this.post, required this.postId});

  @override
  State<EditPostDashboardSheet> createState() => _EditPostDashboardSheetState();
}

class _EditPostDashboardSheetState extends State<EditPostDashboardSheet> {
  late TextEditingController _contentController;
  late DateTime _scheduledDate;
  late TimeOfDay _scheduledTime;
  String? _imageUrl;
  bool _isLoading = false;

  final Color kBackground = const Color(0xFFDCEEDB);
  final Color kPrimary = const Color(0xFF3D2E3B);
  final Color kCard = const Color(0xFFF2F8F2);

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.post['content']);
    _imageUrl = widget.post['imageUrl'];
    
    // Parse existing schedule
    final Timestamp ts = widget.post['scheduledAt'];
    _scheduledDate = ts.toDate();
    _scheduledTime = TimeOfDay.fromDateTime(_scheduledDate);
  }

  Future<void> _pickNewImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final file = File(picked.path);
      final fileName = 'updated_${path.basename(picked.path)}';
      final ref = FirebaseStorage.instance.ref().child('uploads/${user.uid}/$fileName');
      
      await ref.putFile(file);
      final newUrl = await ref.getDownloadURL();

      setState(() {
        _imageUrl = newUrl;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pickDateTime() async {
    // Note: showDatePicker and showTimePicker return futures.
    // We must check if the widget is mounted before using setState or context afterwards.
    
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: kPrimary),
          ),
          child: child!,
        );
      },
    );
    if (date == null) return;
    if (!mounted) return; // Guard for async gap

    final time = await showTimePicker(
      context: context,
      initialTime: _scheduledTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: kPrimary),
          ),
          child: child!,
        );
      },
    );
    if (time == null) return;
    if (!mounted) return; // Guard for async gap

    setState(() {
      _scheduledDate = date;
      _scheduledTime = time;
    });
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);

    final newDateTime = DateTime(
      _scheduledDate.year,
      _scheduledDate.month,
      _scheduledDate.day,
      _scheduledTime.hour,
      _scheduledTime.minute,
    );

    try {
      await FirebaseFirestore.instance.collection('posts').doc(widget.postId).update({
        'content': _contentController.text.trim(),
        'imageUrl': _imageUrl,
        'scheduledAt': Timestamp.fromDate(newDateTime),
      });
    } catch (e) {
      // Handle error optionally
    }

    if (!mounted) return; // Guard before using context
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }

  Future<void> _deletePost() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Post?', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: kPrimary)),
        content: const Text('This will remove it from your queue permanently.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: TextStyle(color: kPrimary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      await FirebaseFirestore.instance.collection('posts').doc(widget.postId).delete();
      
      if (!mounted) return; // Guard before using context
      Navigator.pop(context); // Close sheet
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
          decoration: BoxDecoration(
            color: kBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: controller,
            children: [
              // Header with Delete Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit Post', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimary)),
                  IconButton(
                    onPressed: _deletePost,
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: 'Delete Post',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Text Content
              TextField(
                controller: _contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kCard,
                  hintText: 'Post caption...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // Image Preview & Change
              GestureDetector(
                onTap: _pickNewImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(12),
                    image: _imageUrl != null 
                        ? DecorationImage(image: NetworkImage(_imageUrl!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: _imageUrl == null
                      ? Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, color: kPrimary.withValues(alpha: 0.5), size: 40),
                            Text("Add Image", style: TextStyle(color: kPrimary.withValues(alpha: 0.5)))
                          ],
                        ))
                      : Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.all(8),
                          child: CircleAvatar(
                            backgroundColor: kPrimary.withValues(alpha: 0.8),
                            radius: 18,
                            child: const Icon(Icons.edit, size: 18, color: Colors.white),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Reschedule
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                title: Text('Schedule Time', style: GoogleFonts.poppins(color: kPrimary, fontWeight: FontWeight.w600)),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "${DateFormat('MMM dd').format(_scheduledDate)}, ${_scheduledTime.format(context)}",
                    style: GoogleFonts.poppins(color: kPrimary, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: _pickDateTime,
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white) 
                      : Text('Save Changes', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}