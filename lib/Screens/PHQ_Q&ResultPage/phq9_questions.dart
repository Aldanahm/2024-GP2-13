import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:inner_joy/Screens/PhqPage.dart';
import 'package:inner_joy/Screens/PHQ_Q&ResultPage/phq9_results_page.dart';
import 'package:inner_joy/Screens/tabs.dart';
import 'package:inner_joy/email_Sender.dart'; 

class PHQ9Questions extends StatefulWidget {
  const PHQ9Questions({super.key});

  @override
  _PHQ9QuestionsState createState() => _PHQ9QuestionsState();
}

class _PHQ9QuestionsState extends State<PHQ9Questions> {
  int currentQuestionIndex = 0;
  List<int> userResponses = List.filled(9, -1);

  List<String> questions = [
    "Little interest or pleasure in doing things?",
    "Feeling down, depressed, or hopeless?",
    "Trouble falling or staying asleep, or sleeping too much?",
    "Feeling tired or having little energy?",
    "Poor appetite or overeating?",
    "Feeling bad about yourself or that you are a failure or have let yourself or your family down?",
    "Trouble concentrating on things, such as reading the newspaper or watching television?",
    "Moving or speaking so slowly that other people could have noticed, or the opposite - being so fidgety or restless that you have been moving around a lot more than usual?",
    "Thoughts that you would be better off dead or of hurting yourself in some way"
  ];

