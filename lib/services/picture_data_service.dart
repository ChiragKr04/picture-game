import 'package:picture_game/constants/api_constants.dart';
import 'package:picture_game/models/picture_model.dart';
import 'package:http/http.dart' as http;

abstract class PictureDataService {
  Future<PictureModel> searchPhoto(String searchedWord);
}

class PictureDataServiceImpl extends PictureDataService {
  @override
  Future<PictureModel> searchPhoto(String searchedWord) async {
    String url =
        "${ApiConstants.basePictureUrl}${ApiConstants.searchPictureUrl}?page=1&query=$searchedWord";
    Map<String, String> headers = {
      "Authorization": ApiConstants.pictureAccessKey,
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    return pictureModelFromJson(
      response.body,
    );
  }
}
