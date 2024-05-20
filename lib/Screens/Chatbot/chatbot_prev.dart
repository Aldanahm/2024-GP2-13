import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/Chatbot/Chatbot.dart';

class ChatPrevPage extends StatelessWidget {
  const ChatPrevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background4.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Your BEST virtual friend is here!",
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    color: const Color(0xFF694F79),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 70),
                /* Padding(
                  padding: const EdgeInsets.only(
                      left: 150.0), // Adjust the left padding as needed
                  child: Transform.rotate(
                    angle: 330 * pi / 180,
                    child: 
                Image.asset(
                  'assets/images/Joy1bg.png',
                  width: 380,
                  height: 280,
                ),
                //),
                // )*/
                const SizedBox(height: 475),
                Text(
                  "How can I help you?",
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: const Color(0xFF694F79),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Chatbot()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.transparent, backgroundColor: Colors.transparent, fixedSize: const Size(355, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(0),
                    shadowColor: Colors.transparent,
                  ).copyWith(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    textStyle: MaterialStateProperty.all(
                      GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.transparent;
                        }
                        return null;
                      },
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFB8A2B9),
                          Color(0xFFA18AAE),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 60,
                    child: Center(
                      child: Text(
                        "Start a new chat",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
