import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/multi_image_game_provider.dart';
import 'package:picture_game/providers/picture_data_provider.dart';
import 'package:picture_game/providers/screem_switcher.dart';

final pictureDataProvider = ChangeNotifierProvider<PictureDataProvider>((ref) {
  return PictureDataProvider();
});

final screenSwitcherProvider = ChangeNotifierProvider<ScreeenSwitcher>((ref) {
  return ScreeenSwitcher();
});

final multiImageGameProvider =
    ChangeNotifierProvider<MultiImageGameProvider>((ref) {
  return MultiImageGameProvider();
});
