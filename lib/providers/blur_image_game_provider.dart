import 'dart:math';
import 'dart:developer' as d;

import 'package:flutter/material.dart';
import 'package:picture_game/models/firebase_model.dart';
import 'package:picture_game/services/firebase_service.dart';

class BlurImageGameProvider extends ChangeNotifier {
  FirebaseModel currentWordData = FirebaseModel.empty();
  List<String> currentWordList = [];
  double blurImageCounter = 20;

  BlurImageGameProvider() {
    FlirebaseServiceImpl().fetchWordsData();
  }

  void generateNewWordForGame(List<FirebaseModel> allData) {
    int randomIdx = Random().nextInt(allData.length);
    currentWordData = allData[randomIdx];
    currentWordList =
        currentWordData.word.split("").map((e) => e.toUpperCase()).toList();
    currentWordList.shuffle();
    blurImageCounter = 20;
  }

  bool checkIfSpellingCorrect(String userTypedWord) {
    if (currentWordData.word.toLowerCase() == userTypedWord.toLowerCase()) {
      d.log("Word spelling is correct");
      return true;
    }
    blurImageCounter -= 5;
    if (blurImageCounter <= 1) {
      blurImageCounter = 0.1;
    }
    notifyListeners();
    return false;
  }
}
