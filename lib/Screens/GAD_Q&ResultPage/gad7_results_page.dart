import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/tabs.dart';

import 'advice_page.dart';
import 'next_steps_page.dart';
import 'why_feeling_this_way_page.dart';

class GAD7ResultsPage extends StatelessWidget {
  final int totalScore;

  const GAD7ResultsPage(this.totalScore, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: null,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF694F79),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background3.png'),
            fit: BoxFit.fill, // Fit the background to fill the screen
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Results',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF694F79),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _interpretScore(totalScore),
                    ),
                    _buildButton(
                      context,
                      'Why I\'m Feeling This Way?',
                      const WhyFeelingPage(),
                      'assets/images/WhyThisWay.png',
                      buttonHeight: 90, // Adjust button height here
                    ),
                    _buildButton(
                      context,
                      'Advice To Help You',
                      AdvicePage(totalScore),
                      'assets/images/helpyou.png',
                      buttonHeight: 90, // Adjust button height here
                    ),
                    _buildButton(
                      context,
                      'Next Steps and Follow-Up',
                      NextStepsPage(totalScore),
                      'assets/images/Nextstp.png',
                      buttonHeight: 90, // Adjust button height here
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Tabs(selectedIndex: 2),
                    ),
                    (route) => false,
                  );
                },
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
                  width: double.infinity,
                  height: 60,
                  child: Center(
                    child: Text(
                      'Done',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
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

  Widget _buildButton(
      BuildContext context, String title, Widget nextPage, String imagePath,
      {double buttonHeight = 60}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF694F79).withOpacity(0.20),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: Size(double.infinity, buttonHeight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 90,
              width: 90,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 54, 92),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _interpretScore(int score) {
    String severity = '';
    if (score <= 4) {
      severity = "Minimal";
    } else if (score <= 9) {
      severity = "Mild";
    } else if (score <= 14) {
      severity = "Moderate";
    } else {
      severity = "Severe";
    }

    String result = 'Your test score indicates that you might have:\n\n ';

    if (severity == "No") {
      result += 'No have anxiety symptoms.';
    } else {
      result += '$severity anxiety symptoms.';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        result,
        textAlign: TextAlign.center, // Center align the text
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}