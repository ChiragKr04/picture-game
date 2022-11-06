import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';

class BlurImageViewer extends ConsumerStatefulWidget {
  const BlurImageViewer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlurImageViewerState();
}

class _BlurImageViewerState extends ConsumerState<BlurImageViewer> {
  int getRandomIdx() {
    return Random().nextInt(4);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              ref
                  .read(multiImageGameProvider)
                  .currentWordData
                  .results[getRandomIdx()]
                  .urls
                  .raw,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
            ),
          ),
        ),
      ),
    );
  }
}
