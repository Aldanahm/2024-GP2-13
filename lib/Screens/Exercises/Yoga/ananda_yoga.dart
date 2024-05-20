import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnandaYogaPage extends StatefulWidget {
  const AnandaYogaPage({super.key});

  @override
  _AnandaYogaPageState createState() => _AnandaYogaPageState();
}

class _AnandaYogaPageState extends State<AnandaYogaPage> {
  // Create a list to store the content of each container
  final List<Map<String, dynamic>> _poses = [
    {
      'title': 'Pranayama and Affirmations',
      'time': '5 minutes',
      'content': [
        Text(
          'Alternate Nostril Breathing:',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 380, // Adjust width as needed
          height: 150, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/pranayama.gif'),
        ),
        Text(
          'Just focus on breathing.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Warm-up',
      'time': '5 minutes',
      'content': [
        Text(
          'Cat-Cow Pose: 2 rounds.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        Image.asset('assets/images/YogaPoses/CatCow.gif'),
        Text(
          'Start on your hands and knees, with your wrists directly under your shoulders and your knees directly under your hips. As you inhale, arch your back and lift your tailbone and head towards the ceiling (Cow Pose). As you exhale, round your spine and tuck your chin towards your chest (Cat Pose). Continue flowing between these two poses for the specified duration.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Gentle Asanas',
      'time': '5 minutes',
      'content': [
        Text(
          'Bound Angle Pose: 2 repetitions.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        Image.asset('assets/images/YogaPoses/BoundAngle.gif'),
        Text(
          'Sit on the floor with your legs extended in front of you. Bend your knees and bring the soles of your feet together, allowing your knees to drop towards the ground. Hold onto your feet and gently press your knees towards the ground, opening your hips.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Heart-Opening Poses',
      'time': '10 minutes',
      'content': [
        Text(
          'Dancer\'s Pose: 2 repetitions.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        Image.asset('assets/images/YogaPoses/Dancer.gif'),
        Text(
          'Stand with your feet hip-width apart. Shift your weight onto your left foot and lift your right heel towards your buttocks, grabbing the inside of your right foot with your right hand. Extend your left arm forward for balance. Keep your gaze focused and your body stable as you hold the pose. Repeat on the opposite side.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        Text(
          'Triangle Pose: 2 repetitions.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        Image.asset('assets/images/YogaPoses/Triangle.gif'),
        Text('Start by standing with your feet about 3-4 feet apart. Turn your right foot out 90 degrees and your left foot in slightly. Extend your arms out to the sides at shoulder height. Hinge at your right hip and reach your right hand down towards your right shin, ankle, or the floor, while reaching your left hand up towards the ceiling. Keep your torso open and your gaze directed up or towards your left hand. Hold the pose and then switch sides.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Pranayama and Meditation',
      'time': '5 minutes',
      'content': [
        Text(
          'Dirga Pranayama (Three-Part Breath):',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        Image.asset('assets/images/YogaPoses/HB.gif'),
        Text(
          'Sit comfortably with your spine straight and your shoulders relaxed. Place your hands on your belly, close your eyes, and take a deep breath in through your nose, feeling your belly expand. Exhale slowly through your nose, feeling your belly contract. Continue this deep breathing pattern, focusing on each inhale and exhale.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        Text(
          'Guided meditation: 2 minutes.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        Image.asset('assets/images/YogaPoses/HK.gif'),
        Text(
          'Find a comfortable seated position with your spine straight and your hands resting on your knees or in your lap. Close your eyes and take a few deep breaths to center yourself. Begin to focus on your breath, letting go of any thoughts or distractions. As you continue to breathe deeply, imagine a sense of inner peace and joy filling your body with each inhale and spreading throughout your entire being with each exhale.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Relaxation',
      'time': '5 minutes',
      'content': [
        Text(
          'Corpse Pose:',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        Image.asset('assets/images/YogaPoses/Corpse.gif'),
        Text(
          'Lie down on your back with your arms by your sides and your legs extended. Close your eyes and allow your body to completely relax into the floor. Focus on your breath and let go of any tension or stress in your body. Stay in this pose for the specified duration, enjoying the feeling of relaxation and renewal.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    // Add other poses here similarly
  ];

  // Create a list to store the expansion state of each container
  late List<bool> _isExpandedList;

  @override
  void initState() {
    super.initState();
    _isExpandedList = List.generate(_poses.length, (index) => false);
  }

void _markSessionAsDone() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the reference to the last yoga session document for the current user
      QuerySnapshot sessionQuerySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('yogaGAD')
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      if (sessionQuerySnapshot.docs.isNotEmpty) {
        String sessionId = sessionQuerySnapshot.docs.first.id;

        // Increment the userDonesessions field in Firestore
        await firestore
            .collection('users')
            .doc(userId)
            .collection('yogaGAD')
            .doc(sessionId)
            .update({'userDoneSessions': FieldValue.increment(1)});
      }
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            _poses.length,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/NextStep.png',
                      width: 20, // Adjust size as needed
                      height: 20, // Adjust size as needed
                    ),
                    const SizedBox(width: 8), // Adjust spacing as needed
                    Text(
                      _poses[index]['title'],
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF694F79),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Duration: ${_poses[index]['time']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                children: _poses[index]['content'],
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    _isExpandedList[index] = isExpanded;
                  });
                },
                initiallyExpanded: _isExpandedList[index],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Call the function to mark session as done
            _markSessionAsDone();

             // Navigate to the Tabs screen
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const Tabs(selectedIndex: 3),
              ),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(350, 60),
          ),
          child: Text(
            "Done",
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF694F79),
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}