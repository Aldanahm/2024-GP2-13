import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextStepsPage extends StatelessWidget {
  final int totalScore;

  const NextStepsPage(this.totalScore, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String advice = '';
    String personalizedPlan = '';

    if (totalScore <= 4) {
      advice =
          "Continue engaging in activities that promote mental well-being and self-care practices. Consider incorporating meditation, yoga, or stress-relief activities into your routine for relaxation. Remember to prioritize your mental health and seek support from your network when needed.";
    } else if (totalScore <= 9) {
      advice =
          "Explore the sources of your anxiety and develop coping mechanisms to manage stress effectively. Consider integrating mindfulness practices, relaxation techniques, and activities that bring you joy into your routine. Building a support system and reaching out for professional guidance are valuable steps in managing mild anxiety.";
      personalizedPlan =
          "Here is a personalized plan to support your journey:\n\nBut first remember! Even a few minutes can be powerful💪.\n\n- Meditation:\n\n3 \"Soul Bells\" recommended sessions per week\n\n- Yoga:\n\n3 \"Ananda Yoga\" recommended sessions per week\n\nThis is a suggested plan. Adapt practices based on your needs and listen to your body and mind.";
    } else if (totalScore <= 14) {
      advice =
          "Prioritize daily engagement in activities that foster mental well-being and relaxation. Incorporate meditation, yoga, or stress-relief activities into your routine to manage anxiety symptoms. Consider seeking professional help to explore your feelings further and develop a comprehensive treatment plan.";
      personalizedPlan =
          "Here is a personalized plan to support your journey:\n\nBut first remember! Even a few minutes can be powerful💪.\n\n- Meditation:\n\n4 \"Soul Bells\" recommended sessions per week\n\n- Yoga:\n\n4 \"Ananda Yoga\" recommended sessions per week\n\nThis is a suggested plan. Adapt practices based on your needs and listen to your body and mind.";
    } else {
      advice =
          "Address the intensity of your anxiety comprehensively by seeking professional help. Work on identifying triggers, implementing coping strategies, and exploring therapeutic interventions. Building a support system, engaging in self-care practices, and following a comprehensive treatment plan are essential for managing severe anxiety.";
      personalizedPlan =
          "Here is a personalized plan to support your journey:\n\nBut first remember! Even a few minutes can be powerful💪.\n\n- Meditation:\n\n7 \"Soul Bells\" recommended sessions per week\n\n- Yoga:\n\n7 \"Ananda Yoga\" recommended sessions per week\n\nThis is a suggested plan. Adapt practices based on your needs and listen to your body and mind.";
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'assets/images/Nextstp.png',
              height: 160, // Adjust image height as needed
              width: 160, // Adjust image width as needed
            ),
            const SizedBox(height: 50),
            const SizedBox(height: 10),
            Text(
              advice,
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Adjust spacing as needed
            Text(
              personalizedPlan,
              style: GoogleFonts.nunito(
                fontSize: 18,
                //fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40), // Adjust spacing as needed
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