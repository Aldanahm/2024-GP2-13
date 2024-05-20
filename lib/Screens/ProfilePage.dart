import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/Exercises/Diary/noteScreen.dart';
import 'package:inner_joy/Screens/PHQLineGraph/depressionscale.dart';
import 'package:inner_joy/SettingsPage.dart';
import 'package:inner_joy/screens/GADLineGraph/anxietyscale.dart';
import 'package:inner_joy/Screens/Tracking/yogaPHQ_bar.dart';
import 'package:inner_joy/Screens/Tracking/yogaGAD_bar.dart';
import 'package:inner_joy/Screens/Tracking/MeditationGAD_bar.dart';
import 'package:inner_joy/Screens/Tracking/MeditationPHQ_bar.dart';
import 'package:inner_joy/Screens/Exercises/BrickGame/brickB.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key});

  bool positive = false;

  List<Map<String, String>> accountArr = [
    {"name": "Depression Tracker                 >", "tag": "1"},
    {"name": "Anxiety Tracker                       >", "tag": "2"},
    {"name": "Yoga Progress                         >", "tag": "3"},
    {"name": "Meditation Progress                >", "tag": "4"},
    {"name": "View My Diary                         >", "tag": "5"}
  ];

  void navigateToScreen(String tag, BuildContext context) {
    switch (tag) {
      case "1":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DepressionScale(),
          ),
        );
        break;
      case "2":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AnxietyScale(),
          ),
        );
        break;
      case "3":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DeterminatePage(),
          ),
        );
        break;
      case "4":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeterminatePageGAD(),
          ),
        );
        break;
      case "5":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesScreen(),
          ),
        );
        break;
      default:
        // Do nothing
        break;
    }
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String currentFeelingMessage = '';
  bool imagesVisible = true;

  brickB score = brickB();
  int bestScore = 0;

  @override
  void initState() {
    super.initState();

    updateBestScore();
  }

  Future<void> updateBestScore() async {
    // Fetch the best score from the brickB game
    int score = await brickB.getBestScore();
    setState(() {
      bestScore = score;
    });
  }

  void switchFeelingMessage(String imagePath) {
    setState(() {
      switch (imagePath) {
        case 'assets/images/Sad1.png':
          currentFeelingMessage = [
            "It's okay to feel sad. You're not alone!",
            "Sadness is temporary. Better days are ahead!",
            "Take care of yourself during tough times!"
          ][Random().nextInt(3)];
          break;
        case 'assets/images/Worried2.png':
          currentFeelingMessage = [
            "Worrying won't change the outcome!",
            "Focus on what you can control!",
            "You're stronger than your worries!"
          ][Random().nextInt(3)];
          break;
        case 'assets/images/Normal3.png':
          currentFeelingMessage = [
            "Enjoy the peace of normalcy!",
            "Life feels good when things are balanced!",
            "Find joy in the ordinary moments!"
          ][Random().nextInt(3)];
          break;
        case 'assets/images/Happy4.png':
          currentFeelingMessage = [
            "Embrace the happiness within!",
            "Let happiness light up your world!",
            "Spread joy wherever you go!"
          ][Random().nextInt(3)];
          break;
        case 'assets/images/SoHappy5.png':
          currentFeelingMessage = [
            "Savor the sweetness of pure happiness!",
            "Your happiness is contagious!",
            "Live fully in the glow of joy!"
          ][Random().nextInt(3)];
          break;
        default:
          currentFeelingMessage = '';
          break;
      }

      imagesVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Background3.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: 210,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFB8A2B9).withOpacity(0.50),
                      const Color(0xFFA18AAE).withOpacity(0.50),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFA18AAE),
                        width: 2.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/logo2.png'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 120),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 135),
                          Text(
                            "How are you feeling today?",
                            style: GoogleFonts.nunito(
                              fontSize: 20.0,
                              color: const Color(0xFF694F79),
                            ),
                          ),
                          const SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  switchFeelingMessage(
                                      'assets/images/Sad1.png');
                                },
                                child: Opacity(
                                  opacity: imagesVisible ? 1.0 : 0.0,
                                  child: Image.asset(
                                    'assets/images/Sad1.png',
                                    width: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              GestureDetector(
                                onTap: () {
                                  switchFeelingMessage(
                                      'assets/images/Worried2.png');
                                },
                                child: Opacity(
                                  opacity: imagesVisible ? 1.0 : 0.0,
                                  child: Image.asset(
                                    'assets/images/Worried2.png',
                                    width: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              GestureDetector(
                                onTap: () {
                                  switchFeelingMessage(
                                      'assets/images/Normal3.png');
                                },
                                child: Opacity(
                                  opacity: imagesVisible ? 1.0 : 0.0,
                                  child: Image.asset(
                                    'assets/images/Normal3.png',
                                    width: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              GestureDetector(
                                onTap: () {
                                  switchFeelingMessage(
                                      'assets/images/Happy4.png');
                                },
                                child: Opacity(
                                  opacity: imagesVisible ? 1.0 : 0.0,
                                  child: Image.asset(
                                    'assets/images/Happy4.png',
                                    width: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              GestureDetector(
                                onTap: () {
                                  switchFeelingMessage(
                                      'assets/images/SoHappy5.png');
                                },
                                child: Opacity(
                                  opacity: imagesVisible ? 1.0 : 0.0,
                                  child: Image.asset(
                                    'assets/images/SoHappy5.png',
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          currentFeelingMessage.isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    currentFeelingMessage,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF694F79),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    /*Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(31, 202, 36, 36),
                              blurRadius: 2)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Account",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF694F79),
                            ),
                          ),
                          const SizedBox(height: 1),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.accountArr.length,
                            itemBuilder: (context, index) {
                              var iObj = widget.accountArr[index];
                              return ListTile(
                                title: Text(iObj["name"].toString()),
                                onTap: () {
                                  widget.navigateToScreen(
                                      iObj["tag"].toString(), context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),*/
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildTile(
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Material(
                                    color: const Color(0xFF694F79)
                                        .withOpacity(0.40),
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(Icons.timeline,
                                          color: Colors.white, size: 30.0),
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 16.0)),
                                  Text('Depression',
                                      style: GoogleFonts.nunito(
                                          color: const Color(0xFF694F79),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 21.0)),
                                  Text('Scale tracker, plan, and progress bar.',
                                      style: TextStyle(color: Colors.black45)),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DepressionScale()),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTile(
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Material(
                                    color: const Color(0xFF694F79)
                                        .withOpacity(0.40),
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(Icons.timeline,
                                          color: Colors.white, size: 30.0),
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 16.0)),
                                  Text('Anxiety',
                                      style: GoogleFonts.nunito(
                                          color: const Color(0xFF694F79),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 21.0)),
                                  Text('Scale tracker, plan, and progress bar.',
                                      style: TextStyle(color: Colors.black45)),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnxietyScale()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Add the new tile here
                    _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('My Journal',
                                    style: GoogleFonts.nunito(
                                        color: const Color(0xFF694F79),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25.0)),
                                Text('Feel free in your own space.',
                                    style: TextStyle(color: Colors.black45)),
                              ],
                            ),
                            Image.asset(
                              "assets/images/journaling.png", // Update with your image path
                              width: 135.0, // Adjust the width as needed
                              height: 135.0, // Adjust the height as needed
                              // Add any additional properties as needed
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotesScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Brick Breaker Highest Score:$bestScore',
                                  style: GoogleFonts.nunito(
                                    color: const Color(0xFF694F79),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Keep Playing and improving!',
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons
                                .whatshot, // Replace this with the desired icon
                            color: const Color.fromARGB(255, 255, 77, 0),
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 30,
                right: 15,
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildTile(Widget child, {required Function() onTap}) {
  return Material(
    elevation: 14.0,
    borderRadius: BorderRadius.circular(12.0),
    shadowColor: const Color(0xFFeed8b8),
    child: InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: child,
    ),
  );
}
}
