import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'Login.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  List<Map<String, String>> onboardingData = [
    {
      "title": "Master New Skills",
      "description":
          "Unlock endless opportunities by exchanging skills globally.",
      "animationPath": "assets/animations/skill.json"
    },
    {
      "title": "Learn Anytime",
      "description":
          "Connect with mentors anytime, anywhere and learn together.",
      "animationPath": "assets/animations/learning.json"
    },
    {
      "title": "Empower Your Network",
      "description": "Build valuable relationships and grow your expertise.",
      "animationPath": "assets/animations/community.json"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF043927), Color(0xFF00796B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return buildOnboardingPage(
                  onboardingData[index]["title"]!,
                  onboardingData[index]["description"]!,
                  onboardingData[index]["animationPath"]!,
                );
              },
            ),

            // Skip and Next Buttons
            Positioned(
              top: 50,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  _navigateToSignup(context);
                },
                child: Text(
                  "Skip",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),

            // Next or Done Button
            Positioned(
              bottom: 100,
              right: 30,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  if (currentIndex == onboardingData.length - 1) {
                    _navigateToSignup(context);
                  } else {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  }
                },
                child: Icon(
                  currentIndex == onboardingData.length - 1
                      ? Icons.done
                      : Icons.arrow_forward,
                  color: const Color(0xFF00796B),
                ),
              ),
            ),

            // Page Indicator Dots
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardingData.length, (index) {
                  return buildDotIndicator(index == currentIndex);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Onboarding Page Layout with Glassmorphism
  Widget buildOnboardingPage(String title, String description, String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  path,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dot Indicator for Page View
  Widget buildDotIndicator(bool isActive) {
    return Container(
      height: 10,
      width: isActive ? 25 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isActive ? Colors.white : Colors.grey.withOpacity(0.5),
      ),
    );
  }

  // Navigation to Signup/Login
  void _navigateToSignup(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
