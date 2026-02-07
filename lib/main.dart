import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 

import 'package:my_app/pages/best_posts_page.dart';
import 'package:my_app/pages/followers_clients_stats_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/inspire_page.dart';
import 'package:my_app/pages/learning_page.dart';
import 'package:my_app/pages/post_analysis_page.dart';
import 'package:my_app/pages/posts_stats_page.dart';
import 'package:my_app/pages/track_performance_page.dart';
import 'package:my_app/pages/create_post_flow.dart';
import 'package:my_app/pages/schedule_page.dart';
import 'package:my_app/pages/onboarding_flow.dart'; // Make sure this matches where you saved the file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coco App',

      // CHANGE 1: Set the Onboarding Flow as the first screen
      home: const OnboardingFlow(),

      routes: {
        // CHANGE 2: Renamed '/homepage' to '/home' to match the Onboarding button
        '/home': (context) => const HomePage(), 
        
        '/learningpage': (context) => LearningPage(),
        '/trackperformancepage': (context) => const TrackPerformancePage(),
        '/followersclientsstatspage': (context) => FollowersClientsStatsPage(),
        '/postsstatspage': (context) => PostsStatsPage(),
        '/inspirepage': (context) => const InspirePage(),
        '/postanalyticspage': (context) => PostAnalysisPage(),
        '/bestpostspage': (context) => const BestPostsPage(),
        '/schedule': (context) => const SchedulePage(),
        '/createpost': (context) => const CreatePostFlow(),
        '/onboarding': (context) => const OnboardingFlow(),
      },
    );
  }
}