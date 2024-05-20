import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhyFeelingPage extends StatelessWidget {
  const WhyFeelingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Why I'm Feeling This Way?",
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
              'assets/images/WhyThisWay.png',
              height: 160, // Adjust image height as needed
              width: 160, // Adjust image width as needed
            ),
            const SizedBox(height: 50),
            Text(
              "Past or Childhood Experiences:",
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            Text(
              "Early neglect, loss of a loved one, or overprotective parenting during childhood can influence current emotional well-being.",
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            const SizedBox(height: 15),
            Text(
              "Current Life Situation:",
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            Text(
              "Factors like chronic stress, major life changes, uncertainty about the future, academic or work pressure, unemployment, financial strain, and periods of loneliness contribute to feelings of anxiety.",
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            const SizedBox(height: 15),
            Text(
              "Physical or Mental Health Problems:",
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            Text(
              "Existing serious physical conditions or underlying mental health issues can impact mental well-being and contribute to anxiety.",
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            const SizedBox(height: 15),
            Text(
              "Traumatic Events:",
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            Text(
              "Experiencing or witnessing traumatic events can significantly contribute to anxiety, leaving a lasting impact on mental health.",
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            const SizedBox(height: 15),
            Text(
              "Genetic or Biological Factors:",
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            Text(
              "Genetic predispositions and biological factors can play a role in the development of anxiety disorders, providing insight into its origins and guiding personalized treatment approaches.",
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Color.fromARGB(255, 77, 54, 92),
              ),
              textAlign: TextAlign.center, // Center alignment for text
            ),
            const SizedBox(height: 40),
            Text(
              "Remember, anxiety doesn't have to control your life. With the right support and self-care strategies, you can manage your symptoms and live a fulfilling life. You're Not Alone!",
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