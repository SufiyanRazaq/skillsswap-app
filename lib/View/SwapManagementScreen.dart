import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SwapManagementScreen extends StatefulWidget {
  @override
  _SwapManagementScreenState createState() => _SwapManagementScreenState();
}

class _SwapManagementScreenState extends State<SwapManagementScreen> {
  final List<Map<String, String>> pendingSwaps = [
    {"title": "Graphic Design", "user": "John Doe", "status": "Pending"},
    {"title": "Web Development", "user": "Anna Smith", "status": "Pending"},
  ];

  final List<Map<String, String>> upcomingSwaps = [
    {"title": "Yoga Lesson", "user": "Michael Lee", "date": "Jan 5, 2025"},
    {"title": "Cooking Class", "user": "Sarah Khan", "date": "Jan 7, 2025"},
  ];

  final List<Map<String, String>> completedSwaps = [
    {"title": "Piano Lesson", "user": "Emily Brown", "date": "Dec 25, 2024"},
    {
      "title": "Digital Marketing",
      "user": "David Green",
      "date": "Dec 20, 2024"
    },
  ];

  String selectedTab = "Pending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF043927), Color(0xFF00796B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    Text(
                      "Manage Swaps",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "View and manage your swap activities",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTabs(),
                const SizedBox(height: 20),
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    List<String> tabs = ["Pending", "Upcoming", "Completed"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs.map((tab) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = tab;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: selectedTab == tab
                    ? Colors.white.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tab,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight:
                      selectedTab == tab ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContent() {
    List<Map<String, String>> swaps;
    switch (selectedTab) {
      case "Pending":
        swaps = pendingSwaps;
        break;
      case "Upcoming":
        swaps = upcomingSwaps;
        break;
      case "Completed":
        swaps = completedSwaps;
        break;
      default:
        swaps = [];
    }

    return swaps.isNotEmpty
        ? ListView.builder(
            itemCount: swaps.length,
            itemBuilder: (context, index) {
              return _buildSwapCard(swaps[index]);
            },
          )
        : Center(
            child: Text(
              "No swaps available.",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
            ),
          );
  }

  Widget _buildSwapCard(Map<String, String> swap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            swap["title"]!,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "With: ${swap["user"]}",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          if (swap.containsKey("date"))
            Text(
              "Date: ${swap["date"]}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white54,
              ),
            ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedTab != "Completed")
                ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Cancelled ${swap['title']}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: selectedTab == "Completed"
                          ? "Leaving Feedback"
                          : "Rescheduling ${swap['title']}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  selectedTab == "Completed" ? "Feedback" : "Reschedule",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
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
