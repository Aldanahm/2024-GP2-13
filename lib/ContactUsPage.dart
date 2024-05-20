import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: GoogleFonts.nunito(
            color: const Color(0xFF694F79),
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: const Color(0xFF694F79),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'We\'re here to help!',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 77, 54, 92),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'If you have any questions or feedback, please feel free to reach out to us via the following channels:',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: const Color(0xFF694F79),
                ),
              ),
              const SizedBox(height: 80),
              Row(
                children: [
                  Icon(Icons.email, size: 30, color: Color.fromARGB(255, 77, 54, 92),),
                  const SizedBox(width: 10),
                  Text(
                    'InnerJoy02@gmail.com',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: const Color(0xFF694F79),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone, size: 30, color: Color.fromARGB(255, 77, 54, 92),),
                  const SizedBox(width: 10),
                  Text(
                    '+966 535373329',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: const Color(0xFF694F79),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset('assets/images/Instagram.png', width: 28,),
                  const SizedBox(width: 10),
                  Text(
                    'InnerJoy.sa',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: const Color(0xFF694F79),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
