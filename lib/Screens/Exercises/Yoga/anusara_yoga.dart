import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnusaraYogaPage extends StatefulWidget {
  const AnusaraYogaPage({super.key});

  @override
  _AnusaraYogaPageState createState() => _AnusaraYogaPageState();
}

class _AnusaraYogaPageState extends State<AnusaraYogaPage> {
  // Create a list to store the content of each container
  final List<Map<String, dynamic>> _poses = [
    {
      'title': 'Opening Poses',
      'time': '5 minutes',
      'content': [
        Text(
          'Cat-Cow Pose: 2 rounds.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 380, // Adjust width as needed
          height: 150, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/CatCow.gif'),
        ),
        Text(
          'Begin on your hands and knees, with your wrists directly under your shoulders and your knees directly under your hips. Inhale as you arch your back, bringing your chest forward and your tailbone towards the ceiling (Cow Pose). Exhale as you round your back, bringing your chin to your chest and your tailbone down (Cat Pose). Repeat for 2 rounds.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Standing Backbend Pose: 3 breaths.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/SB.gif'),
        ),
        Text(
          'Stand with your feet hip-width apart. Inhale as you reach your arms overhead, arching your back gently and looking up. Exhale as you release your',
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
          'Warrior I Pose: 2 repetitions.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/WarriorI.gif'),
        ),
        Text(
          'Start in a lunge position with your right foot forward and your left foot back. Bend your right knee at a 90-degree angle, keeping it directly over your ankle. Inhale as you raise your arms overhead, reaching towards the ceiling. Hold for a few breaths, then switch sides. This pose strengthens your legs, opens your chest and shoulders, and improves balance and focus.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Chair Pose: 2 repetitions.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/Chair.gif'),
        ),
        Text(
          'Stand with your feet together and your arms by your sides. Inhale as you raise your arms overhead, palms facing each other. Exhale as you bend your knees and lower your hips as if sitting back into a chair. Hold for a few breaths, then stand up. Chair Pose strengthens your thighs, ankles, calves, and spine while stimulating your heart, diaphragm, and abdominal organs. It also stretches your shoulders and tones your core muscles.',
style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Standing Poses',
      'time': '10 minutes',
      'content': [
        Text(
          'Warrior II Pose',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/WarriorII.gif'),
        ),
        Text(
          'Start in a lunge position with your right foot forward and your left foot back. Rotate your left foot so it is perpendicular to your right foot. Bend your right knee at a 90-degree angle, keeping it directly over your ankle. Extend your arms out to the sides, parallel to the floor, and gaze over your right hand. Hold for a few breaths, then switch sides.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Eagle Pose',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/Eagle.gif'),
        ),
        Text(
          'Stand with your feet together. Bend your knees slightly and lift your left foot off the ground, crossing it over your right thigh. Hook your left foot behind your right calf if possible. Extend your arms out to the sides, then cross your left arm over your right arm at the elbows, bringing your palms together. Hold for a few breaths, then switch sides.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Balancing Poses',
      'time': '5 minutes',
      'content': [
        Text(
          'Tree Pose',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/Tree.gif'),
        ),
        Text(
          'Stand with your feet together and your arms by your sides. Shift your weight onto your right foot and lift your left foot off the ground, placing the sole of your left foot on the inside of your right thigh or calf. Press your foot into your leg and your leg into your foot. Bring your palms together in front of your chest. Hold for a few breaths, then switch sides.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Cool Down Poses',
      'time': '5 minutes',
      'content': [
        Text(
          'Seated Meditation',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/HK.gif'),
        ),
        Text(
          'Find a comfortable seated position with your spine straight and your hands resting on your knees or in your lap. Close your eyes and take a few deep breaths to center yourself. Begin to focus on your breath, letting go of any thoughts or distractions. Sit in silence for 3 minutes, focusing on your breath and allowing your mind to relax.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
const SizedBox(height: 12),
        Text(
          'Corpse Pose',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/Corpse.gif'),
        ),
        Text(
          'Lie down on your back with your arms by your sides and your legs extended. Close your eyes and allow your body to completely relax into the floor. Focus on your breath and let go of any tension or stress in your body. Stay in this pose for 2 minutes, enjoying the feeling of relaxation and renewal.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
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
          .collection('yogaPHQ')
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      if (sessionQuerySnapshot.docs.isNotEmpty) {
        String sessionId = sessionQuerySnapshot.docs.first.id;

        // Increment the userDonesessions field in Firestore
        await firestore
            .collection('users')
            .doc(userId)
            .collection('yogaPHQ')
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