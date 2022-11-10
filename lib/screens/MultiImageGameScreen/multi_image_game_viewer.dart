import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';
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
    FirebaseModel wordData = ref.read(multiImageGameProvider).currentWordData;
    return SizedBox(
      height: 60.h,
      child: GridView.builder(
        itemCount: wordData.results.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  wordData.results[index].urls.raw,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      if (!isTimerStarted) {
                        ref.read(blurImageGameProvider).startTimer();
                        isTimerStarted = true;
                      }
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
