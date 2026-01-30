import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackPerformancePage extends StatelessWidget {
  const TrackPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(220, 238, 219, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //headline marketing term of the day
          Container(
            margin: const EdgeInsets.only(top: 100, left: 20),
            child: Text(
              'Track\nPerformance',
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

          //1st box w text and icon
          Stack(
            children: [
              //green box
              Container(
                height: 160,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(139, 179, 136, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(77, 4, 55, 23),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
              ),

              //box title
              Positioned(
                top: 45,
                left: 30,
                child: Text(
                  'Followers and\nClients statistics',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: const Color.fromRGBO(220, 238, 219, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ),
              ),

              //box description
              Positioned(
                top: 110,
                left: 30,
                child: SizedBox(
                  width: 220,
                  height: 70,
                  child: Text(
                    'See how you perform on social media during the week: followers, likes, client activity ',
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: const Color.fromRGBO(220, 238, 219, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              //arrow icon button
              Positioned(
                top: 135,
                left: 315,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'images/double-arrow-icon.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),

          //2nd box w text and icon
          Stack(
            children: [
              //green box
              Container(
                height: 160,
                //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 30,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(139, 179, 136, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(77, 4, 55, 23),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
              ),

              //box title
              Positioned(
                top: 25,
                left: 30,
                child: Text(
                  'Posts\nStatistics',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: const Color.fromRGBO(220, 238, 219, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ),
              ),

              //box description
              Positioned(
                top: 90,
                left: 30,
                child: SizedBox(
                  width: 220,
                  height: 70,
                  child: Text(
                    'Check how your posts are doing and get AI feedback suggestions on improvement ',
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: const Color.fromRGBO(220, 238, 219, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              //arrow icon button
              Positioned(
                top: 115,
                left: 315,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'images/double-arrow-icon.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),

          //3rd box w text and icon
          Stack(
            children: [
              //green box
              Container(
                height: 160,
                //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(139, 179, 136, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(77, 4, 55, 23),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
              ),

              //box title
              Positioned(
                top: 25,
                left: 30,
                child: Text(
                  'Inspire yourself\nAnd compare',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: const Color.fromRGBO(220, 238, 219, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ),
              ),

              //box description
              Positioned(
                top: 90,
                left: 30,
                child: SizedBox(
                  width: 220,
                  height: 70,
                  child: Text(
                    'Look at some successful examples of posts from other creators to analyse',
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: const Color.fromRGBO(220, 238, 219, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              //arrow icon button
              Positioned(
                top: 115,
                left: 315,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'images/double-arrow-icon.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
