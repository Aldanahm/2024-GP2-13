import 'package:flutter/material.dart';
import 'package:inner_joy/Screens/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';


Future<void> handelBackgroundMessage(RemoteMessage message) async {
  var android = const AndroidNotificationDetails(
    'InnerJoy_App_Background',
    'InnerJoy_App_Background',
    channelDescription: 'channel description',
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    ticker: 'ticker',
    icon: '@mipmap/ic_launcher',
  );
  final box = GetStorage();
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (message.notification != null) {
    if (Platform.isAndroid) {
      var notificationsE = box.read('notificationsE');
      if (notificationsE!= null && notificationsE) {
        var platform = NotificationDetails(android: android);
        notificationsPlugin.show(1, message.notification?.title,
            message.notification?.body, platform);
      }
    }
    if (kDebugMode) {
      print('Message also contained a notification: ${message.notification}');
    }
  }
  if (kDebugMode) {
    print(message.notification!.title);
  }
}





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:inner_joy/Screens/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server/gmail.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());

  // Initialize timezones
  tzdata.initializeTimeZones();

  // Schedule to send progress email weekly
  scheduleWeeklyProgressEmail();
}

void scheduleWeeklyProgressEmail() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        // Check if the 'lastSent' field exists in the document
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

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
          sendProgressEmail();

          // Update the last sent timestamp in Firestore
          await userDoc.reference.update({'lastSent': Timestamp.now()});
        } else {
          // If 'lastSent' field does not exist, initialize it with current timestamp
          await userDoc.reference.set({'lastSent': Timestamp.now()}, SetOptions(merge: true));
        }
      }
    }
  } catch (e) {
    print("Error scheduling weekly progress email: $e");
  }
}

void sendProgressEmail() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail =
          user.email!; // Fetch email from Firebase Authentication

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        String userId = user.uid;

        // Fetch progress data for MedGAD
        String progressMessageMedGAD = await _fetchProgressMessage(
            firestore, userId, 'MedGAD', 'Meditation for Anxiety');

        // Fetch progress data for MedPHQ
        String progressMessageMedPHQ = await _fetchProgressMessage(
            firestore, userId, 'MedPHQ', 'Meditation for Depression');

        // Fetch progress data for yogaGAD
        String progressMessageYogaGAD = await _fetchProgressMessage(
            firestore, userId, 'yogaGAD', 'Yoga for Anxiety');

        // Fetch progress data for yogaPHQ
        String progressMessageYogaPHQ = await _fetchProgressMessage(
            firestore, userId, 'yogaPHQ', 'Yoga for Depression');

        // Combine progress messages
        String combinedProgressMessage = '''
          Weekly Progress Update:
          - MedGAD: $progressMessageMedGAD
          - MedPHQ: $progressMessageMedPHQ
          - YogaGAD: $progressMessageYogaGAD
          - YogaPHQ: $progressMessageYogaPHQ
        ''';

        // Send the progress message to the user's email
        final smtpServer = gmail('innerjoy02@gmail.com', 'InnerJoy123_');
        final message = mailer.Message()
          ..from = mailer.Address('innerjoy02@gmail.com', 'InnerJoy')
          ..recipients.add(userEmail)
          ..subject = 'Your Weekly Progress Update'
          ..text = combinedProgressMessage;

        final sendReport = await mailer.send(message, smtpServer);
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
                  "You have completed ${sessionsProgress.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯.";
            } else if (sessionsProgress < 50) {
              progressMessage =
                  "You have completed ${sessionsProgress.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯.";
            } else if (sessionsProgress > 70) {
              progressMessage =
                  "You have completed ${sessionsProgress.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯.";
            } else if (sessionsProgress == 100) {
              progressMessage =
                  "You have completed ${sessionsProgress.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯.";
            } else {
              progressMessage =
                  "It seems that you have completed ${sessionsProgress.toStringAsFixed(0)}%. \n You have $remainingSessions more sessions to complete this week’s target🎯.";
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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
*/
