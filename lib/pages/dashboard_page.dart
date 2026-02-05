import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(220, 238, 219, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 175,
              child: Stack(
                children: [
                  //headline
                  Positioned(
                    top: 100,
                    child: Text(
                      'Hello\nRaluca!',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 65, 35, 52),
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),
                  ),

                  //pfp
                  Positioned(
                    top: 75,
                    right: 0,
                    child: Image.asset(
                      'images/pfp.png',
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),

            //purple container with text
            Stack(
              children: [
                //purple box
                Container(
                  height: 280,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(133, 88, 114, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                //digits
                Positioned(
                  top: 15,
                  left: 10,
                  child: Text(
                    '20',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 254, 176, 220),
                        fontSize: 110,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),

                //percentage
                Positioned(
                  top: 65,
                  left: 145,
                  child: Text(
                    '%',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 254, 176, 220),
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 125,
                  left: 20,
                  child: Text(
                    'closer to...',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(220, 238, 219, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 150,
                  left: 20,
                  child: Text(
                    'Your\nGoal',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 254, 176, 220),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 205,
                  left: 20,
                  child: SizedBox(
                    width: 315,
                    height: 80,
                    child: Text(
                      'Reach 10k Instagram followers in 6 months by posting consistent, niche content that builds credibility and grows your personal brand.',
                      softWrap: true,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(220, 238, 219, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //small headline
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                'Your posting\nQueue',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 65, 35, 52),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
            ),

            //posting green space
            Stack(
              children: [
                //green box
                Container(
                  height: 160,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(139, 179, 136, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          'No post scheduled yet',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromRGBO(220, 238, 219, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 155,
                          height: 60,
                          child: Text(
                            'Schedule some posts and they will appear here.',
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 14,
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

            //bottom button
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/bestpostspage');
                },

                child: Stack(
                  children: [
                    //dark purple box
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 65, 35, 52),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(97, 16, 0, 22),
                            spreadRadius: 2.5,
                            blurRadius: 5,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                    ),

                    //icon
                    Positioned(
                      top: 17,
                      right: 160,
                      child: Image.asset(
                        'images/light-bulb-icon.png',
                        height: 25,
                      ),
                    ),

                    //button text
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Text(
                        'Saved ideas',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(220, 238, 219, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1.1,
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
