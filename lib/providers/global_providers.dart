import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/picture_data_provider.dart';

final pictureDataProvider = ChangeNotifierProvider<PictureDataProvider>((ref) {
  return PictureDataProvider();
});
