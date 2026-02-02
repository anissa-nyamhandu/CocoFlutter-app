import 'package:flutter/material.dart';
import 'package:my_app/pages/best_posts_page.dart';
import 'package:my_app/pages/followers_clients_stats_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/inspire_page.dart';
import 'package:my_app/pages/learning_page.dart';
import 'package:my_app/pages/post_analysis_page.dart';
import 'package:my_app/pages/posts_stats_page.dart';
import 'package:my_app/pages/track_performance_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coco App',

      home: HomePage(),

      routes: {
        '/homepage': (context) => HomePage(),
        '/learningpage': (context) => LearningPage(),
        '/trackperformancepage': (context) => TrackPerformancePage(),
        '/followersclientsstatspage': (context) => FollowersClientsStatsPage(),
        '/postsstatspage': (context) => PostsStatsPage(),
        '/inspirepage': (context) => InspirePage(),
        '/postanalyticspage': (context) => PostAnalysisPage(),
        '/bestpostspage': (context) => BestPostsPage(),
      },
    );
  }
}
