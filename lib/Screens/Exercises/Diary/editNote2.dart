import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditNote2 extends StatefulWidget {
  final DocumentSnapshot docToEdit;

  const EditNote2({Key? key, required this.docToEdit}) : super(key: key);

  @override
  State<EditNote2> createState() => EditNote2State();
}

class EditNote2State extends State<EditNote2> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title.text = widget.docToEdit['title']?.join('\n') ?? '';
    content.text = widget.docToEdit['content']?.join('\n') ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              widget.docToEdit.reference.update({
                'title': title.text.split('\n'),
                'content': content.text.split('\n'),
              }).whenComplete(() => Navigator.pop(context));
            },
            child: Text(
              'Save',
              style: GoogleFonts.nunito(
                color: Color(0xFF694F79), // Text color
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300, // Set initial height to 100
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Background3.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // White color for the box
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 4, // Blur radius
                          offset: const Offset(0, 2), // Offset to create shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: title,
                      style: GoogleFonts.nunito(
                        color: Color(0xFF694F79), // Text color
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none, // Remove border
                        contentPadding:
                            EdgeInsets.all(16), // Padding for text input
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White color for the box
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 4, // Blur radius
                            offset:
                                const Offset(0, 2), // Offset to create shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: content,
                        maxLines: null,
                        expands: true,
                        style: GoogleFonts.nunito(
                          color: Color(0xFF694F79), // Text color
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Content?',
                          border: InputBorder.none, // Remove border
                          contentPadding:
                              EdgeInsets.all(16), // Padding for text input
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                widget.docToEdit.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              icon: Icon(
                Icons.delete_outline, // Trash icon
                color: Color(0xFF694F79), // Icon color
              ),
              label: Text(
                'Delete?',
                style: GoogleFonts.nunito(
                  color: Color(0xFF694F79), // Text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}