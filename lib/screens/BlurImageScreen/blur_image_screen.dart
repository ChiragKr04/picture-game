import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_game_timer.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_image_game_word_selector.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_image_viewer.dart';
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
    ref.read(blurImageGameProvider).generateNewWordForGame(
          ref.read(pictureDataProvider).firebaseDataSnapShot,
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(blurImageGameProvider).generateNewWordForGame(
          ref.read(pictureDataProvider).firebaseDataSnapShot,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 60.h,
                child: const BlurImageViewer(),
              ),
              SizedBox(
                height: 40.h,
                child: BlurImageGameWordSelector(
                  callback: () {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          BlurTimerWidget(),
        ],
      ),
    );
  }
}
