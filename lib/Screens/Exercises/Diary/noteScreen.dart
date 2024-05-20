import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/Exercises/Diary/addNote2.dart';
import 'package:inner_joy/Screens/Exercises/Diary/editNote2.dart';

class NotesScreen extends StatelessWidget {
  final ref = FirebaseFirestore.instance.collection('notes2');

  NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Journal',
          style: GoogleFonts.nunito(
            color: Color(0xFF694F79), // Text color
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white), // Plus icon color
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNote2()),
          );
        },
        backgroundColor: Color(0xFF694F79), // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Set the button shape
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: ref.where('userId', isEqualTo: user?.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var title = documents[index]['title']?.toString() ?? '';
                var content = documents[index]['content']?.toString() ?? '';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditNote2(docToEdit: documents[index]),
                      ),
                    );
                  },
                  child: _buildNoteContainer(
                    context,
                    title,
                    content,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNoteContainer(
    BuildContext context,
    String title,
    String content,
  ) {
    title = title.replaceAll('[', '').replaceAll(']', '');
    content = content.replaceAll('[', '').replaceAll(']', '');

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // White color for the box
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 4, // Blur radius
            offset: const Offset(0, 2), // Offset to create shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.isNotEmpty ? title : '',
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF694F79),
                fontSize: 23, // Increase font size
              ),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            content.isNotEmpty ? content : '',
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                color: Color(0xFF694F79),
                fontSize: 18, // Increase font size
              ),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}