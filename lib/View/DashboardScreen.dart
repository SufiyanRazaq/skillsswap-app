import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:skillsswap/View/CalendarSchedulerScreen.dart';
import 'package:skillsswap/View/ChatList.dart';
import 'package:skillsswap/View/ExploreScreen.dart';
import 'package:skillsswap/View/SwapManagementScreen.dart';
import 'SwapRequestScreen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int earnedHours = 24;
  int availableHours = 10;

  final List<Map<String, String>> upcomingSwaps = [
    {"title": "Guitar Lesson", "date": "Dec 30, 2024", "time": "3:00 PM"},
    {"title": "Web Development", "date": "Jan 2, 2025", "time": "11:00 AM"},
  ];

  final List<Map<String, String>> recommendations = [
    {"name": "John Doe", "skill": "Graphic Design"},
    {"name": "Anna Smith", "skill": "Public Speaking"},
    {"name": "Michael Lee", "skill": "Piano Lessons"},
  ];

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: const Color(0xFF043927),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 400),
      animateChildDecoration: true,
      rtlOpening: false,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      drawer: _buildDrawer(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Dashboard",
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: _handleMenuButtonPressed,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.message, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatListScreen()),
                );
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF043927), Color(0xFF00796B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard",
                    style: GoogleFonts.poppins(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Track your progress and upcoming skill swaps",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildSkillCard(),
                  const SizedBox(height: 30),
                  _buildQuickActions(),
                  const SizedBox(height: 40),
                  _buildUpcomingSwaps(),
                  const SizedBox(height: 40),
                  _buildRecommendations(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  Widget _buildDrawer(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        iconColor: Colors.white,
        textColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text('Dashboard', style: GoogleFonts.poppins()),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.white),
              title: Text("Scheduler",
                  style: GoogleFonts.poppins(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarSchedulerScreen(),
                  ),
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text('Logout', style: GoogleFonts.poppins()),
              onTap: () {
                Fluttertoast.showToast(msg: "Logged out");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkillStat(
                  "Earned Hours", earnedHours.toString(), Icons.access_time),
              _buildSkillStat("Available Hours", availableHours.toString(),
                  Icons.timelapse),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.white),
        const SizedBox(height: 10),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 30, color: Colors.white),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionCard("Find Skills", Icons.search, () {
          Fluttertoast.showToast(msg: "Finding Skills...");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExploreScreen(),
            ),
          );
        }),
        _buildActionCard("Offer Skills", Icons.handshake, () {
          Fluttertoast.showToast(msg: "Offering Skills...");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SwapRequestScreen(
                user: const {
                  "name": "John Doe",
                  "skill": "Graphic Design",
                  "rating": 4.8,
                  "availability": "Weekends",
                  "type": "Online",
                  "image": "assets/images/user1.jpg",
                },
              ),
            ),
          );
        }),
        _buildActionCard("Manage Swaps", Icons.calendar_today, () {
          Fluttertoast.showToast(msg: "Managing Swaps...");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SwapManagementScreen(),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActionCard(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              padding: const EdgeInsets.all(18),
              color: Colors.white.withOpacity(0.15),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingSwaps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Swaps",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        ...upcomingSwaps.map((swap) => _buildSwapCard(swap)).toList(),
      ],
    );
  }

  Widget _buildSwapCard(Map<String, String> swap) {
    return ListTile(
      leading: const Icon(Icons.calendar_today, color: Colors.white),
      title: Text(
        swap["title"]!,
        style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
      ),
      subtitle: Text(
        "${swap["date"]} at ${swap["time"]}",
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
      ),
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended for You",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        ...recommendations
            .map((user) => _buildRecommendationCard(user))
            .toList(),
      ],
    );
  }

  Widget _buildRecommendationCard(Map<String, String> user) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white.withOpacity(0.3),
            child: Icon(Icons.person, size: 40, color: Colors.black54),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user["name"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Skill: ${user["skill"]}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Requested ${user['skill']}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Request",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFF00796B),
                      fontWeight: FontWeight.w500,
                    ),
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
