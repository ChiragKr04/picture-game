import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picture_game/models/firebase_model.dart';
import 'package:picture_game/services/firebase_service.dart';

class MultiImageGameProvider extends ChangeNotifier {
  FirebaseModel currentWordData = FirebaseModel.empty();

  MultiImageGameProvider() {
    FlirebaseServiceImpl().fetchWordsData();
  }

  void generateNewWordForGame(List<FirebaseModel> allData) {
    int randomIdx = Random().nextInt(allData.length);
    currentWordData = allData[randomIdx];
    // notifyListeners();
  }
}
