import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skillsswap/View/DashboardScreen.dart';

class SkillSelectionScreen extends StatefulWidget {
  @override
  _SkillSelectionScreenState createState() => _SkillSelectionScreenState();
}

class _SkillSelectionScreenState extends State<SkillSelectionScreen> {
  final List<String> availableSkills = [
    // Technology & Development
    "Web Development",
    "App Development",
    "UI/UX Design",
    "Cybersecurity",
    "Blockchain",
    "Machine Learning",
    "AI Development",
    "Cloud Computing",
    "Game Development",
    "AR/VR Development",
    "DevOps",
    "Data Science",
    "Software Testing",
    "Robotics",

    // Creative & Design
    "Graphic Design",
    "Animation",
    "3D Modeling",
    "Photography",
    "Video Editing",
    "Illustration",
    "Logo Design",
    "Interior Design",
    "Fashion Design",
    "Architectural Design",
    "Product Design",

    // Marketing & Business
    "Digital Marketing",
    "SEO",
    "Social Media Management",
    "Content Creation",
    "Copywriting",
    "E-commerce Management",
    "Affiliate Marketing",
    "Market Research",
    "Branding",
    "Email Marketing",
    "Project Management",

    // Personal Development
    "Public Speaking",
    "Leadership",
    "Emotional Intelligence",
    "Critical Thinking",
    "Time Management",
    "Negotiation",
    "Financial Literacy",
    "Mindfulness",
    "Problem Solving",
    "Networking",

    // Academic & Language
    "Mathematics",
    "Physics",
    "Chemistry",
    "Biology",
    "History",
    "Literature",
    "English",
    "Spanish",
    "French",
    "Mandarin",
    "German",
    "Japanese",
    "Korean",
    "Sign Language",
    "Writing",
    "Editing",

    // Music & Arts
    "Guitar",
    "Piano",
    "Violin",
    "Singing",
    "Music Production",
    "Songwriting",
    "Acting",
    "Dance",
    "Calligraphy",
    "Creative Writing",
    "Sculpting",

    // Health & Fitness
    "Yoga",
    "Fitness Coaching",
    "Nutrition",
    "Meditation",
    "Martial Arts",
    "Mental Health Coaching",
    "Personal Training",
    "Physical Therapy",
    "First Aid",

    // Hobbies & Lifestyle
    "Cooking",
    "Baking",
    "Gardening",
    "DIY Projects",
    "Fishing",
    "Photography",
    "Travel Planning",
    "Hiking",
    "Sewing",
    "Home Brewing",
    "Pottery",

    // Professional Skills
    "Accounting",
    "HR Management",
    "Legal Advice",
    "Real Estate",
    "Customer Service",
    "Sales",
    "Entrepreneurship",
    "Consulting",
    "Event Planning",
    "Crisis Management",

    // Engineering & Technical Skills
    "Mechanical Engineering",
    "Civil Engineering",
    "Electrical Engineering",
    "AutoCAD",
    "Welding",
    "Plumbing",
    "Automotive Repair",
    "Electronics Repair",
    "Carpentry",

    // Miscellaneous
    "Astrology",
    "Tarot Reading",
    "Chess",
    "Public Relations",
    "Social Work",
    "Fundraising",
    "Pet Training",
    "Drone Piloting",
    "Sign Language",
  ];

  List<String> selectedOfferSkills = [];
  List<String> selectedLearnSkills = [];

  String? offerSkill;
  String? learnSkill;

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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Select Your Skills",
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Add skills you offer and those you want to learn.",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 40),
                        buildDropdown("Skills I Offer", offerSkill,
                            (String? value) {
                          setState(() {
                            offerSkill = value;
                            if (value != null &&
                                !selectedOfferSkills.contains(value)) {
                              selectedOfferSkills.add(value);
                            }
                          });
                        }),
                        const SizedBox(height: 20),
                        buildSkillChips(selectedOfferSkills, "offer"),
                        const SizedBox(height: 30),
                        buildDropdown("Skills I Want to Learn", learnSkill,
                            (String? value) {
                          setState(() {
                            learnSkill = value;
                            if (value != null &&
                                !selectedLearnSkills.contains(value)) {
                              selectedLearnSkills.add(value);
                            }
                          });
                        }),
                        const SizedBox(height: 20),
                        buildSkillChips(selectedLearnSkills, "learn"),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: _saveSkills,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                            elevation: 10,
                          ),
                          child: Text(
                            "Save Skills",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF00796B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(
      String label, String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            hint: Text(
              "Select a skill",
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
            dropdownColor: Colors.black87,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
            underline: const SizedBox(),
            onChanged: onChanged,
            items: availableSkills
                .map(
                  (skill) => DropdownMenuItem<String>(
                    value: skill,
                    child: Text(
                      skill,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildSkillChips(List<String> skills, String type) {
    return Wrap(
      spacing: 8,
      children: skills
          .map((skill) => Chip(
                label: Text(
                  skill,
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
                backgroundColor: Colors.white.withOpacity(0.2),
                onDeleted: () {
                  setState(() {
                    if (type == "offer") {
                      selectedOfferSkills.remove(skill);
                    } else {
                      selectedLearnSkills.remove(skill);
                    }
                  });
                },
                deleteIcon: const Icon(Icons.close, color: Colors.white70),
              ))
          .toList(),
    );
  }

  void _saveSkills() {
    if (selectedOfferSkills.isEmpty && selectedLearnSkills.isEmpty) {
      Fluttertoast.showToast(msg: "Please select at least one skill.");
    } else {
      Fluttertoast.showToast(msg: "Skills saved successfully!");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ),
      );
    }
  }
}
