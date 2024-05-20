import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/PHQLineGraph/phqChartWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inner_joy/Screens/Tracking/yogaPHQ_bar.dart';
import 'package:inner_joy/Screens/Tracking/MeditationPHQ_bar.dart';

class DepressionScale extends StatelessWidget {
  const DepressionScale({Key? key});

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
                    'Depression Scale',
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
                            title: const Text("Depression Scale"),
                            content: const Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "This represents your score on the depression test over time.",
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Remember, every step counts towards your well-being!",
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
              const phqChartWidget(), // Add PHQ chart here
              const SizedBox(height: 30),
              FutureBuilder<bool>(
                future: checkDataForCurrentYear(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data == true) {
                      return FutureBuilder<int>(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            int latestPHQScore = snapshot.data!;
                            int id = choosePhaseId(latestPHQScore);
                            return DepressionManagementPage(id: id);
                          }
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
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
                              builder: (context) => DeterminatePage()),
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
                              builder: (context) => DeterminatePageMedPHQ()),
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

Future<bool> checkDataForCurrentYear() async {
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

      // Get the "phqScores" array from the user document
      List<dynamic>? phqScores = userSnapshot['phqScores'];

      // Filter scores based on the current year
      int currentYear = DateTime.now().year;
      List<dynamic>? currentYearScores =
          phqScores?.where((entry) => entry['year'] == currentYear).toList();

      return currentYearScores != null && currentYearScores.isNotEmpty;
    } catch (e) {
      print('Error checking data for current year: $e');
      throw e;
    }
  } else {
    throw Exception("User not authenticated");
  }
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

      // Get the latestPHQScore field from the user document
      int latestPHQScore = userSnapshot.get('latestPHQScore');
      return latestPHQScore;
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  } else {
    throw Exception("User not authenticated");
  }
}

int choosePhaseId(int latestPHQScore) {
  if (latestPHQScore >= 0 && latestPHQScore <= 4) {
    return 1;
  } else if (latestPHQScore >= 5 && latestPHQScore <= 9) {
    return 2;
  } else if (latestPHQScore >= 10 && latestPHQScore <= 14) {
    return 3;
  } else if (latestPHQScore >= 15 && latestPHQScore <= 19) {
    return 4;
  } else if (latestPHQScore >= 20 && latestPHQScore <= 27) {
    return 5;
  } else {
    throw Exception("Invalid PHQ score");
  }
}

class DepressionManagementPage extends StatelessWidget {
  final int id;

  const DepressionManagementPage({Key? key, required this.id})
      : super(key: key);

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
                child: _DepressionPhaseTitle(
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

  _DepressionPhaseInfo _data(int id) {
    switch (id) {
      case 1:
        return _DepressionPhaseInfo(
          phase: 'Minimal Depression Plan',
          phaseProcesses: [
            _DepressionPhaseProcess(
              steps:
                  '\n- Begin practicing "Hatha Yoga" or "Anusara Yoga" sessions (2 times a week) for gentle postures and breathing exercises.',
            ),
            _DepressionPhaseProcess(
              steps:
                  '- Start with "Daily Meditation" or "Healing Meditation" sessions (2 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      case 2:
        return _DepressionPhaseInfo(
          phase: 'Mild Depression Plan',
          phaseProcesses: [
            _DepressionPhaseProcess(
              steps:
                  '\n- Begin practicing "Hatha Yoga" or "Anusara Yoga" sessions (3 times a week) for gentle postures and breathing exercises.',
            ),
            _DepressionPhaseProcess(
              steps:
                  '- Start with "Daily Meditation" or "Healing Meditation" sessions (3 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      case 3:
        return _DepressionPhaseInfo(
          phase: 'Moderate Depression Plan',
          phaseProcesses: [
            _DepressionPhaseProcess(
              steps:
                  '\n- Initiate "Hatha Yoga" or "Anusara Yoga" sessions (4 times a week) to enhance well-being and reduce tension.',
            ),
            _DepressionPhaseProcess(
              steps:
                  '- Start with "Daily Meditation" or "Healing Meditation" sessions (4 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      case 4:
        return _DepressionPhaseInfo(
          phase: 'Moderately Severe Depression Plan',
          phaseProcesses: [
            _DepressionPhaseProcess(
              steps:
                  '\n- Begin "Hatha Yoga" or "Anusara Yoga" sessions (7 times a week) for a comprehensive approach to physical and mental well-being.',
            ),
            _DepressionPhaseProcess(
              steps:
                  '- Start with "Daily Meditation" or "Healing Meditation" sessions (7 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      case 5:
        return _DepressionPhaseInfo(
          phase: 'Severe Depression Plan',
          phaseProcesses: [
            _DepressionPhaseProcess(
              steps:
                  '\n- Begin "Hatha Yoga" or "Anusara Yoga" sessions (7 times a week) for a comprehensive approach to physical and mental well-being.',
            ),
            _DepressionPhaseProcess(
              steps:
                  '- Start with "Daily Meditation" or "Healing Meditation" sessions (7 times a week) for relaxation and mental well-being.',
            ),
          ],
        );
      default:
        throw Exception("");
    }
  }
}

class _DepressionPhaseTitle extends StatelessWidget {
  const _DepressionPhaseTitle({
    Key? key,
    required this.phaseInfo,
  }) : super(key: key);

  final _DepressionPhaseInfo phaseInfo;

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

class _DepressionPhaseInfo {
  const _DepressionPhaseInfo({
    required this.phase,
    required this.phaseProcesses,
  });

  final String phase;
  final List<_DepressionPhaseProcess> phaseProcesses;
}

class _DepressionPhaseProcess {
  const _DepressionPhaseProcess({
    required this.steps,
  });

  final String steps;
}
