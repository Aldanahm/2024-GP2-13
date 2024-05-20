import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inner_joy/Screens/Exercises/BrickGame/coverscreen.dart';
import 'package:inner_joy/Screens/Exercises/BrickGame/ball.dart';
import 'dart:async';

import 'package:inner_joy/Screens/Exercises/BrickGame/player.dart';
import 'package:inner_joy/Screens/Exercises/BrickGame/gameOverScreen.dart';
import 'package:inner_joy/Screens/Exercises/BrickGame/brick.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inner_joy/Screens/Exercises/BrickGame/GameDatabase.dart';
//import 'package:inner_joy/Screens/Exercises/BrickGame/TimerBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class brickB extends StatefulWidget {
  // CHANGE THE NAME

  const brickB({Key? key}) : super(key: key);
  @override
  _brickBState createState() => _brickBState();


 /* static int getBestScore() {
    // Access bestScore from _brickBState directly
    return _brickBState.bestScore;
  }

*/

  
  // Static method to get the best score
  static Future<int> getBestScore() async {
    final GameService _gameService = GameService();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      return await _gameService.fetchBestScore(userId);
    } else {
      return 0;
    }
  }
}


enum direction { UP, DOWN, LEFT, RIGHT }

 class _brickBState extends State<brickB>  {
  double ballX = 0;
  double ballY = 0;
  double ballXincrements = 0.02;
  double ballYincrements = 0.01;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  double PlayerX = -0.2;
  double PlayerWidth = 0.4;

  // game set
  bool hasGameStarted = false;
  bool isGameOver = false;
  bool hasWon = false;
  bool ballFallen = false;


  
  static double brickHeight = 0.1;
  static double brickWidth = 0.6;
  static double brickGap = 0.03;
  static int numberOfBricksInRow = 3; //change the number
  int numberOfRows = 1;
   // Change the number of rows 

  List<List<dynamic>> MyBricks = [];



  final GameService _gameService = GameService();
int gamesPlayedThisWeek = 0;
  int bricksBroken = 0;
  bool gameWon = false;

  late Timer? gameTimer; 
   late Duration timerDuration;
   bool firstBrickBroken = false;
   late Color timerColor;
   int secondsElapsed = 0;
   int totalTime = 60;
   late int bricksInDatabase = 0; // Variable to store the number of bricks in the database
   static int bestScore = 0;



  @override
  void initState() {
    super.initState();
    addMoreRows(numberOfRows, numberOfBricksInRow);
 fetchBestScore(); // Fetch the best score from the database when the widget initializes

  }

  Future<void> fetchBestScore() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    int fetchedBestScore = await _gameService.fetchBestScore(userId);
    setState(() {
      bestScore = fetchedBestScore;
    });
  } else {
    print('User ID is null');
  }
}


void startGame() {
  if (ballFallen) return;//
  hasGameStarted = true;
  addMoreRows(numberOfRows,numberOfBricksInRow);

  Timer.periodic(Duration(milliseconds: 10), (timer) {
    updateDirection();
    moveBall();

     if (isPlayerDead()) {
        timer.cancel();

        isGameOver = true;
        ballFallen = true;
    }

    checkForBrokenBricks();
  });
  
}


