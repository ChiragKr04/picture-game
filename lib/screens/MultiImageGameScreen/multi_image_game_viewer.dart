import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_word_selector.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../models/firebase_model.dart';

class MultiGameImageViewer extends ConsumerStatefulWidget {
  const MultiGameImageViewer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiGameImageViewerState();
}

class _MultiGameImageViewerState extends ConsumerState<MultiGameImageViewer> {
  bool isTimerStarted = false;
  @override
  Widget build(BuildContext context) {
    FirebaseModel wordData = ref.watch(multiImageGameProvider).currentWordData;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int index = 0; index < 2; index++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      wordData.results[index].urls.raw,
                      fit: BoxFit.cover,
                      height: 30.h,
                      width: 40.w,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          if (!isTimerStarted) {
                            ref.read(blurImageGameProvider).startTimer();
                            isTimerStarted = true;
                          }
                          return child;
                        }
                        return SizedBox(
                          height: 30.h,
                          width: 40.w,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int index = 2; index < 4; index++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      wordData.results[index].urls.raw,
                      fit: BoxFit.cover,
                      height: 30.h,
                      width: 40.w,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          if (!isTimerStarted) {
                            ref.read(blurImageGameProvider).startTimer();
                            isTimerStarted = true;
                          }
                          return child;
                        }
                        return SizedBox(
                          height: 30.h,
                          width: 40.w,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
          ],
        ),
        MultiImageGameWordSelector(
          callback: () {
            log("HELLOOOOO");
            ref.read(multiImageGameProvider).increaseScore(
                  ref.read(pictureDataProvider).firebaseDataSnapShot,
                );
            setState(() {});
            // Navigator.popAndPushNamed(context, "/multi");
            // Navigator.pop(context, "hello");
          },
        ),
      ],
    );
  }
}
