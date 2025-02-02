import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillsswap/View/ProfileScreen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<Map<String, dynamic>> users = [
    {
      "name": "John Doe",
      "skill": "Web Development",
      "rating": 4.8,
      "availability": "Weekends",
      "type": "Online",
      "image": "assets/images/user1.jpg"
    },
    {
      "name": "Anna Smith",
      "skill": "Graphic Design",
      "rating": 4.5,
      "availability": "Weekdays",
      "type": "In-person",
      "image": "assets/images/user2.jpg"
    },
    {
      "name": "Michael Lee",
      "skill": "Yoga Instructor",
      "rating": 4.7,
      "availability": "Weekends",
      "type": "Online",
      "image": "assets/images/user3.jpg"
    }
  ];

  List<Map<String, dynamic>> filteredUsers = [];
  String searchQuery = '';
  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void _filterUsers() {
    setState(() {
      filteredUsers = users.where((user) {
        return (user['name']
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) ||
                user['skill']
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase())) &&
            (selectedFilter == "All" ||
                user['availability'] == selectedFilter ||
                user['type'] == selectedFilter);
      }).toList();
    });
  }

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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      Text(
                        "Explore Skills",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Find the perfect skill swap",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildFilterOptions(),
                  const SizedBox(height: 30),
                  _buildUserList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
          _filterUsers();
        });
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        hintText: "Search by skill or username...",
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    List<String> filters = [
      "All",
      "Online",
      "In-person",
      "Weekdays",
      "Weekends"
    ];
    return Wrap(
      spacing: 12,
      children: filters.map((filter) {
        return ChoiceChip(
          label: Text(
            filter,
            style: GoogleFonts.poppins(
              color: selectedFilter == filter ? Colors.black : Colors.black,
            ),
          ),
          selected: selectedFilter == filter,
          backgroundColor: Colors.white.withOpacity(0.1),
          selectedColor: Colors.tealAccent,
          onSelected: (isSelected) {
            setState(() {
              selectedFilter = filter;
              _filterUsers();
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildUserList() {
    return Column(
      children: filteredUsers.map((user) {
        return _buildUserCard(user);
      }).toList(),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
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
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(user['image']),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user['skill'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${user['availability']} | ${user['type']}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: user),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            ),
            child: Text(
              "View Profile",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF00796B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
