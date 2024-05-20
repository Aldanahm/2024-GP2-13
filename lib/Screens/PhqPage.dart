import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/GAD_Q&ResultPage/gad7_questions.dart';
import 'package:inner_joy/Screens/PHQ_Q&ResultPage/phq9_questions.dart';

class PhqPage extends StatelessWidget {
  const PhqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 55, left: 16, right: 16), // Added padding
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16), // Added padding
                    child: Text(
                      'Your mental health matters to us!',
                      textAlign: TextAlign.center, // Adjusted text alignment
                      style: GoogleFonts.nunito(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF694F79),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16), // Added padding
                    child: Text(
                      'Discover its level through InnerJoy assessments',
                      textAlign: TextAlign.center, // Adjusted text alignment
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                        color: const Color(0xFF694F79),
                      ),
                    ),
                  ),
                  const SizedBox(height: 90),
                  _buildTestButton(
                    context,
                    'Depression Scale',
                    'assets/images/Depression.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PHQ9Questions()),
                      );
                    },
                  ),
                  _buildTestButton(
                    context,
                    'Anxiety Scale',
                    'assets/images/Anxiety.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GAD7Questions()),
                      );
                    },
                  ),
                  const SizedBox(height: 125), // Added SizedBox
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16), // Added padding
                    child: Text(
                      'Disclaimer: These assessments are not diagnostic tools or therapeutic interventions.',
                      //textAlign: TextAlign.center, // Adjusted text alignment
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        color: const Color.fromARGB(255, 135, 135, 135),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestButton(BuildContext context, String label, String imagePath,
      VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 150,
            height: 150,
          ),
          SizedBox(
            width: double.infinity,
            height: 160,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF694F79).withOpacity(0.20),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                label,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
