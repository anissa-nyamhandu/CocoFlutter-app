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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
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
          ),
        ],
      ),
    );
  }
}
