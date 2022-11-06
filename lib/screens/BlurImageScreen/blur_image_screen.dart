import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_image_game_word_selector.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_image_viewer.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_word_selector.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../providers/global_providers.dart';

class BlurImageScreen extends ConsumerStatefulWidget {
  const BlurImageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlurImageScreenState();
}

class _BlurImageScreenState extends ConsumerState<BlurImageScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(multiImageGameProvider).generateNewWordForGame(
          ref.read(pictureDataProvider).firebaseDataSnapShot,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
            child: BlurImageViewer(),
          ),
          SizedBox(
            height: 40.h,
            child: BlurImageGameWordSelector(),
          ),
        ],
      ),
    );
  }
}
