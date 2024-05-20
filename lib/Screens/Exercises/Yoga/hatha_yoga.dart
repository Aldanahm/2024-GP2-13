import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HathaYogaPage extends StatefulWidget {
  const HathaYogaPage({super.key});

  @override
  _HathaYogaPageState createState() => _HathaYogaPageState();
}

class _HathaYogaPageState extends State<HathaYogaPage> {
  // Create a list to store the content of each container
  final List<Map<String, dynamic>> _poses = [
    {
      'title': 'Centering',
      'time': '5 minutes',
      'content': [
        Text(
          '',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 380, // Adjust width as needed
          height: 150, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/centering.gif'),
        ),
        Text(
          'Sit comfortably, close your eyes, and focus on your breath.',
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
          'Cat-Cow Pose: 3 rounds.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/CatCow.gif'),
        ),
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
      'title': 'Standing Poses',
      'time': '10 minutes',
      'content': [
        Text(
          'Warrior II Pose: 3 breaths.',
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
          'Warrior I Pose: 2 repetitions each side.',
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
      'title': 'Seated Poses',
      'time': '5 minutes',
      'content': [
        Text(
          'Seated Forward Bend: 2 repetitions.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/SFB.gif'),
        ),
        Text(
          'Sit on the floor with your legs extended in front of you and your feet flexed. Inhale to lengthen your spine, then exhale and hinge at the hips to fold forward from the pelvis. Reach your hands towards your feet, grasping your ankles or shins. Keep your back flat and lengthened, leading with your chest. Hold the pose for a few breaths, deepening the stretch with each exhale. Avoid rounding your back.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Bound Angle Pose: 2 repetitions.',
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: const Color(0xFF694F79),
          ),
        ),
        SizedBox(
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: Image.asset('assets/images/YogaPoses/BoundAngle.gif'),
        ),
        Text(
          'Sit on the floor with your legs extended in front of you. Bend your knees and bring the soles of your feet together, allowing your knees to drop towards the ground. Hold onto your feet and gently press your knees towards the ground, opening your hips. Keep your spine long and your chest lifted. You can gently flap your knees up and down like butterfly wings to deepen the stretch. Hold the pose for a few breaths, relaxing into the stretch with each exhale.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: const Color(0xFF694F79),
          ),
        ),
        const SizedBox(height: 12),
      ],
    },
    {
      'title': 'Cool Down',
      'time': '5 minutes',
      'content': [
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