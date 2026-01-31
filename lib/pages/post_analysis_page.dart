import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostAnalysisPage extends StatelessWidget {
  const PostAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(220, 238, 219, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 238, 219, 1),
        foregroundColor: Color.fromARGB(255, 65, 35, 52),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 22,
          children: [
            //headline
            Text(
              'Post\nAnalytics',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 65, 35, 52),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
            ),

            //image
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  'images/big-post-1.png',
                  width: 195,
                  height: 260,
                ),
              ),
            ),

            //small headline
            Text(
              'You did a great job with:',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 65, 35, 52),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ),

            //bullet points list
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    //1st bullet point
                    Text(
                      '\u2022 Showing the field you operate in',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 65, 35, 52),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.1,
                        ),
                      ),
                    ),

                    //2nd bullet point
                    SizedBox(
                      width: 320,
                      height: 45,
                      child: Text(
                        '\u2022 Including yourself in the picture, so that people connect with you more',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 65, 35, 52),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //small headline
            Text(
              'Here’s what you can improve:',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 65, 35, 52),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ),

            //bullet points list
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 125,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    //1st bullet point
                    SizedBox(
                      width: 320,
                      height: 45,
                      child: Text(
                        '\u2022 Show your face - this makes people get more familiar with you',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 65, 35, 52),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    //2nd bullet point
                    SizedBox(
                      width: 320,
                      height: 70,
                      child: Text(
                        '\u2022 When posting, add more slides explaining what project you’re working on',
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 65, 35, 52),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
