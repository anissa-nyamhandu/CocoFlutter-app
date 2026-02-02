import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowersClientsStatsPage extends StatelessWidget {
  const FollowersClientsStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 238, 219, 1),
        foregroundColor: Color.fromARGB(255, 65, 35, 52),
      ),

      backgroundColor: const Color.fromRGBO(220, 238, 219, 1),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            //headline
            Text(
              'Followers &\nClients statistics',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 65, 35, 52),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
            ),

            //all boxes =  2 columns in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //1st column of boxes
                Column(
                  spacing: 15,
                  children: [
                    //total insta followers box
                    Stack(
                      children: [
                        //purple box
                        Container(
                          height: 160,
                          width: 170,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(133, 88, 114, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        //title text
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Text(
                            'Total\nInstagram\nFollowers',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //followers number
                        Positioned(
                          top: 115,
                          left: 15,
                          child: Text(
                            '1954',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: const Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //icon
                        Positioned(
                          top: 123,
                          left: 105,
                          child: Image.asset(
                            'images/followers-icon.png',
                            width: 31,
                            height: 23,
                          ),
                        ),
                      ],
                    ),

                    //total tiktok followers box
                    Stack(
                      children: [
                        //purple box
                        Container(
                          height: 160,
                          width: 170,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(133, 88, 114, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        //title text
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Text(
                            'Total\nTiktok\nFollowers',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //followers number
                        Positioned(
                          top: 115,
                          left: 15,
                          child: Text(
                            '3560',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: const Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //icon
                        Positioned(
                          top: 123,
                          left: 115,
                          child: Image.asset(
                            'images/followers-icon.png',
                            width: 31,
                            height: 23,
                          ),
                        ),
                      ],
                    ),

                    //active clients box
                    Stack(
                      children: [
                        //green box
                        Container(
                          height: 134,
                          width: 170,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(139, 179, 136, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        //title text
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Text(
                            'Active\nClients',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 65, 35, 52),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //clients number
                        Positioned(
                          top: 89,
                          left: 15,
                          child: Text(
                            '18',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 65, 35, 52),
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //icon
                        Positioned(
                          top: 97,
                          left: 55,
                          child: Image.asset(
                            'images/clients-icon.png',
                            width: 28,
                            height: 23,
                          ),
                        ),

                        //edit button
                        Positioned(
                          top: 85,
                          right: 15,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(
                                220,
                                238,
                                219,
                                1,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2.5,
                            ),
                            child: Text(
                              'Edit',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 65, 35, 52),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                //2nd column of boxes
                Column(
                  spacing: 15,
                  children: [
                    //new followers box
                    Stack(
                      children: [
                        //purple box
                        Container(
                          height: 240,
                          width: 170,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(133, 88, 114, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        //title text
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Text(
                            'New\nFollowers\nThis week',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //small text
                        Positioned(
                          top: 101,
                          left: 12,
                          child: Text(
                            'Instagram',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //followers number
                        Positioned(
                          top: 122,
                          left: 15,
                          child: Text(
                            '+37',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: const Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //icon
                        Positioned(
                          top: 130,
                          left: 90,
                          child: Image.asset(
                            'images/new-followers-icon.png',
                            width: 31,
                            height: 23,
                          ),
                        ),

                        //small text
                        Positioned(
                          top: 174,
                          left: 12,
                          child: Text(
                            'Tiktok',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //followers number
                        Positioned(
                          top: 195,
                          left: 15,
                          child: Text(
                            '+55',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: const Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //icon
                        Positioned(
                          top: 203,
                          left: 95,
                          child: Image.asset(
                            'images/new-followers-icon.png',
                            width: 31,
                            height: 23,
                          ),
                        ),
                      ],
                    ),

                    //new likes box
                    Stack(
                      children: [
                        //purple box
                        Container(
                          height: 240,
                          width: 170,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(133, 88, 114, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        //title text
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Text(
                            'New\nLikes\nThis week',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //small text
                        Positioned(
                          top: 101,
                          left: 12,
                          child: Text(
                            'Instagram',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //likes number
                        Positioned(
                          top: 122,
                          left: 15,
                          child: Text(
                            '+245',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: const Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //icon
                        Positioned(
                          top: 130,
                          left: 115,
                          child: Image.asset(
                            'images/likes-icon.png',
                            width: 31,
                            height: 23,
                          ),
                        ),

                        //small text
                        Positioned(
                          top: 174,
                          left: 12,
                          child: Text(
                            'Tiktok',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //followers number
                        Positioned(
                          top: 195,
                          left: 15,
                          child: Text(
                            '+986',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: const Color.fromRGBO(220, 238, 219, 1),
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),

                        //icon
                        Positioned(
                          top: 203,
                          right: 23,
                          child: Image.asset(
                            'images/likes-icon.png',
                            width: 31,
                            height: 23,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            //bottom button
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
                      top: 20,
                      left: 15,
                      child: Image.asset(
                        'images/light-double-arrow-icon.png',
                        height: 25,
                      ),
                    ),

                    //button text
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Text(
                        'See your best performing posts',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: const Color.fromRGBO(220, 238, 219, 1),
                            fontSize: 18,
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
