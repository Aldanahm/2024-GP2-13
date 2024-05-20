import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNote2 extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  final CollectionReference ref =
      FirebaseFirestore.instance.collection('notes2');
  final User? user = FirebaseAuth.instance.currentUser;

  AddNote2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Set app bar background color to transparent
        elevation: 0, // Remove app bar elevation
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                if (user != null) {
                  await ref.add({
                    'title': [title.text],
                    'content': [content.text],
                    'userId': user!.uid,
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Save',
                style: GoogleFonts.nunito(
                  color: Color(0xFF694F79),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: title,
                    style: GoogleFonts.nunito(),
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 250, // Set initial height to 100

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: content,
                    maxLines: null,
                    style: GoogleFonts.nunito(),
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind lately?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}