import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  final bool hasWon;
  final void Function()? onTapPlayAgain;
  final int bricksBroken;
  final int bestScore;

  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Color(0xFFA18AAE), letterSpacing: 0, fontSize: 28),
  );

  GameOverScreen({required this.isGameOver, required this.hasWon, this.onTapPlayAgain, 
  required this.bricksBroken,
    required this.bestScore
    });

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/Background2.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment(0, -0.2),
                child: Text(
                  hasWon ? 'Congratulations!\nYou\'ve won!' : 'GAME OVER',
                  style: gameFont,
                ),
              ),
              Container(
                alignment: Alignment(0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    
                    SizedBox(height:30),
                    Text(
                      'Bricks Broken: $bricksBroken',
                      style: TextStyle(fontSize: 18, color:Color(0xFFA18AAE)),
                    ),
                    
                    bestScore  > bricksBroken 
                        ?
                        Center( child :Text(
                            'Try Again!\n Your Pervious Score was : $bestScore',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Color(0xFFA18AAE)),
                          ),
                        )
                       : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'New Best Score! Good Job!',
            style: TextStyle(fontSize: 18, color: Color(0xFFA18AAE)),
          ),
          Text(
            'Best Score : $bricksBroken',
            style: TextStyle(fontSize: 18, color: Color(0xFFA18AAE)),
          ),
        ],
      ),
    ),
                                              SizedBox(height: 30),

              GestureDetector(
                  onTap: onTapPlayAgain,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Color(0xFFA18AAE),
                      child: Text(
                        'Play Again',
                        style: TextStyle(color: Colors.white),
                      ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }
}