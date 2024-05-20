import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/screens/GADLineGraph/gadChartWidget.dart'; // Import GAD chart widget
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inner_joy/Screens/Tracking/yogaGAD_bar.dart';
import 'package:inner_joy/Screens/Tracking/MeditationGAD_bar.dart';

class AnxietyScale extends StatelessWidget {
  const AnxietyScale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Anxiety Scale',
                    style: GoogleFonts.nunito(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF694F79),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      // Show description dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Anxiety Scale"),
                            content: const Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "This represents your score on the anxiety test over time.",
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Stay strong! You're not alone in this journey.",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.info,
                      color: Color(0xFFB8A2B9),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const gadChartWidget(),
              const SizedBox(height: 30),
              FutureBuilder<int>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    int latestGADScore = snapshot.data!;
                    int id = choosePhaseId(latestGADScore);
                    return FutureBuilder<bool>(
                      future: hasDataForCurrentYear(),
                      builder: (context, yearSnapshot) {
                        if (yearSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (yearSnapshot.hasError) {
                          return Text('Error: ${yearSnapshot.error}');
                        } else {
                          bool hasData = yearSnapshot.data ?? false;
                          if (hasData) {
                            return AnxietyManagementPage(id: id);
                          } else {
                            return Container(); // Hide the container if no data for this year
                          }
                        }
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                              color: const Color(0xFF694F79).withOpacity(0.40),
                              shape: CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.donut_large_sharp,
                                    color: Colors.white, size: 30.0),
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 16.0)),
                            Text('Yoga Progress',
                                style: GoogleFonts.nunito(
                                    color: const Color(0xFF694F79),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0)),
                            Text('See how far you are along in yoga.',
                                style: TextStyle(color: Colors.black45)),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeterminatePageGAD()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                              color: const Color(0xFF694F79).withOpacity(0.40),
                              shape: CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.donut_large_sharp,
                                    color: Colors.white, size: 30.0),
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 16.0)),
                            Text('Meditation Progress',
                                style: GoogleFonts.nunito(
                                    color: const Color(0xFF694F79),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0)),
                            Text('See how far you are along in meditation.',
                                style: TextStyle(color: Colors.black45)),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeterminatePageMedGAD()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> fetchData() async {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      try {
        // Get the Firestore instance
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Reference to the user document in the "users" collection
        DocumentReference userDoc = firestore.collection('users').doc(userId);

        // Get the user document
        DocumentSnapshot userSnapshot = await userDoc.get();

        // Get the latestGADScore field from the user document
        int latestGADScore = userSnapshot.get('latestGADScore');
        return latestGADScore;
      } catch (e) {
        print('Error fetching data: $e');
        throw e;
      }
    } else {
      throw Exception("User not authenticated");
    }
  }

  int choosePhaseId(int latestGADScore) {
    if (latestGADScore >= 0 && latestGADScore <= 4) {
      return 1;
    } else if (latestGADScore >= 5 && latestGADScore <= 9) {
      return 2;
    } else if (latestGADScore >= 10 && latestGADScore <= 14) {
      return 3;
    } else if (latestGADScore >= 15 && latestGADScore <= 21) {
      return 4;
    } else {
      throw Exception("Invalid GAD score");
    }
  }

  Future<bool> hasDataForCurrentYear() async {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      try {
        // Get the Firestore instance
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Reference to the user document in the "users" collection
        DocumentReference userDoc = firestore.collection('users').doc(userId);

        // Get the user document
        DocumentSnapshot userSnapshot = await userDoc.get();

        // Get the "gadScores" array from the user document
        List<dynamic>? gadScores = userSnapshot['gadScores'];

        // Filter scores based on the current year
        int currentYear = DateTime.now().year;
        List<dynamic>? currentYearScores =
            gadScores?.where((entry) => entry['year'] == currentYear).toList();

        return currentYearScores != null && currentYearScores.isNotEmpty;
      } catch (e) {
        print('Error checking data for current year: $e');
        throw e;
      }
    } else {
      throw Exception("User not authenticated");
    }
  }

  Widget _buildTile(Widget child, {required Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: const Color(0xFFeed8b8),
      child: InkWell(
        onTap: onTap != null ? () => onTap() : () {},
        child: child,
      ),
    );
  }
}

class AnxietyManagementPage extends StatelessWidget {
  final int id;

  const AnxietyManagementPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = _data(id);
    return Center(
      child: Container(
        width: 360.0,
        height: 320,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 300,
        ), // Adjust height dynamically
        child: Card(
          margin: EdgeInsets.all(1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _AnxietyPhaseTitle(
                  phaseInfo: data,
                ),
              ),
              Divider(height: 1.0),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.phaseProcesses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        data.phaseProcesses[index].steps,
                        style: GoogleFonts.nunito(
                          color: const Color(0xFF694F79),
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _AnxietyPhaseInfo _data(int id) {
    switch (id) {
      case 1:
        return _AnxietyPhaseInfo(
          phase: 'Minimal Anxiety Plan',
          phaseProcesses: [
            _AnxietyPhaseProcess(
              steps:
                  '\n- Begin practicing "Ananda Yoga" sessions (2 times a week) for gentle postures and breathing exercises.',
            ),
            _AnxietyPhaseProcess(
              steps:
                  '- Start with "Stress Meditation" sessions (2 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      case 2:
        return _AnxietyPhaseInfo(
          phase: 'Mild Anxiety Plan',
          phaseProcesses: [
            _AnxietyPhaseProcess(
              steps:
                  '\n- Begin practicing "Ananda Yoga" sessions (3 times a week) for gentle postures and breathing exercises.',
            ),
            _AnxietyPhaseProcess(
              steps:
                  '- Start with "Stress Meditation" sessions (3 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      case 3:
        return _AnxietyPhaseInfo(
          phase: 'Moderate Anxiety Plan',
          phaseProcesses: [
            _AnxietyPhaseProcess(
              steps:
                  '\n- Initiate "Ananda Yoga" sessions (4 times a week) to enhance well-being and reduce tension.',
            ),
            _AnxietyPhaseProcess(
              steps:
                  '- Start with "Stress Meditation" sessions (4 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      case 4:
        return _AnxietyPhaseInfo(
          phase: 'Severe Anxiety Plan',
          phaseProcesses: [
            _AnxietyPhaseProcess(
              steps:
                  '\n- Begin "Ananda Yoga" sessions (7 times a week) for a comprehensive approach to physical and mental well-being.',
            ),
            _AnxietyPhaseProcess(
              steps:
                  '- Start with "Stress Meditation" sessions (7 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      default:
        throw Exception("");
    }
  }
}

class _AnxietyPhaseTitle extends StatelessWidget {
  const _AnxietyPhaseTitle({
    Key? key,
    required this.phaseInfo,
  }) : super(key: key);

  final _AnxietyPhaseInfo phaseInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${phaseInfo.phase}',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF694F79),
            fontSize: 15,
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class _AnxietyPhaseInfo {
  const _AnxietyPhaseInfo({
    required this.phase,
    required this.phaseProcesses,
  });

  final String phase;
  final List<_AnxietyPhaseProcess> phaseProcesses;
}

class _AnxietyPhaseProcess {
  const _AnxietyPhaseProcess({
    required this.steps,
  });

  final String steps;
}
