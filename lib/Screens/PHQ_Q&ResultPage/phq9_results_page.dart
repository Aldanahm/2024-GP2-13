import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/tabs.dart';

import 'PHQAdvicePage.dart';
import 'PHQNextStepsPage.dart';
import 'PHQWhyFeelingPage.dart';

class PHQResultsPage extends StatelessWidget {
  final int totalScore;

  const PHQResultsPage(this.totalScore, {Key? key}) : super(key: key);

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
                        textAlign: TextAlign.center, // Center the text
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _interpretScore(totalScore),
                    ),
                    _buildButton(
                      context,
                      'Why I\'m Feeling This Way?',
                      const PHQWhyFeelingPage(),
                      'assets/images/WhyThisWay.png',
                      isFullWidth: true,
                      imageHeight: 100, // Adjust image height as needed
                      imageWidth: 100, // Adjust image width as needed
                    ),
                    _buildButton(
                      context,
                      'Advice To Help You',
                      PHQAdvicePage(totalScore),
                      'assets/images/helpyou.png',
                      isFullWidth: true,
                      imageHeight: 100, // Adjust image height as needed
                      imageWidth: 100, // Adjust image width as needed
                    ),
                    _buildButton(
                      context,
                      'Next Steps and Follow-Up',
                      PHQNextStepsPage(totalScore),
                      'assets/images/Nextstp.png',
                      isFullWidth: true,
                      imageHeight: 100, // Adjust image height as needed
                      imageWidth: 100, // Adjust image width as needed
                    ),
                    const SizedBox(
                        height: 20), // Add space between buttons and result
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
      {bool isFullWidth = false,
      double imageHeight = 50,
      double imageWidth = 50}) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16, right: 16.0, top: 16), // Adjust vertical padding here
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
          padding: const EdgeInsets.symmetric(
              horizontal: 19), // Adjust vertical padding
          minimumSize: isFullWidth ? const Size(double.infinity, 120) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                height: imageHeight, // Adjust image height as needed
                width: imageWidth, // Adjust image width as needed
              ),
            ),
            const SizedBox(width: 10), // Add space between image and text
            Expanded(
              flex: 3, // Adjust flex for text to center vertically
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 77, 54, 92),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _interpretScore(int score) {
    String severity = '';

    if (score == 0) {
      severity = "No";
    } else if (score <= 4) {
      severity = "Minimal";
    } else if (score <= 9) {
      severity = "Mild";
    } else if (score <= 14) {
      severity = "Moderate";
    } else if (score <= 19) {
      severity = "Moderately severe";
    } else {
      severity = "Severe";
    }

    String result = 'Your test score indicates that you might have:\n\n ';

    if (severity == "No") {
      result += 'No have depression symptoms';
    } else {
      result += '$severity depression symptoms';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          result,
          textAlign: TextAlign.center, // Center the text
          style: GoogleFonts.nunito(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontSize: 16,
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
      ),
    );
  }
}