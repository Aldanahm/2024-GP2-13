import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: const Color(0xFF694F79),
        ), // Set the background color to transparent
        elevation: 0, // Remove the elevation
        title: Text(
          'InnerJoy Policy',
          style: GoogleFonts.nunito(
            color: const Color(0xFF694F79),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Our app is designed to provide mental wellness resources and tools, but it is not intended to replace professional therapy or medical advice. We take your privacy seriously and only collect and store your email address for authentication purposes. Your data is kept confidential and is accessible only to authorized personnel for administrative purposes.',
                    style: GoogleFonts.nunito(
                      color: const Color(0xFF694F79),
                      fontSize: 18, // Increased font size
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'By using our app, you acknowledge and agree to the terms of our privacy policy.',
                    style: GoogleFonts.nunito(
                      color: const Color(0xFF694F79),
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Increased font size
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFB8A2B9), Color(0xFFA18AAE)],
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Perform your action here
                        Navigator.of(context)
                            .pop(); // Navigate back to the previous screen
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 60),
                        elevation: 0,
                      ),
                      child: Text(
                        'Done',
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
