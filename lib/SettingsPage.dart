import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/EditProfilePage.dart';
import 'package:inner_joy/PrivacyPolicyPage.dart';
import 'package:inner_joy/Screens/HomePage.dart';
import 'package:inner_joy/Screens/ProfilePage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inner_joy/ContactUsPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// Define a global variable to store the notifications enabled state
bool notificationsEnabled = false;




 



// Define a global function to get the value of notificationsEnabled
bool getNotificationsEnabled() {
  return notificationsEnabled;
}



class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}






class _SettingsPageState extends State<SettingsPage> {
  final box = GetStorage();


  @override
 @override
  Widget build(BuildContext context) {
        bool notificationsE = box.read('notificationsE') ?? false;//true 

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF694F79)),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Background3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 60,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicyPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'InnerJoy Policy',
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: const Color(0xFF694F79),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF694F79),
                            ),
                          ],
                        ),
                      ),
                    ),
                                        const Divider(
                      color: Colors.grey,
                      height: 0.5,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notifications',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF694F79),
                              ),
                            ),
                            Switch(
                              value: notificationsE,
                              onChanged: (value) {
                                setState(() {
                                  notificationsE = value;
                                  box.write('notificationsE', value);
                                });
                              },
                              activeTrackColor: const Color(0xFF694F79),
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 0.5,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Weekly progress email',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF694F79),
                              ),
                            ),
                            Switch(
                              value: notificationsEnabled,
                              onChanged: (value) {
                                setState(() {
                                  notificationsEnabled = value;
                                });
                              },
                              activeTrackColor: const Color(0xFF694F79),
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 0.5,
                    ),
                    SizedBox(
                      height: 60,
                      child: TextButton(
                        onPressed: () {
                          // Navigate to Privacy Policy Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ContactUsPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Contact us',
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: const Color(0xFF694F79),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF694F79),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 0.5,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB8A2B9), Color(0xFFA18AAE)],
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      minimumSize: const Size(double.infinity, 60),
                      elevation: 0,
                    ),
                    child: Text(
                      'Log Out',
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
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