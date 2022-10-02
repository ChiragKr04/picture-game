import 'package:picture_game/constants/api_keys.dart';

class ApiConstants {
  static const String basePictureUrl = "https://api.unsplash.com/";
  static const String searchPictureUrl = "search/photos";

  /// Paste your access key from https://unsplash.com/oauth/applications
  static const String pictureAccessKey =
      "Client-ID ${ApiKeys.pictureApiAccessKey}";
}
