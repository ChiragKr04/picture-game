import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:picture_game/models/picture_model.dart';
import 'package:picture_game/services/picture_data_service.dart';

class PictureDataProvider extends ChangeNotifier {
  PictureModel pictureData = PictureModel.empty();
  PictureDataService pictureService = PictureDataServiceImpl();
  bool isLoading = false;
  List<Result> selectedPictures = [];

  void getSearchedWordData({
    required String word,
  }) async {
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
}
