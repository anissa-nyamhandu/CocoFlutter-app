import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/learning_page.dart';
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

      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: TrackPerformancePage(),
      routes: {
        '/homepage': (context) => HomePage(),
        '/learningpage': (context) => LearningPage(),
        'trackperformacepage': (context) => TrackPerformancePage(),
      },
    );
  }
}
