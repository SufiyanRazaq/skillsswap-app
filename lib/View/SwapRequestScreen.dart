import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SwapRequestScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  SwapRequestScreen({required this.user});

  @override
  _SwapRequestScreenState createState() => _SwapRequestScreenState();
}

class _SwapRequestScreenState extends State<SwapRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedOfferSkill;
  String? selectedDesiredSkill;
  String? selectedTimeSlot;
  String? selectedDuration;
  TextEditingController messageController = TextEditingController();

  final List<String> skills = [
    "Web Development",
    "Graphic Design",
    "Yoga",
    "Photography",
    "Cooking"
  ];
  final List<String> durations = ["30 minutes", "1 hour", "2 hours"];
  final List<String> timeSlots = [
    "10:00 AM - 11:00 AM",
    "2:00 PM - 3:00 PM",
    "5:00 PM - 6:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF043927), Color(0xFF00796B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 10),
                  Text(
                    "Request Swap",
                    style: GoogleFonts.poppins(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Swap skills with ${widget.user['name']}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildUserCard(widget.user),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDropdown(
                          "Skill You Offer",
                          selectedOfferSkill,
                          skills,
                          (value) {
                            setState(() {
                              selectedOfferSkill = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        _buildDropdown(
                          "Skill You Want to Learn",
                          selectedDesiredSkill,
                          skills,
                          (value) {
                            setState(() {
                              selectedDesiredSkill = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        _buildDropdown(
                          "Select Duration",
                          selectedDuration,
                          durations,
                          (value) {
                            setState(() {
                              selectedDuration = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        _buildDropdown(
                          "Select Time Slot",
                          selectedTimeSlot,
                          timeSlots,
                          (value) {
                            setState(() {
                              selectedTimeSlot = value;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: messageController,
                          maxLines: 3,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Add a short message...",
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: _submitRequest,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            "Submit Request",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF00796B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
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
                    fontSize: 22,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String? selectedValue, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
          dropdownColor: Colors.black87,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child:
                  Text(item, style: GoogleFonts.poppins(color: Colors.white)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _submitRequest() {
    Fluttertoast.showToast(msg: "Swap Request Sent!");
    Navigator.pop(context);
  }
}
