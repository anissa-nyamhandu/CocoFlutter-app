import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class BestPostsPage extends StatelessWidget {
  const BestPostsPage({super.key});

  // Brand Colors
  final Color kBackground = const Color(0xFFE0EAD8); 
  final Color kDarkPurple = const Color(0xFF3D2E3B); 
  final Color kAccentPink = const Color(0xFFFFC1E3); 
  final Color kAccentGreen = const Color(0xFF8BB388); 
  final Color kCardColor = const Color(0xFFF2F8F2); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Best Performing Posts',
            style: GoogleFonts.poppins(
              color: kDarkPurple,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOP PERFORMER SHOWCASE CARD
            _buildTopPerformerCard(),
            const SizedBox(height: 24),

            // 2. INSIGHT & MINI CHART
            _buildInsightSection(),
            const SizedBox(height: 24),

            // 3. MORE TOP CONTENT LIST
            Text(
              'More Standout Content',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kDarkPurple,
              ),
            ),
            const SizedBox(height: 16),
            _buildPostListItem(
              'Day in the Life of a Coder',
              '8.2k views',
              '1.1k likes',
              'assets/images/tiktok-icon.png', // UPDATED PATH
            ),
            const SizedBox(height: 12),
            _buildPostListItem(
              'Debugging Secrets Revealed',
              '6.5k views',
              '890 likes',
              'assets/images/ig-icon.png', // UPDATED PATH
            ),
            const SizedBox(height: 24),

            // 4. OVERALL GROWTH TREND CHART
            _buildGrowthTrendChart(),
            const SizedBox(height: 24),

            // 5. REPLICATE SUCCESS TIPS
            _buildReplicateSuccessTips(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildTopPerformerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kDarkPurple.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge and Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kAccentPink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: kDarkPurple, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '#1 Top Performer',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kDarkPurple,
                      ),
                    ),
                  ],
                ),
              ),
              // UPDATED: Added error builder to prevent crash if icon is missing
              Image.asset(
                'assets/images/ig-icon.png',
                height: 24,
                errorBuilder: (c, o, s) => Icon(Icons.camera_alt, color: kDarkPurple),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Thumbnail and Title
          Row(
            children: [
              // UPDATED: Changed from DecorationImage to ClipRRect + Image.asset
              // This allows us to handle missing images without crashing
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/coding-setup.jpg', // UPDATED PATH
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported, color: Colors.grey[600]);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // EXPANDED prevents RenderFlex Overflow error
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to Code in Dart',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: kDarkPurple,
                      ),
                      maxLines: 2, // Added safety for long titles
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Posted on Dec 15',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: kDarkPurple.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem('12.4k', 'Views', Icons.visibility_outlined),
              _buildMetricItem('1.5k', 'Likes', Icons.favorite_border),
              _buildMetricItem('240', 'Cmnts', Icons.chat_bubble_outline), // Shortened text to prevent overflow
              _buildMetricItem('450', 'Shares', Icons.share_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: kDarkPurple, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: kDarkPurple,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: kDarkPurple.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildInsightSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDarkPurple,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: kAccentPink, size: 24),
              const SizedBox(width: 8),
              Text(
                'Why This Post Succeeded',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'This post had a strong hook in the first 3 seconds and provided high-value, actionable tips. The visual quality was also excellent.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return Text('Likes', style: GoogleFonts.poppins(color: Colors.white, fontSize: 10));
                          case 1:
                            return Text('Cmnts', style: GoogleFonts.poppins(color: Colors.white, fontSize: 10));
                          case 2:
                            return Text('Share', style: GoogleFonts.poppins(color: Colors.white, fontSize: 10));
                          case 3:
                            return Text('Saves', style: GoogleFonts.poppins(color: Colors.white, fontSize: 10));
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeBarGroup(0, 1500, kAccentPink), 
                  _makeBarGroup(1, 240, kAccentGreen), 
                  _makeBarGroup(2, 450, kAccentPink), 
                  _makeBarGroup(3, 600, kAccentGreen), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildPostListItem(String title, String views, String likes, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // UPDATED: Added crash protection for missing images
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/placeholder-thumbnail.jpg', // UPDATED PATH
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, color: Colors.grey[600]);
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kDarkPurple,
                  ),
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      views,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: kDarkPurple.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      likes,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: kDarkPurple.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // UPDATED: Added crash protection for small icons
          Image.asset(
            iconPath, 
            width: 24, 
            height: 24,
            errorBuilder: (context, error, stackTrace) => const SizedBox(width: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthTrendChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Growth Trend',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: kDarkPurple,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 1),
                      const FlSpot(1, 2.5),
                      const FlSpot(2, 2.0),
                      const FlSpot(3, 4.5),
                      const FlSpot(4, 3.5),
                      const FlSpot(5, 5.0),
                      const FlSpot(6, 6.5),
                    ],
                    isCurved: true,
                    color: kDarkPurple,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: kDarkPurple.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplicateSuccessTips() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kAccentGreen.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.rocket_launch, color: kDarkPurple, size: 24),
              const SizedBox(width: 8),
              Text(
                'How to Replicate Success',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kDarkPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem('Focus on a strong hook in the first 3 seconds.'),
          _buildTipItem('Deliver high-value, actionable content clearly.'),
          _buildTipItem('Use high-quality visuals and good lighting.'),
          _buildTipItem('Encourage saves and shares for better reach.'),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: kAccentGreen, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: kDarkPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}