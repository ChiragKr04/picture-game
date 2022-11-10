import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_game_timer.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_viewer.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_word_selector.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MultiImageGameScreen extends ConsumerStatefulWidget {
  const MultiImageGameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiImageGameScreenState();
}

class _MultiImageGameScreenState extends ConsumerState<MultiImageGameScreen> {
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
          BlurTimerWidget(),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            child: const MultiGameImageViewer(),
          ),
          SizedBox(
            height: 40.h,
            child: const MultiImageGameWordSelector(),
          ),
        ],
      ),
    );
  }
}
