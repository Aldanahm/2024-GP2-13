import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DeterminatePage extends StatefulWidget {
  const DeterminatePage({Key? key}) : super(key: key);

  @override
  _DeterminatePageState createState() => _DeterminatePageState();
}

class _DeterminatePageState extends State<DeterminatePage> {
  late Timer _timer;
  double progressValue = 0;
  double secondaryProgressValue = 0;
  bool isLoading = true;
  String progressMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    String errorMessage = '';

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          QuerySnapshot yogaSnapshot = await firestore
              .collection('users')
              .doc(userId)
              .collection('yogaPHQ')
              .get();
          if (yogaSnapshot.docs.isNotEmpty) {
            var yogaData = yogaSnapshot.docs.first.data();
            if (yogaData != null && yogaData is Map<String, dynamic>) {
              int recommendedSessionsPerWeek =
                  yogaData['recommendedSessionsPerWeek'] ?? 0;
              int userDoneSessions = yogaData['userDoneSessions'] ?? 0;

              DateTime now = DateTime.now();
              DateTime currentWeekStart =
                  now.subtract(Duration(days: now.weekday - 1));
              DateTime currentWeekEnd =
                  now.add(Duration(days: 7 - now.weekday));

              print('Current Week Start: $currentWeekStart');
              print('Current Week End: $currentWeekEnd');

              Timestamp sessionTimestamp = yogaData['date'];
              DateTime sessionDate = sessionTimestamp.toDate();
              print('Session Date: $sessionDate');

              if (sessionDate
                      .isAfter(currentWeekStart.subtract(Duration(days: 1))) &&
                  sessionDate.isBefore(currentWeekEnd.add(Duration(days: 1)))) {
                print('Session date is within the current week');
                double sessionsProgress =
                    (userDoneSessions / recommendedSessionsPerWeek) * 100;
                progressValue = sessionsProgress;
                secondaryProgressValue =
                    progressValue * 2; // Adjust secondary progress if needed
                int remainingSessions =
                    recommendedSessionsPerWeek - userDoneSessions;
                if (progressValue < 20) {
                  progressMessage =
                      "You have completed ${progressValue.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯. \n \n It's okay if you're having a tough week. Remember, being better than yesterday is enough.🧘‍♀";
                } else if (progressValue < 50) {
                  progressMessage =
                      "You have completed ${progressValue.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯. \n \n Keep going! You're doing great!🙌🏻 ";
                } else if (progressValue > 70) {
                  progressMessage =
                      "You have completed ${progressValue.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯. \n \n Almost there! Don't forget to reward yourself along the way, you've earned it!🌟";
                } else if (progressValue == 100) {
                  progressMessage =
                      "You have completed ${progressValue.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯. \n \n InnerJoy congratulates you! Here's to a better & healthier mindset 🎊💫.";
                } else {
                  progressMessage =
                      "It seems that you have completed ${progressValue.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯.  \n \n You can do it🧘‍♀.";
                }
              } else {
                print('Session date is NOT within the current week');
                errorMessage = "No data available for the current week.";
              }
            }
          } else {
            print('No data available for the current week');
            errorMessage = "No data available for the current week.";
          }
        }
      }
    } catch (error) {
      print("Error fetching user data: $error");
      errorMessage = "Error fetching user data. Please try again later.";
    } finally {
      // Set isLoading to false after data fetching is complete
      setState(() {
        progressMessage =
            errorMessage.isNotEmpty ? errorMessage : progressMessage;
        isLoading = false;
      });

      // Start the timer here
      _timer =
          Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {});
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Align the Column content to the center
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Yoga Progress Results',
                    style: GoogleFonts.nunito(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF694F79),
                    ),
                  ),
                  SizedBox(
                      width:
                          10), // Add some space between the text and the image
                  Image.asset(
                    'assets/images/NextStep.png',
                    height: 30, // Adjust the size as needed
                  ),
                ],
              ),
              SizedBox(height: 150),
              if (isLoading)
                CircularProgressIndicator()
              else
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 190,
                          width: 190,
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                minimum: 0,
                                maximum: 100,
                                showLabels: false,
                                showTicks: false,
                                radiusFactor: 0.8,
                                axisLineStyle: const AxisLineStyle(
                                  thickness: 0.4,
                                  color: Color.fromARGB(40, 0, 169, 181),
                                  thicknessUnit: GaugeSizeUnit.factor,
                                ),
                                pointers: <GaugePointer>[
                                  RangePointer(
                                    value: progressValue,
                                    width: 0.4,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    enableAnimation: true,
                                    animationDuration: 100,
                                    animationType: AnimationType.linear,
                                  )
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    positionFactor: 0.2,
                                    horizontalAlignment: GaugeAlignment.center,
                                    widget: Text(
                                      '${progressValue.toStringAsFixed(0)}%',
                                    ),
                                  )
                                ],
                              ),
                              RadialAxis(
                                minimum: 0,
                                maximum: 100,
                                showLabels: false,
                                showTicks: false,
                                showAxisLine: true,
                                tickOffset: -0.05,
                                offsetUnit: GaugeSizeUnit.factor,
                                minorTicksPerInterval: 0,
                                radiusFactor: 0.8,
                                axisLineStyle: const AxisLineStyle(
                                  thickness: 0.3,
                                  color: Colors.white,
                                  dashArray: <double>[4, 3],
                                  thicknessUnit: GaugeSizeUnit.factor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      progressMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF694F79),
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
}