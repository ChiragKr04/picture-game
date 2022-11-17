import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:picture_game/models/firebase_model.dart';
import 'package:picture_game/models/picture_model.dart';
import 'package:picture_game/services/firebase_service.dart';
import 'package:picture_game/services/picture_data_service.dart';

class PictureDataProvider extends ChangeNotifier {
  PictureModel pictureData = PictureModel.empty();
  PictureDataService pictureService = PictureDataServiceImpl();
  FirebaseService firebaseService = FlirebaseServiceImpl();
  bool isLoading = false;
  bool isSendingToFB = false;
  List<Result> selectedPictures = [];
  String currentWord = '';

  List<FirebaseModel> firebaseDataSnapShot = [];

  void getSearchedWordData({
    required String word,
  }) async {
    if (word.trim().length <= 2) {
      return;
    }
    currentWord = word;
    isLoading = true;
    notifyListeners();
    pictureData = await pictureService.searchPhoto(word);
    log(pictureData.toJson().toString());
    isLoading = false;
    notifyListeners();
  }

  bool checkIfImagePresent({required String id}) {
    return selectedPictures
            .firstWhere(
              (element) => element.id == id,
              orElse: () => Result.empty(),
            )
            .id ==
        "-1";
  }

  Future<bool> sendDataToFirebase() async {
    isSendingToFB = true;
    notifyListeners();
    var sendData = FirebaseModel(
      word: currentWord,
      results: selectedPictures,
    ).toJson();
    var response = await firebaseService.addWordData(data: sendData);
    log("firebaseService.addWordData $response");
    if (response) {
      selectedPictures = [];
      currentWord = '';
      pictureData = PictureModel.empty();
    } else {
      log("Some error occured while adding picture data");
    }
    isSendingToFB = false;
    notifyListeners();
    return response;
  }

  void fetchFirebasePictureData() async {
    var fetchedData = await firebaseService.fetchWordsData();
    log("firebase data $fetchedData");
  }

  void addToSelectedPicture({required int idx}) {
    bool isNotPresent = selectedPictures.firstWhere(
          (element) => element.id == pictureData.results[idx].id,
          orElse: () {
            return Result.empty();
          },
        ).id ==
        "-1";
    if (isNotPresent) {
      selectedPictures.add(
        pictureData.results[idx],
      );
    } else {
      selectedPictures.remove(
        pictureData.results[idx],
      );
    }
    log("length ${selectedPictures.length} ${selectedPictures.toString()}");
    notifyListeners();
  }

  void updateNewFirebaseDb(List<FirebaseModel> firebaseData) {
    firebaseDataSnapShot = firebaseData;
    // notifyListeners();
  }
}