  void answerQuestion(int response) async {
    userResponses[currentQuestionIndex] = response;
    if (currentQuestionIndex < 8) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      int totalScore = userResponses.reduce((a, b) => a + b);

      DateTime now = DateTime.now();
      int year = now.year;
      int month = now.month;

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        FirebaseFirestore firestore = FirebaseFirestore.instance;

        DocumentReference userDoc = firestore.collection('users').doc(userId);

        final userDocSnapshot = await userDoc.get();
        final Map<String, dynamic>? userData =
            userDocSnapshot.data() as Map<String, dynamic>?;

        Map<String, dynamic> data = {
          'latestPHQScore': totalScore,
        };

        if (userData != null) {
          if (userData['phqScores'] == null) {
            data['phqScores'] = [];
          } else {
            data['phqScores'] = List.from(userData['phqScores'] as List);
          }
          data['phqScores'].add({
            'totalScore': totalScore,
            'year': year,
            'month': month,
          });
          if (userData['username'] != null) {
            data['username'] = userData['username'];
          }
        }
        // Set the PHQ scores data in Firestore
        userDoc.set(data, SetOptions(merge: true));

        // Now, let's save the yoga recommendations
        // Recommended times per week for yoga
        int recommendedYogaSessions = _calculateRecommendedYoga(totalScore);
        String recommendedYogaType = _calculateRecommendedYogaType(totalScore);

        int recommendedMedSessions = _calculateRecommendedMed(totalScore);
        String recommendedMedType = _calculateRecommendedMedType(totalScore);

        // Create a collection reference for 'yoga' for the current user
        CollectionReference yogaCollectionPHQ =
            firestore.collection('users').doc(userId).collection('yogaPHQ');
        CollectionReference MedCollectionGAD =
            firestore.collection('users').doc(userId).collection('MedPHQ');
        // Save the recommended yoga sessions along with the date, type, and initial done sessions
        //const thoughtOfTheDay = [
//"Remember, you are not alone in this journey. Even when it feels like the world is against you, there are people who care about you and want to support you through your struggles.",

//"Progress may be slow, but each small step forward is a victory worth celebrating.",

//"It's important to acknowledge and honor your emotions, even the painful ones. Your feelings are valid and deserve to be recognized.",

//"Asking for help takes courage, not weakness. It's okay to reach out to friends, family, or professionals for support when you're struggling.",

//"Even when you feel weak and powerless, remember that you possess an inner strength and resilience that can carry you through the toughest of times. ",

//"Believe in yourself and your ability to overcome the challenges you face.",

//"You are worthy of happiness and fulfillment, just as you are. Don't let your depression convince you otherwise.",

//"You deserve to experience joy and contentment, and it's possible to find happiness even amidst the darkness.",

//"Take each day as it comes, one step at a time. Focus on the present moment and tackle each challenge as it arises.",

//"By taking small, manageable steps forward, you can gradually navigate your way through difficult times.",

//"Know that you are deeply loved and valued, even when it feels like no one understands what you're going through." ,

//"You are a unique and irreplaceable individual, and the world is a better place with you in it.",

//"Be gentle with yourself and recognize that you're doing the best you can with the resources and energy you have available.",

//"It's okay to not have all the answers or to feel overwhelmed at times. Give yourself permission to take things one day at a time.",

//"Even in the darkest moments, there is always a glimmer of hope shining through. Hold onto that hope and know that brighter days lie ahead." ,

//"You are capable of weathering the storm and emerging stronger on the other side.",

//"Remember, you're never alone in this struggle." ,

//"Even when it feels like the weight of the world is on your shoulders, there are countless others who understand & empathize with what you're going through.",

//"Though it may seem like the darkness will never lift, this difficult chapter in your life will eventually pass.",

//"Never doubt that you are worthy of love and support, regardless of what depression or anxiety may whisper in your ear.",

//"Your emotions are valid and worthy of acknowledgment. Don't let anyone, including yourself, dismiss or invalidate what you're feeling." ,

//"Give yourself permission to feel, and remember that it's okay not to be okay.",

//"Every small step forward, no matter how insignificant it may seem, is a testament to your resilience and courage. ",

//"Celebrate your progress, no matter how slow, and take pride in the strength it took to get where you are.",

//"In a world that often expects us to have it all together, it's important to acknowledge that it's okay to struggle. " ,

//"Give yourself permission to embrace your vulnerabilities and seek the support you need.",

//"You are enough, just as you are. Remember that your worthiness isn't determined by external validation. Embrace your inherent value and self-worth.",

//"Reflect on all the challenges you've overcome and the battles you've won." ,

//"Each trial you've faced has only made you stronger and more resilient. Trust in your ability to weather the storms ahead.",

//"Your struggles do not define you; they are merely chapters in your story of resilience.",

//"You are not broken; you are a masterpiece in the making, sculpted by your struggles and forged by your strength.",

//"Though the road may be rocky and the journey arduous, every step forward is a triumph of the spirit.",

//"Your worth is not diminished by your mental health challenges. You are valued, cherished, and deserving of love and support.",

//"Embrace your imperfections, for they are what make you beautifully human. You are enough, just as you are.",

//"The scars you carry are not signs of weakness, but reminders of the battles you've fought and the strength you possess."
        //   ];
        await yogaCollectionPHQ.add({
          'recommendedSessionsPerWeek': recommendedYogaSessions,
          'recommendedYogaType': recommendedYogaType,
          'date': now,
          'userDoneSessions': 0, // Initial value
          // 'ThoughtOfTheDay': thoughtOfTheDay
        });

        // Save the recommended yoga sessions along with the date and type
        await MedCollectionGAD.add({
          'recommendedSessionsPerWeek': recommendedMedSessions,
          'recommendedYogaType': recommendedMedType,
          'date': now,
          'userDoneSessions': 0, // Initial value
        });
        await scheduleWeeklyProgressEmail(user.email!);
        // Navigate to the results page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PHQResultsPage(totalScore),
          ),
        );
      }
    }
  }

  // Method to calculate recommended yoga sessions based on PHQ score
  int _calculateRecommendedYoga(int totalScore) {
    // Define the recommendations based on PHQ score ranges
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

  // Method to calculate recommended yoga type based on PHQ score
  String _calculateRecommendedYogaType(int totalScore) {
    // Define the recommended yoga type based on PHQ score ranges
    if (totalScore <= 4) {
      return 'Hatha + Anusara PHQ Yoga';
    } else if (totalScore <= 9) {
      return 'Hatha + Anusara PHQ Yoga';
    } else if (totalScore <= 14) {
      return 'Hatha + Anusara PHQ Yoga';
    } else {
      return 'Hatha + Anusara PHQ Yoga';
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
      return 'Hatha & Anusara PHQ Med';
    } else if (totalScore <= 9) {
      return 'Hatha & Anusara PHQ Med';
    } else if (totalScore <= 14) {
      return 'Hatha & Anusara PHQ Med';
    } else {
      return 'Hatha & Anusara PHQ Med';
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
                'Question ${currentQuestionIndex + 1} of 9',
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
