


import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {


final  PlayerX ;
final PlayerWidth;


  const MyPlayer  ({super.key, this.PlayerX,this.PlayerWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2*PlayerX+PlayerWidth)/(2-PlayerWidth), 0.9),
      child:ClipRRect(
        borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 10,
        width: MediaQuery.of(context).size.width * PlayerWidth / 2,
        color: const Color(0xFFA18AAE),
      ),
      ),
    );

  }
  }