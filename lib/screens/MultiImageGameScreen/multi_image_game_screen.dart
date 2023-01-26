import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_game_timer.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_viewer.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_word_selector.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../models/firebase_model.dart';
import '../../widgets/custom_word_button.dart';

class MultiImageGameScreen extends ConsumerStatefulWidget {
  const MultiImageGameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiImageGameScreenState();
}

class _MultiImageGameScreenState extends ConsumerState<MultiImageGameScreen> {
  @override
  Widget build(BuildContext context) {
    log("BUILD AGAIN");
    ref.read(multiImageGameProvider).generateNewWordForGame(
          ref.read(pictureDataProvider).firebaseDataSnapShot,
        );
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "SCORE: ${ref.watch(multiImageGameProvider).score}",
            style: const TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          BlurTimerWidget(),
          MultiGameImageViewer(),
        ],
      ),
    );
  }
}
