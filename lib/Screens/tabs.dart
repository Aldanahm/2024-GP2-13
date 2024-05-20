import 'package:flutter/material.dart';
import 'package:inner_joy/Screens/Chatbot/chatbot_prev.dart';
import 'package:inner_joy/Screens/YogaPage.dart';
import 'package:inner_joy/Screens/PhqPage.dart';
import 'package:inner_joy/Screens/ProfilePage.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inner_joy/main.dart';

void setToken(String tfcm) async {
  CollectionReference ProfileToken =
      FirebaseFirestore.instance.collection('ProfileToken');
  var DocumentSnapshot = await ProfileToken.doc(tfcm).get();
  print(DocumentSnapshot.data());
  if (DocumentSnapshot.data() == null) {
    ProfileToken.doc(tfcm).set({"token": tfcm});
  }
}




class Tabs extends StatefulWidget {
  final int selectedIndex;

  const Tabs({super.key, required this.selectedIndex});

  @override
  State<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  int _selectedPageIndex = 0;


  final box = GetStorage();
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  var android = const AndroidNotificationDetails(
    'InnerJoy_App',
    'InnerJoy_App',
    channelDescription: 'channel description',
    importance: Importance.low,//
    ticker: 'ticker',
    icon: '@mipmap/ic_launcher',
    playSound: true,
  );
  _firebaseInit() async {
    await _fcm.getToken().then((value) async => {
          print(value),
          setToken(value!),
        });
    var settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        if (Platform.isAndroid) {
          var notificationsE = box.read('notificationsE');
          if (notificationsE != null && notificationsE) {
            var platform = NotificationDetails(android: android);
            notificationsPlugin.show(1, message.notification?.title,
                message.notification?.body, platform);
          }
        }
        if (kDebugMode) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
     var notificationsE = box.read('notificationsE');
     if ( notificationsE==null){
     box.write('notificationsE', false);
  

      
     }
     _firebaseInit();

    _selectedPageIndex = widget.selectedIndex;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
     // const ProfilePage(),
        ProfilePage(),
      const ChatPrevPage(),
      const PhqPage(),
      const YogaPage(),
    ];

    return Scaffold(
      appBar: null,
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        selectedItemColor: const Color(0xFF694F79),
        unselectedItemColor: const Color.fromARGB(255, 69, 68, 68),
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/profile.png')),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/chatbot.png'),
              size: 33,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/phq.png")),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/yoga.png")),
            label: "",
          ),
        ],
      ),
    );
  }
}
