import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/global_providers.dart';

class BlurTimerWidget extends ConsumerWidget {
  const BlurTimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String timeLeft = ref.watch(blurImageGameProvider).timeLeft.toString();
    String timeLeftToShow =
        (ref.watch(blurImageGameProvider).timeLeft ~/ 100).toString();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: int.parse(timeLeft) * 0.00049,
            backgroundColor: Colors.transparent,
            color: Colors.red,
          ),
          Text(
            int.parse(timeLeftToShow) < 0 ? "0" : timeLeftToShow,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
