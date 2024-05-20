import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PHQNextStepsPage extends StatelessWidget {
  final int totalScore;

  const PHQNextStepsPage(this.totalScore, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String advice = '';
    String personalizedPlan = '';

    if (totalScore <= 4) {
      advice =
          "Continue engaging in activities that promote mental well-being and self-care practices. Consider incorporating meditation, yoga, or stress-relief activities into your routine for relaxation. Remember to prioritize your mental health and seek support from your network when needed.";
    } else if (totalScore <= 9) {
      advice =
          "Prioritize daily engagement in activities that foster mental well-being and relaxation. Incorporate meditation, yoga, or stress-relief activities into your routine to manage depression symptoms. Consider seeking professional help to explore your feelings further and develop a comprehensive treatment plan.";
      personalizedPlan =
          "Here is a personalized plan to support your journey:\n\n"
          "But first remember! Even a few minutes can be powerful💪.\n\n"
          "- Meditation:\n\n"
          "3 'Calming music' or 'Tropical Escapes' recommended sessions per week\n\n"
          "- Yoga:\n\n"
          "3 'Hatha Yoga' or 'Anusara Yoga' recommended sessions per week\n\n"
          "This is a suggested plan. Adapt practices based on your needs and listen to your body and mind.";
    } else if (totalScore <= 14) {
      advice =
          "Prioritize daily engagement in activities that foster mental well-being and relaxation. Incorporate meditation, yoga, or stress-relief activities into your routine to manage depression symptoms. Consider seeking professional help to explore your feelings further and develop a comprehensive treatment plan.";
      personalizedPlan =
          "Here is a personalized plan to support your journey:\n\n"
          "But first remember! Even a few minutes can be powerful💪.\n\n"
          "- Meditation:\n\n"
          "4 'Calming music' or 'Tropical Escapes' recommended sessions per week\n\n"
          "- Yoga:\n\n"
          "4 'Hatha Yoga' or 'Anusara Yoga' recommended sessions per week\n\n"
          "This is a suggested plan. Adapt practices based on your needs and listen to your body and mind.";
    } else {
      advice =
          "Address the intensity of your depression comprehensively by seeking professional help. Work on identifying triggers, implementing coping strategies, and exploring therapeutic interventions. Building a support system, engaging in self-care practices, and following a comprehensive treatment plan are essential for managing severe depressive symptoms.";
      personalizedPlan =
          "Here is a personalized plan to support your journey:\n\n"
          "But first remember! Even a few minutes can be powerful💪.\n\n"
          "- Meditation:\n\n"
          "7 'Calming music' or 'Tropical Escapes' recommended sessions per week\n\n"
          "- Yoga:\n\n"
          "7 'Hatha Yoga' or 'Anusara Yoga' recommended sessions per week\n\n"
          "This is a suggested plan. Adapt practices based on your needs and listen to your body and mind.";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Next Steps and Follow-Up',
          style: GoogleFonts.nunito(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
          children: [
            SizedBox(height: 30), // SizedBox added here

            Image.asset(
              'assets/images/Nextstp.png',
              height: 160, // Adjust image height as needed
              width: 160, // Adjust image width as needed
            ),
            const SizedBox(height: 50),
            Text(
              advice,
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            const SizedBox(height: 20),
            Text(
              personalizedPlan,
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Color.fromARGB(255, 77, 54, 92),
                fontWeight: FontWeight.bold, // Make the text bold
              ),
              textAlign:
                  TextAlign.center, // Center alignment for personalized plan
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
              textAlign: TextAlign.center, // Center alignment for text
            ),
          ],
        ),
      ),
    );
  }
}