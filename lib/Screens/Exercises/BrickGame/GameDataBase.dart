import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GameService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeGameResult({
    required String userId,
    required int bricksBroken,
    required bool gameWon,
    required int timeSpentInSeconds,
    required int bestScore,
  }) async {
    try {
      await _firestore.collection('game2').add({
        'userId': userId,
        'bricksBroken': bricksBroken,
        'gameWon': gameWon,
        'timeSpentInSeconds': timeSpentInSeconds,
        'bestScore': bestScore,
        'timestamp': Timestamp.now(),
      });
    } catch (error) {
      print('Error storing game result: $error');
    }
  }


  Future<int> fetchBestScore(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('game2').doc(userId).get();
      if (userDoc.exists) {
        return userDoc['bestScore'] ?? 0;
      } else {
        return 0; // Default best score if user document doesn't exist
      }
    } catch (e) {
      print('Error fetching best score: $e');
      return 0; // Default best score if an error occurs
    }
  }

  Future<void> updateBestScore(String userId, int newBestScore) async {
    try {
      await _firestore.collection('game2').doc(userId).set({'bestScore': newBestScore}, SetOptions(merge: true));
    } catch (e) {
      print('Error updating best score: $e');
    }
  }
}