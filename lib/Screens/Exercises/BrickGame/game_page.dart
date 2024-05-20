import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brick Breaker Game'),
      ),
      body: const Center(
        child: Text(
          'Brick Breaker Game Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
