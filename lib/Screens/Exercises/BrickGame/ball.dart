

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';


class MyBall extends StatelessWidget {

final  ballX ;
final  ballY;
final bool isGameOver;
final bool hasGameStarted;



  const MyBall ({super.key, this.ballX,this.ballY,required this.isGameOver,required this.hasGameStarted,});
  
  @override
  Widget build(BuildContext context) {
    return  
    hasGameStarted?
    Container(
              alignment: Alignment(ballX, ballY),
              child: Container(
                decoration:BoxDecoration(
                  shape:BoxShape.circle,
                  color: isGameOver? const Color(0xFFA18AAE):const Color(0xFFA18AAE),),
                 
                height: 15,
                width: 15,
              ),
    )
    :Container(
                    alignment: Alignment(ballX, ballY),
 child: AvatarGlow(
          // endRadius: 60.0,
            child: Material(elevation: 8.0,
  shape: const CircleBorder(),
  child: CircleAvatar(backgroundColor:const Color(0xFFA18AAE),
  radius: 7.0,
  child:Container(
decoration: const BoxDecoration(
  shape: BoxShape.circle,
  color:Color(0xFFA18AAE),
  ),
  width: 15,
  height: 15,
  ),
),

  ),
  ),
  );

  }}
