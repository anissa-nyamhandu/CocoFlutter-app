import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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
              final post = posts[index].data() as Map<String, dynamic>;
              return _buildPostCard(post);
            },
          ),
        );
      },
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    final content = post['content'] ?? '';
    final Timestamp? ts = post['scheduledAt'];
    final date = ts?.toDate() ?? DateTime.now();
    
    // Check if image exists in Firestore data
    final String? imageUrl = post['imageUrl'];
    final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;
    
    // Formatting date 
    final dayName = DateFormat('EEEE').format(date);
    final dayMonthYear = DateFormat('MMM d yyyy').format(date);

    return Container(
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
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black12,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl), // ✅ FIX: Removed '!'
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
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