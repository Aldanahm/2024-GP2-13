import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvicePage extends StatelessWidget {
  final int totalScore;

  const AdvicePage(this.totalScore, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String severity = '';
    String advice = '';

    if (totalScore <= 4) {
      severity = "Minimal";
      advice =
          "It's great that you're not experiencing anxiety at the moment. Continue prioritizing self-care and maintaining a healthy routine. Remember to prioritize your mental health, and if stressors arise, consider implementing relaxation techniques to manage them effectively.";
    } else if (totalScore <= 9) {
      severity = "Mild";
      advice =
          "Even though your case is not severe, explore what might be contributing to these feelings and work on developing coping strategies. Incorporating relaxation techniques, engaging in activities that bring you joy, and reaching out to your support network when needed are valuable steps in managing mild anxiety.";
    } else if (totalScore <= 14) {
      severity = "Moderate";
      advice =
          "Delve into the sources of your anxiety and develop coping mechanisms. Consider mindfulness practices, cognitive-behavioral techniques, and setting realistic expectations. Building a strong support system and seeking professional guidance are crucial for managing moderate anxiety.";
    } else {
      severity = "Severe";
      advice =
          "Address the intensity of your anxiety comprehensively. Work on identifying triggers, implementing coping strategies, and seeking professional help. Therapy, medication options, and a comprehensive treatment plan are essential for managing severe anxiety.";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advice To Help You',
          style: GoogleFonts.nunito(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'assets/images/helpyou.png',
              height: 160, // Adjust image height as needed
              width: 160, // Adjust image width as needed
            ),
            const SizedBox(height: 50),
            Text(
              "Your Anxiety Level: $severity",
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _getColorForSeverity(severity),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            const SizedBox(height: 50),
            Text(
              advice,
              style: GoogleFonts.nunito(
                fontSize: 18,
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            const SizedBox(height: 40),
            Text(
              "You are advised to take this test on a monthly basis to keep track from not escalating into more severe conditions.",
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForSeverity(String severity) {
    if (severity == "Minimal") {
      return Colors.green;
    } else if (severity == "Mild") {
      return Colors.orange;
    } else if (severity == "Moderate") {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}