void addMoreRows(int numberOfRows, int numberOfBricksInRow) {
  MyBricks.clear();
  double wallGap = 0.5 * (2 - numberOfBricksInRow * brickWidth - (numberOfBricksInRow - 1) * brickGap);
  double firstBrickX = -1 + wallGap;
  double firstBrickY = -0.9;

  for (int row = 0; row < numberOfRows; row++) {
    for (int col = 0; col < numberOfBricksInRow; col++) {
      MyBricks.add([
        firstBrickX + col * (brickWidth + brickGap),
        firstBrickY + row * (brickHeight + brickGap),
        false,
      ]);
    }
  }

  // Reset the ball's position after adding a new row
  ballX = 0;
  ballY = 0;
}

  



   String findMin(double a, double b, double c, double d) {
    List<double> myList = [a, b, c, d];

    double currentMin = a;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }

    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'up';
    } else if ((currentMin - d).abs() < 0.01) {
      return 'bottom';
    }

    return '';
  }
  
  void checkForBrokenBricks() {
  for (int i = 0; i < MyBricks.length; i++) {
    if (ballX >= MyBricks[i][0] &&
        ballX <= MyBricks[i][0] + brickWidth &&
        ballY >= MyBricks[i][1] &&
        ballY <= MyBricks[i][1] + brickHeight &&
        !MyBricks[i][2]) {

      setState(() {
        MyBricks[i][2] = true;
        bricksBroken++;

      });
    // Use findMin to adjust ball direction based on collision
        String minDirection = findMin(
          ballX - MyBricks[i][0], 
          (MyBricks[i][0] + brickWidth) - ballX, 
          ballY - MyBricks[i][1], 
          (MyBricks[i][1] + brickHeight) - ballY
        );

        switch (minDirection) {
          case 'left':
            ballXDirection = direction.LEFT;
            break;
          case 'right':
            ballXDirection = direction.RIGHT;
            break;
          case 'up':
            ballYDirection = direction.UP;
            break;
          case 'bottom':
            ballYDirection = direction.DOWN;
            break;
        }
      }
    }
  

  if (areAllBricksBroken()) {
     setState(() {
    
    if (numberOfRows < 9) {
      numberOfRows++; 

      
      final double speedIncreasePercentage = 0.1;// اغير الرقم  
      ballXincrements *= (1 + speedIncreasePercentage);
      ballYincrements *= (1 + speedIncreasePercentage);
    } else {
      
      numberOfRows = 1;
      numberOfBricksInRow = 3;
     
      ballXincrements = 0.02;
      ballYincrements = 0.01;
      hasWon=true;

    }

    addMoreRows(numberOfRows, numberOfBricksInRow);
  });
  }
  
}


 

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    setState(() {
      if (hasWon) {
    return;
  }
      // MOVE HORIZ
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXincrements;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballXincrements;
      }

      // MOVE VER

      if (ballYDirection == direction.DOWN) {
        ballY += ballYincrements;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYincrements;
      }
      
    });
  }




 void updateDirection() {
    setState(() {
      // ball goes up
      if (ballY >= 0.9 && ballX >= PlayerX && ballX <= PlayerX + PlayerWidth) {
        ballYDirection = direction.UP;
      }
      // ball goes down
      else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
      }
      // ball goes left
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      }

      // ball goes right
      if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }
 

  void moveLeft() {
    setState(() {
      if (!(PlayerX - 0.2 < -1)) {
        PlayerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(PlayerX + PlayerWidth >= 1)) {
        PlayerX += 0.2;
      }
    });
  }

  void resetGame() async {
 
   User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      await _gameService.storeGameResult(
        userId: userId,
        bricksBroken: bricksBroken,
        gameWon: hasWon,
        timeSpentInSeconds: secondsElapsed,
        bestScore: bestScore,
      );

  
    updateBestScoreIfNeeded(bricksBroken);
 
  setState(() {
    PlayerX = -0.2;
    ballX = 0;
    ballY = 0;
    isGameOver = false;
    hasGameStarted = false;
    ballFallen = false; 
    numberOfRows = 1;
    bricksBroken = 0;
    hasWon = false;



    addMoreRows(numberOfRows, numberOfBricksInRow);
  });
}
 
 }


  void updateBestScoreIfNeeded(int bricksBroken) async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    if (bricksBroken > bestScore) {
      // Update best score in database
      await _gameService.updateBestScore(userId, bricksBroken);
      setState(() {
        bestScore = bricksBroken;
      });
    }
  } else {
    print('User ID is null');
  }
}

bool areAllBricksBroken() {
  for (int i = 0; i < MyBricks.length; i++) {
    if (MyBricks[i][2] == false) {
      return false; 
    }
  }
  return true; 

}



@override
  Widget build(BuildContext context) {
    /*return GestureDetector(
   onHorizontalDragUpdate: (details) {
      // Move the player paddle horizontally based on drag movement
      if (details.delta.dx > 0) {
        moveRight();
      } else {
        moveLeft();
      }
    },// اغير اللي ف,ق بللي تحت عشان يكون بالمؤشر
    */
    //arrwos
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
       
      child: GestureDetector(
        onTap: hasWon ? resetGame : startGame,
        child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
       appBar: AppBar(
       leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Color(0xFF694F79),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
      
          body: Center(
            child: Stack(
              children: [
              CoverScreen(hasGameStarted: hasGameStarted,isGameOver: isGameOver,bestScore: bestScore,
              ),

              GameOverScreen(isGameOver: isGameOver,hasWon: hasWon,onTapPlayAgain: resetGame,bricksBroken: bricksBroken,bestScore: bestScore,
              ),

              MyBall(
                ballX: ballX,
                ballY: ballY,
                hasGameStarted:hasGameStarted,
                isGameOver:isGameOver,
  
              ),

              MyPlayer(
                PlayerX: PlayerX,
                PlayerWidth: PlayerWidth,
              ),
             

           for (int i = 0; i < MyBricks.length; i++) 
            MyBrick(
              brickX: MyBricks[i][0],
              brickY: MyBricks[i][1],
              brickWidth: brickWidth,
              brickHeight: brickHeight,
              brickBroken: MyBricks[i][2],
          
            ),
          
           
            ],
  
        
        ),
          ),
        ),
      ),
      ),
    );
  }
}