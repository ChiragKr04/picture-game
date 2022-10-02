import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:picture_game/models/picture_model.dart';
import 'package:picture_game/services/picture_data_service.dart';

class PictureDataProvider extends ChangeNotifier {
  PictureModel pictureData = PictureModel.empty();
  PictureDataService pictureService = PictureDataServiceImpl();

  void getSearchedWordData({
    required String word,
  }) async {
    pictureData = await pictureService.searchPhoto(word);
    log(pictureData.toJson().toString());
    notifyListeners();
  }
}
