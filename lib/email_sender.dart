import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inner_joy/firebase_options.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:inner_joy/Screens/HomePage.dart';
import 'package:inner_joy/SettingsPage.dart';

Future<void> scheduleWeeklyProgressEmail(String userEmail) async {
  try {
    // Get the value of notificationsEnabled from SettingsPage
    final notificationsEnabled = !getNotificationsEnabled();

    // Check if email notifications are enabled
    if (notificationsEnabled) {
      // Email notifications are disabled, return early
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        // Check if the 'lastSent' field exists in the document
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;
        sendProgressEmail(user.email!);
        if (userData != null && userData.containsKey('lastSent')) {
          Timestamp? lastSentTimestamp = userData['lastSent'];

          // Check if lastSentTimestamp is null or not
          DateTime lastSentDate = lastSentTimestamp?.toDate() ?? DateTime.now();

          // Calculate the next execution time based on lastSentDate
          DateTime nextExecutionTime = lastSentDate.add(Duration(days: 7));
          // Calculate the delay until the next execution time
          Duration difference = nextExecutionTime.difference(DateTime.now());

          // Delay the execution until the next scheduled time
          await Future.delayed(difference);

          // Send the progress email directly
          sendProgressEmail(user.email!);

          // Update the last sent timestamp in Firestore
          await userDoc.reference.update({'lastSent': Timestamp.now()});
        } else {
          // If 'lastSent' field does not exist, initialize it with current timestamp
          await userDoc.reference
              .set({'lastSent': Timestamp.now()}, SetOptions(merge: true));
        }
      }
    }
  } catch (e) {
    print("Error scheduling weekly progress email: $e");
  }
}

Future<void> sendProgressEmail(String userEmail) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;
      print('user email: $userEmail');

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();
      //print('user id: $user.uid' );
      if (userDoc.exists) {
        String userId = user.uid;

        // Fetch progress data for MedGAD
        String progressMessageMedGAD = await _fetchProgressMessage(
            firestore, userId, 'MedGAD', 'In Your Meditation Plan for Anxiety');

        // Fetch progress data for MedPHQ
        String progressMessageMedPHQ = await _fetchProgressMessage(
            firestore, userId, 'MedPHQ', 'In Your Meditation Plan for Depression');

        // Fetch progress data for yogaGAD
        String progressMessageYogaGAD = await _fetchProgressMessage(
            firestore, userId, 'yogaGAD', 'In Your Yoga Plan for Anxiety');

        // Fetch progress data for yogaPHQ
        String progressMessageYogaPHQ = await _fetchProgressMessage(
            firestore, userId, 'yogaPHQ', 'In Your Yoga Plan Depression');

        // Combine progress messages
        String combinedProgressMessage = '''
          Weekly Progress Update:
          - MedGAD: $progressMessageMedGAD
          - MedPHQ: $progressMessageMedPHQ
          - YogaGAD: $progressMessageYogaGAD
          - YogaPHQ: $progressMessageYogaPHQ
        ''';
        print('skjbvjb $combinedProgressMessage');
        // Create SMTP server configuration
        final smtpServer = SmtpServer(
          'smtp.gmail.com',
          username:
              'innerjoy02@gmail.com', // Replace with your Gmail email address
          //password: 'InnerJoy123_', // Replace with your Gmail password
          password: 'wvoj wvbn abhu syrf',
          port: 465,
          ssl: true,
        );

        // Send the progress message to the user's email
        final message = Message()
          ..from = Address('innerjoy02@gmail.com', 'InnerJoy')
          ..recipients.add(userEmail)
          ..subject = 'Your Weekly Progress Update'
          ..text = combinedProgressMessage;

        final sendReport = await send(message, smtpServer);
        print('Email sent: $sendReport');
      }
    }
  } catch (e) {
    print("Error fetching data or sending email: $e");
  }
}

Future<String> _fetchProgressMessage(FirebaseFirestore firestore, String userId,
    String collectionName, String categoryTitle) async {
  String errorMessage = '';

  try {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      QuerySnapshot progressSnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection(collectionName)
          .get();
      if (progressSnapshot.docs.isNotEmpty) {
        var progressData = progressSnapshot.docs.first.data();
        if (progressData != null && progressData is Map<String, dynamic>) {
          int recommendedSessionsPerWeek =
              progressData['recommendedSessionsPerWeek'] ?? 0;
          int userDoneSessions = progressData['userDoneSessions'] ?? 0;
          DateTime now = DateTime.now();
          DateTime currentWeekStart =
              now.subtract(Duration(days: now.weekday - 1));
          DateTime currentWeekEnd = now.add(Duration(days: 7 - now.weekday));
          Timestamp sessionTimestamp = progressData['date'];
          DateTime sessionDate = sessionTimestamp.toDate();

          if (sessionDate
                  .isAfter(currentWeekStart.subtract(Duration(days: 1))) &&
              sessionDate.isBefore(currentWeekEnd.add(Duration(days: 1)))) {
            double sessionsProgress =
                (userDoneSessions / recommendedSessionsPerWeek) * 100;
            int remainingSessions =
                recommendedSessionsPerWeek - userDoneSessions;
            String progressMessage;

            if (sessionsProgress < 20) {
              progressMessage =
                  "You have completed ${sessionsProgress.toStringAsFixed(0)}%. \n          You have $remainingSessions more sessions to complete this week’s target🎯.";
            } else if (sessionsProgress < 50) {
              progressMessage =
                  "You have completed ${sessionsProgress.toStringAsFixed(0)}%. \n          You have $remainingSessions more sessions to complete this week’s target🎯.";
            } else if (sessionsProgress > 70) {
              progressMessage =
                  "You have completed ${sessionsProgress.toStringAsFixed(0)}%. \n          You have $remainingSessions more sessions to complete this week’s target🎯.";
            } else if (sessionsProgress == 100) {
              progressMessage =
                  "You have completed ${sessionsProgress.toStringAsFixed(0)}%. \n          You have $remainingSessions more sessions to complete this week’s target🎯.";
            } else {
              progressMessage =
                  "It seems that you have completed ${sessionsProgress.toStringAsFixed(0)}%. \n          You have $remainingSessions more sessions to complete this week’s target🎯.";
            }

            return '$categoryTitle: $progressMessage';
          } else {
            errorMessage = "Session date is NOT within the current week";
          }
        }
      } else {
        errorMessage = "No data available for the current week";
      }
    }
  } catch (error) {
    print("Error fetching user data: $error");
    errorMessage = "Error fetching user data. Please try again later.";
  }

  return errorMessage;
}
