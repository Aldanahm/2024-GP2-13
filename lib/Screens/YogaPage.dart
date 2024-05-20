import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/Exercises/BrickGame/brickB.dart';
import 'package:inner_joy/Screens/Exercises/Meditation/meditation1_page.dart';
import 'package:inner_joy/Screens/Exercises/Meditation/meditation2_page.dart';
import 'package:inner_joy/Screens/Exercises/Meditation/meditation3_page.dart';
import 'package:inner_joy/Screens/Exercises/Yoga/hatha_yoga.dart';
import 'package:inner_joy/Screens/Exercises/Yoga/ananda_yoga.dart';
import 'package:inner_joy/Screens/Exercises/Yoga/anusara_yoga.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class YogaPage extends StatelessWidget {
  const YogaPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 26.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Background3.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: _buildThoughtButton(context),
              ),
              Center(
                child: _buildSectionContainer(
                  title: "Meditation",
                  buttons: [
                    _buildSquareButton(
                        "Daily", "assets/images/meditation1.png", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Meditation1Page()),
                      );
                    }),
                    _buildSquareButton(
                        "Healing", "assets/images/meditation2.png",
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Meditation2Page()),
                      );
                    }),
                    _buildSquareButton(
                        "Stress", "assets/images/meditation3.png", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Meditation3Page()),
                      );
                    }),
                  ],
                  isFirstSection: true,
                ),
              ),
              Center(
                child: _buildSectionContainer(
                  title: "Yoga",
                  buttons: [
                    _buildSquareButton("Hatha", "assets/images/yoga1.png", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HathaYogaPage()),
                      );
                    }),
                    _buildSquareButton("Anusara", "assets/images/yoga2.png",
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnusaraYogaPage()),
                      );
                    }),
                    _buildSquareButton("Ananda", "assets/images/yoga3.png", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnandaYogaPage()),
                      );
                    }),
                  ],
                ),
              ),
              Center(
                child: _buildGameSection(context),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required List<Widget> buttons,
    bool isFirstSection = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _buildSectionTitle(title),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Divider(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildSeparatedButtons(buttons),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.nunito(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF694F79),
      ),
    );
  }

  List<Widget> _buildSeparatedButtons(List<Widget> buttons) {
    List<Widget> separatedButtons = [];
    for (int i = 0; i < buttons.length; i++) {
      separatedButtons.add(buttons[i]);
      if (i != buttons.length - 1) {
        separatedButtons.add(const SizedBox(width: 14.0));
      }
    }
    return separatedButtons;
  }

  Widget _buildSquareButton(
      String label, String imagePath, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF694F79).withOpacity(0.20),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: SizedBox(
        width: 110,
        height: 160,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF694F79),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _buildSectionTitle("Brick Breaker Game"),
              const SizedBox(width: 0.0),
              const Expanded(
                child: Divider(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: _buildRectangularButton(
                "Play Brick Breaker", "assets/images/game.png", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const brickB()),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildThoughtButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _buildSectionTitle("Thought of the day"),
              const SizedBox(width: 8.0),
              const Expanded(
                child: Divider(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: FutureBuilder<String>(
                future: _fetchThoughtOfTheDay(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data ?? "",
                        style: GoogleFonts.nunito(
                          fontSize: 17,
                          color: const Color(0xFF694F79),
                        ),
                      );
                    } else {
                      return Text(
                        "No thoughts found",
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF694F79),
                        ),
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget _buildRectangularButton(
      String label, String imagePath, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF694F79).withOpacity(0.20),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 160,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _fetchThoughtOfTheDay() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          // Check if the 'yogaGAD' collection exists
          QuerySnapshot yogaGADSnapshot = await firestore
              .collection('users')
              .doc(userId)
              .collection('yogaGAD')
              .get();

          DocumentSnapshot thoughtSnapshot;
          if (yogaGADSnapshot.docs.isNotEmpty) {
            thoughtSnapshot =
                await firestore.collection('Thought').doc('Anxiety').get();
          } else {
            // Check if the 'yogaPHQ' collection exists
            QuerySnapshot yogaPHQSnapshot = await firestore
                .collection('users')
                .doc(userId)
                .collection('yogaPHQ')
                .get();

            if (yogaPHQSnapshot.docs.isNotEmpty) {
              thoughtSnapshot =
                  await firestore.collection('Thought').doc('Depression').get();
            } else {
              thoughtSnapshot =
                  await firestore.collection('Thought').doc('InnerJoy').get();
            }
          }

          if (thoughtSnapshot.exists) {
            Map<String, dynamic>? data =
                thoughtSnapshot.data() as Map<String, dynamic>?;
            List<dynamic>? thoughtOfTheDay = data?['ThoughtOfTheDay'];
            if (thoughtOfTheDay != null && thoughtOfTheDay.isNotEmpty) {
              int randomIndex = Random().nextInt(thoughtOfTheDay.length);
              return thoughtOfTheDay[randomIndex];
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching thought of the day: $e");
    }
    return "";
  }
}
