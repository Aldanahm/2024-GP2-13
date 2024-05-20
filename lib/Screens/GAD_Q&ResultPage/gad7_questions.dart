import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inner_joy/Screens/GAD_Q&ResultPage/gad7_results_page.dart';
//import 'package:inner_joy/Screens/PhqPage.dart';
import 'package:inner_joy/Screens/tabs.dart';
import 'package:inner_joy/email_Sender.dart'; 

class GAD7Questions extends StatefulWidget {
  const GAD7Questions({super.key});

  @override
  _GAD7QuestionsState createState() => _GAD7QuestionsState();
}

class _GAD7QuestionsState extends State<GAD7Questions> {
  int currentQuestionIndex = 0;
  List<int> userResponses = List.filled(7, -1);

  List<String> questions = [
    "Feeling nervous, anxious, or on edge?",
    "Not being able to stop or control worrying?",
    "Worrying too much about different things?",
    "Trouble relaxing?",
    "Being so restless that it's hard to sit still?",
    "Becoming easily annoyed or irritable?",
    "Feeling afraid, as if something awful might happen",
  ];

  void answerQuestion(int response) async {
    userResponses[currentQuestionIndex] = response;
    if (currentQuestionIndex < 6) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      int totalScore = userResponses.reduce((a, b) => a + b);

      // Get the current date
      DateTime now = DateTime.now();
      int year = now.year;
      int month = now.month;

      // Get the current user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid; // Retrieve the user ID from Firebase Auth

        // Reference to the Firestore instance
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Reference to the user's document
        DocumentReference userDoc = firestore.collection('users').doc(userId);

        // Get the existing data of the user's document
        final userDocSnapshot = await userDoc.get();
        final Map<String, dynamic>? userData =
            userDocSnapshot.data() as Map<String, dynamic>?;

        // Prepare a map with the new GAD7 scores data
        Map<String, dynamic> data = {
          'latestGADScore': totalScore,
        };

        // If the user document exists, update the data
        if (userData != null) {
          if (userData['gadScores'] == null) {
            data['gadScores'] = [];
          } else {
            data['gadScores'] = List.from(userData['gadScores'] as List);
          }
          data['gadScores'].add({
            'totalScore': totalScore,
            'year': year,
            'month': month,
          });
          if (userData['username'] != null) {
            data['username'] = userData['username'];
          }
        }

        // Update the user's document in Firestore with merge:true
        userDoc.set(data, SetOptions(merge: true)); //original
         
         // Now, let's save the yoga recommendations
        // Recommended times per week for yoga
        int recommendedYogaSessions = _calculateRecommendedYoga(totalScore);
        String recommendedYogaType = _calculateRecommendedYogaType(totalScore);

        int recommendedMedSessions = _calculateRecommendedMed(totalScore);
        String recommendedMedType = _calculateRecommendedMedType(totalScore);       
         // Create a collection reference for 'yoga' for the current user
        CollectionReference yogaCollectionGAD =
            firestore.collection('users').doc(userId).collection('yogaGAD');

          CollectionReference MedCollectionGAD =
            firestore.collection('users').doc(userId).collection('MedGAD');

           // const thoughtOfTheDay = [ 
             // "Anxiety is a lot like a toddler. It never stops talking, tells you you’re wrong about everything, and wakes you up at 3 a.m.",

            //  "Anxiety’s like a rocking chair. It gives you something to do, but it doesn’t get you very far.",

//"Anxiety is a thin stream of fear trickling through the mind. If encouraged, it cuts a channel into which all other thoughts are drained.",

//"Worry often gives a small thing a big shadow.",

//"Anxiety is a lot like a toddler. It never stops talking, tells you you’re wrong about everything, and wakes you up at 3 a.m.",

//"What else does anxiety about the future bring you but sorrow upon sorrow?",

//"Worrying is carrying tomorrow’s load with today’s strength — carrying two days at once. It is moving into tomorrow ahead of time. Worrying doesn’t empty tomorrow of its sorrow, it empties today of its strength.",

//"Sometimes the most important thing in a whole day is the rest taken between two deep breaths.",

//"Our anxiety does not come from thinking about the future, but from wanting to control it.",

//"Never let the future disturb you. You will meet it, if you have to, with the same weapons of reason which today arm you against the present.",

//"Do not anticipate trouble or worry about what may never happen. Keep in the sunlight.",

//"Don’t assume I’m weak because I have panic attacks. You’ll never know the amount of strength it takes to face the world every day.",

//"Just because I can’t explain the feelings causing my anxiety doesn’t make them less valid.",

//"Worrying about outcomes over which I have no control is punishing myself before the universe has decided whether I ought to be punished.",

//"Every time you are tempted to react in the same old way, ask if you want to be a prisoner of the past or a pioneer of the future.",

//"He who fears he shall suffer, already suffers what he fears.",

//"If you want to conquer the anxiety of life, live in the moment, live in the breath.",

//"To venture causes anxiety, but not to venture is to lose one’s self…. And to venture in the highest is precisely to be conscious of one’s self.",

//"Do not let your difficulties fill you with anxiety, after all it is only in the darkest nights that stars shine more brightly.",

//"You don’t have to control your thoughts. You just have to stop letting them control you.",

//"Nothing diminishes anxiety faster than action.",

//"If you always do what you’ve always done, you’ll always get what you’ve always got.",

//"I promise you nothing is as chaotic as it seems. Nothing is worth diminishing your health. Nothing is worth poisoning yourself into stress, anxiety, and fear.",

//"You may not control all the events that happen to you, but you can decide not to be reduced by them.",

//"Instead of worrying about what you cannot control, shift your energy to what you can create.",

//"Feelings come and go like clouds in a windy sky. Conscious breathing is my anchor.",

//"You don’t have to control your thoughts; you just have to stop letting them control you.",

//"I can do this… I can start over. I can save my own life and I’m never going to be alone as long as I have stars to wish on and people to still love.",

//"What lies behind us and what lies before us are tiny matters compared to what lies within us.",

//"Don’t waste your time in anger, regrets, worries, and grudges. Life is too short to be unhappy.",

//"Whatever is going to happen will happen, whether we worry or not.",

//"Difficult roads often lead to beautiful destinations. The best is yet to come.",

//"In the end, it is important to remember that we cannot become what we need to be by remaining where we are.",

//"Grant me the serenity to accept the things I cannot change, the courage to change the things I can, and the wisdom to know the difference.",

//"Surrender to what is, let go of what was, and have faith in what will be."
            //];

        // Save the recommended yoga sessions along with the date and type
        await yogaCollectionGAD.add({
          'recommendedSessionsPerWeek': recommendedYogaSessions,
          'recommendedYogaType': recommendedYogaType,
          'date': now,
          'userDoneSessions': 0, // Initial value
          //'ThoughtOfTheDay': thoughtOfTheDay
        });

        // Save the recommended yoga sessions along with the date and type
        await MedCollectionGAD.add({
          'recommendedSessionsPerWeek': recommendedMedSessions,
          'recommendedYogaType': recommendedMedType,
          'date': now,
          'userDoneSessions': 0, // Initial value
        });

         await scheduleWeeklyProgressEmail(user.email!);
         String userEmail = user.email! ;
        // print('userEmail: $userEmail');

        // Navigate to the results page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GAD7ResultsPage(totalScore), 
          ),
        );
      }
    }
  }

    // Method to calculate recommended yoga sessions based on GAD score
  int _calculateRecommendedYoga(int totalScore) {
    // Define the recommendations based on GAD score ranges
    if (totalScore <= 4) {
      return 2; // Recommended 2 sessions per week
    } else if (totalScore <= 9) {
      return 3; // Recommended 3 sessions per week
    } else if (totalScore <= 14) {
      return 4; // Recommended 4 sessions per week
    } else {
      return 7; // Recommended daily sessions
    }
  }

  // Method to calculate recommended yoga type based on GAD score
  String _calculateRecommendedYogaType(int totalScore) {
    // Define the recommended yoga type based on GAD score ranges
    if (totalScore <= 4) {
      return 'Ananda GAD Yoga';
    } else if (totalScore <= 9) {
      return 'Ananda GAD Yoga';
    } else if (totalScore <= 14) {
      return 'Ananda GAD Yoga';
    } else {
      return 'Ananda GAD Yoga';
    }
  }

    // Method to calculate recommended yoga sessions based on GAD score
  int _calculateRecommendedMed(int totalScore) {
    // Define the recommendations based on GAD score ranges
    if (totalScore <= 4) {
      return 2; // Recommended 2 sessions per week
    } else if (totalScore <= 9) {
      return 3; // Recommended 3 sessions per week
    } else if (totalScore <= 14) {
      return 4; // Recommended 4 sessions per week
    } else {
      return 7; // Recommended daily sessions
    }
  }

  // Method to calculate recommended yoga type based on GAD score
  String _calculateRecommendedMedType(int totalScore) {
    // Define the recommended yoga type based on GAD score ranges
    if (totalScore <= 4) {
      return 'SoulBells GAD Meditation';
    } else if (totalScore <= 9) {
      return 'SoulBells GAD Meditation';
    } else if (totalScore <= 14) {
      return 'SoulBells GAD Meditation';
    } else {
      return 'SoulBells GAD Meditation';
    }
  }

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
            if (currentQuestionIndex > 0) {
              setState(() {
                currentQuestionIndex--;
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                      builder: (context) => const Tabs(selectedIndex: 2),
                ),
              );
            }
          },
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Question ${currentQuestionIndex + 1} of 7',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF694F79),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                questions[currentQuestionIndex],
                style: const TextStyle(
                  fontSize: 25,
                  color: Color(0xFF694F79),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 15),
          ),
          for (int i = 0; i < 4; i++)
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFB8A2B9),
                        Color(0xFFA18AAE),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(i),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      i == 0
                          ? "Not at all"
                          : i == 1
                              ? "Several days"
                              : i == 2
                                  ? "More than half the days"
                                  : "Nearly every day",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                if (userResponses[currentQuestionIndex] == i)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}