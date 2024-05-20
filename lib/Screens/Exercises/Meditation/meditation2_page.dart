import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_joy/Screens/Exercises/Meditation/meditation1_page.dart';
import 'package:inner_joy/Screens/Exercises/Meditation/meditation3_page.dart';
import 'package:just_audio/just_audio.dart';

class Meditation2Page extends StatefulWidget {
  const Meditation2Page({Key? key}) : super(key: key);

  @override
  _Meditation2PageState createState() => _Meditation2PageState();
}

class _Meditation2PageState extends State<Meditation2Page> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isSessionDone = false;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  Future<void> _setupAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setAudioSource(
      AudioSource.asset(
        "assets/audio/HealingMeditation.mp3",
      ),
    );
    _audioPlayer.playerStateStream.listen((playerState) {
      setState(() {
        _isPlaying = playerState.playing;
      });
    });
  }

  void _markSessionAsDone() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot sessionQuerySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('MedPHQ')
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      if (sessionQuerySnapshot.docs.isNotEmpty) {
        String sessionId = sessionQuerySnapshot.docs.first.id;

        await firestore
            .collection('users')
            .doc(userId)
            .collection('MedPHQ')
            .doc(sessionId)
            .update({'userDoneSessions': FieldValue.increment(1)});

        setState(() {
          _isSessionDone = true; // Mark session as done
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF694F79)),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            const SizedBox(height: 90),
            Center(
              child: Image.asset('assets/images/meditation2.png', width: 250),
            ),
            const SizedBox(height: 20),
            Text(
              "Healing Meditation",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                textStyle: Theme.of(context).textTheme.headline5,
                color: const Color(0xFF694F79),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 0.1,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    StreamBuilder<Duration?>(
                      stream: _audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        return ProgressBar(
                          progress: snapshot.data ?? Duration.zero,
                          buffered: _audioPlayer.bufferedPosition,
                          total: const Duration(
                              minutes: 17,
                              seconds: 16), // Update total duration
                          onSeek: (duration) {
                            _audioPlayer.seek(duration);
                          },
                          timeLabelLocation: TimeLabelLocation.below,
                          timeLabelTextStyle: GoogleFonts.nunito(
                            color: const Color(0xFF694F79),
                            fontSize: 12,
                          ),
                          progressBarColor: const Color(
                              0xFF694F79), // Color of the progress bar
                          thumbColor:
                              const Color(0xFF694F79), // Color of the thumb
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_isPlaying) {
                              _audioPlayer.pause();
                            } else {
                              _audioPlayer.play();
                            }
                          },
                          icon: _isPlaying
                              ? const Icon(CupertinoIcons.pause)
                              : const Icon(CupertinoIcons.play),
                          color: const Color(0xFF694F79),
                        ),
                        GestureDetector(
                          onTap: _isSessionDone
                              ? null
                              : () {
                                  _markSessionAsDone();
                                },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Color.fromRGBO(
                                      105, 79, 121, 1), // Initial outline color
                                ),
                                if (_isSessionDone)
                                  Icon(
                                    Icons.check_circle,
                                    color: Color.fromRGBO(
                                        210, 197, 218, 1), // Filled color
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Recommendations",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                textStyle: Theme.of(context).textTheme.headline5,
                color: const Color(0xFF694F79),
              ),
            ),
            const SizedBox(height: 5),
            ...List.generate(2, (index) {
              String label =
                  index == 0 ? "Daily Meditation" : "Stress Meditation";
              String duration = index == 0 ? "12:58" : "12:15";

              return Card(
                color: Colors.white,
                elevation: 0.1,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Meditation1Page(),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Meditation3Page(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          index == 0
                              ? 'assets/images/meditation1.png'
                              : 'assets/images/meditation3.png',
                          width: 50,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label,
                              style: GoogleFonts.nunito(
                                textStyle:
                                    Theme.of(context).textTheme.headline6,
                                color: const Color(0xFF694F79),
                              ),
                            ),
                            Text(
                              duration,
                              style: GoogleFonts.nunito(
                                textStyle:
                                    Theme.of(context).textTheme.subtitle2,
                                color: const Color(0xFF694F79),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.play_arrow),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}