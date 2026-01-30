import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InspirePage extends StatelessWidget {
  const InspirePage({super.key});

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
          spacing: 20,
          children: [
            //headline
            Text(
              'Get\nInspired',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 65, 35, 52),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
            ),

            //page description text
            SizedBox(
              width: 350,
              height: 72,
              child: Text(
                'Here are some successful posts from this week made by creators on the COCO App',
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 139, 179, 136),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            //instagram posts area
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //small headline
                  Text(
                    'Instagram posts',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 65, 35, 52),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                  ),

                  //the posts
                  SizedBox(
                    height: 180,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'images/inspo-insta-post-1.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),

                        Image.asset(
                          'images/inspo-insta-post-2.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),

                        Image.asset(
                          'images/inspo-insta-post-3.png',
                          width: 105,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image failed to load');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //tiktok posts area
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //small headline
                Text(
                  'Tiktok posts',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 65, 35, 52),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ),

                //the posts
                SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'images/inspo-tiktok-post-1.png',
                        width: 105,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Image failed to load');
                        },
                      ),

                      Image.asset(
                        'images/inspo-tiktok-post-2.png',
                        width: 105,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Image failed to load');
                        },
                      ),

                      Image.asset(
                        'images/inspo-tiktok-post-3.png',
                        width: 105,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Image failed to load');
                        },
                      ),
                    ],
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
