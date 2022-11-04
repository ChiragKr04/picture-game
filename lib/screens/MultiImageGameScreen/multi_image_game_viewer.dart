import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../models/firebase_model.dart';

class MultiGameImageViewer extends ConsumerWidget {
  const MultiGameImageViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
