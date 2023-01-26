import 'dart:math';
import 'dart:developer' as d;

import 'package:flutter/material.dart';
import 'package:picture_game/models/firebase_model.dart';
import 'package:picture_game/services/firebase_service.dart';

class MultiImageGameProvider extends ChangeNotifier {
  FirebaseModel currentWordData = FirebaseModel.empty();
  List<String> currentWordList = [];
  int score = 0;

  MultiImageGameProvider() {
    FlirebaseServiceImpl().fetchWordsData();
  }

  void generateNewWordForGame(List<FirebaseModel> allData) {
    int randomIdx = Random().nextInt(allData.length);
    currentWordData = allData[randomIdx];
    currentWordList =
        currentWordData.word.split("").map((e) => e.toUpperCase()).toList();
    currentWordList.shuffle();
  }

  bool checkIfSpellingCorrect(String userTypedWord) {
    if (currentWordData.word.toLowerCase() == userTypedWord.toLowerCase()) {
      d.log("Word spelling is correct");
      return true;
    }
    return false;
  }

  void increaseScore(List<FirebaseModel> firebaseDataSnapShot) {
    score++;
    generateNewWordForGame(firebaseDataSnapShot);
    notifyListeners();
  }

  void resetScore() {
    score = 0;
    notifyListeners();
  }
}
