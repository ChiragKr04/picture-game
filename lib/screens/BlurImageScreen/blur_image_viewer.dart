import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BlurImageViewer extends ConsumerStatefulWidget {
  const BlurImageViewer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlurImageViewerState();
}

class _BlurImageViewerState extends ConsumerState<BlurImageViewer> {
  bool isTimerStarted = false;
  @override
  Widget build(BuildContext context) {
    var blurImgPvdWatcher = ref.watch(blurImageGameProvider);
    var blurImgPvdReader = ref.read(blurImageGameProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60.h,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 60.h,
              child: Image.network(
                ref
                    .read(blurImageGameProvider)
                    .currentWordData
                    .results
                    .first
                    .urls
                    .raw,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    if (!isTimerStarted) {
                      blurImgPvdReader.startTimer();
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
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurImgPvdWatcher.blurImageCounter,
                sigmaY: blurImgPvdWatcher.blurImageCounter,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
