import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostsStatsPage extends StatelessWidget {
  const PostsStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 238, 219, 1),
        foregroundColor: Color.fromARGB(255, 65, 35, 52),
      ),

      backgroundColor: const Color.fromRGBO(220, 238, 219, 1),

      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 17,
          children: [
            //headline
            Text(
              'Instagram\nPosts stats',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 65, 35, 52),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
            ),

            //instagram posts area
            SizedBox(
              height: 315,
              child: Column(
                spacing: 15,
                children: [
                  //1st row of posts
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/postanalyticspage');
                        },
                        child: Image.asset(
                          'images/insta-post-1.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/postanalyticspage');
                        },
                        child: Image.asset(
                          'images/insta-post-2.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/postanalyticspage');
                        },
                        child: Image.asset(
                          'images/insta-post-3.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),
                      ),
                    ],
                  ),

                  //2nd row of posts
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/postanalyticspage');
                        },
                        child: Image.asset(
                          'images/insta-post-4.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/postanalyticspage');
                        },
                        child: Image.asset(
                          'images/insta-post-5.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/postanalyticspage');
                        },
                        child: Image.asset(
                          'images/insta-post-6.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //headline
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                'Tiktok\nPosts stats',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 65, 35, 52),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
              ),
            ),

            //tiktok posts area
            SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/postanalyticspage');
                    },
                    child: Image.asset(
                      'images/tiktok-post-1.png',
                      width: 105,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Image failed to load');
                      },
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/postanalyticspage');
                    },
                    child: Image.asset(
                      'images/tiktok-post-2.png',
                      width: 105,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Image failed to load');
                      },
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/postanalyticspage');
                    },
                    child: Image.asset(
                      'images/tiktok-post-3.png',
                      width: 105,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Image failed to load');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
