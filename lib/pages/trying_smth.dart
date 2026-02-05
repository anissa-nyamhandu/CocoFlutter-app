import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SomethingRandomPage extends StatelessWidget {
  const SomethingRandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(139, 179, 136, 1),
      body: Column(
        children: [
          //video tutorials section
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //headline
                Text(
                  'Video Tutorials',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 65, 35, 52),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                //tutorial box
                SizedBox(
                  height: 195,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      //yellow box
                      Container(
                        height: 150,
                        margin: EdgeInsets.only(right: 20, top: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(220, 238, 219, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      //tutorial title
                      Positioned(
                        top: 20,
                        left: 10,
                        child: Text(
                          'Viral ads\nIn minutes',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 65, 35, 52),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),

                      //video description
                      Positioned(
                        top: 90,
                        left: 10,
                        child: SizedBox(
                          width: 155,
                          height: 63,
                          child: Text(
                            'Short video on how to create viral ads quickly',
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 65, 35, 52),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //yt video cover image
                      Positioned(
                        top: 30,
                        left: 155,
                        child: Image.asset(
                          'images/new-yt-vid.png',
                          width: 190,
                          height: 115,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
