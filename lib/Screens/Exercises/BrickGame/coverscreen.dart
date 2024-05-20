import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CoverScreen extends StatelessWidget {
final bool isGameOver;
  final bool hasGameStarted;

final int bestScore;

   static var gameFont=GoogleFonts.pressStart2p(
    textStyle: TextStyle(color:  Color(0xFFA18AAE),letterSpacing: 0,fontSize: 28) );

  CoverScreen({required this.hasGameStarted, required this.isGameOver,required this.bestScore
  });


  @override
  Widget build(BuildContext context) {
    return hasGameStarted? Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/Background2.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
      //alignment: Alignment(0, -0.5),
     // child: Text(isGameOver?'':
       // 'BRICK BREAKER',
        //style: gameFont.copyWith(color:  Color(0xFFA18AAE)),
     // ),
    )
    : Stack(
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
        'BRICK BREAKER',
        style: gameFont,
      ),
    ),
     
  
     Container(
      alignment: Alignment(0, -0.1),
      child: Text(
        'tap to play',
        style: TextStyle(color: Color(0xFFA18AAE),),
      ),
     ),
                Container(
                  alignment: Alignment(0, 0.1),
                  child: Text(
                    'Best Score:$bestScore',//${bestScore > bricksBroken ? bestScore : bricksBroken} 
                    style: TextStyle(color: Color(0xFFA18AAE)),
                  ),
                ),

      ],
    );
  }
}