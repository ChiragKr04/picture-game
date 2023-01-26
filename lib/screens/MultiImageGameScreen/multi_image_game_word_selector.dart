import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/custom_word_button.dart';

class MultiImageGameWordSelector extends ConsumerStatefulWidget {
  const MultiImageGameWordSelector({super.key, required this.callback});
  final Function callback;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiImageGameWordSelectorState();
}

class _MultiImageGameWordSelectorState
    extends ConsumerState<MultiImageGameWordSelector> {
  // TextEditingController wordController = TextEditingController();
  List<String> currentWord = [];
  List<String> gameWord = [];
  @override
  void initState() {
    super.initState();
    currentWord = ref.read(multiImageGameProvider).currentWordList;
  }

  void wordListener() {
    // if (wordController.text.length != currentWord.length) {
    //   return;
    // }
    bool isSpellCorrect = ref
        .read(multiImageGameProvider)
        .checkIfSpellingCorrect(gameWord.join(""));
    log("${gameWord.toString()} $isSpellCorrect");
    if (gameWord.length ==
        ref.read(multiImageGameProvider).currentWordList.length) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              isSpellCorrect ? "Correct Answer" : "Wrong Answer",
            ),
            actions: [
              ElevatedButton(
                onPressed: isSpellCorrect
                    ? () {
                        widget.callback();
                        // currentWord =
                        //     ref.read(multiImageGameProvider).currentWordList;
                        gameWord = [];
                        Navigator.pop(context);
                      }
                    : () {
                        Navigator.pop(context);
                      },
                child: const Text(
                  "Ok",
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void backspaceButtonFn() {
    gameWord.removeLast();
    // if (wordController.text.isNotEmpty) {
    //   var newText = wordController.text.split("");
    //   newText.removeLast();
    //   wordController.text = newText.join("");
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 7.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < gameWord.length; i++)
                Text(
                  gameWord[i].toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.pink,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 60.w,
          child: NiceButtons(
            startColor: Colors.pink.shade300,
            endColor: Colors.pink.shade300,
            child: const Icon(Icons.backspace_rounded),
            onTap: (p0) {
              backspaceButtonFn();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int idx = 0;
                idx < ref.read(multiImageGameProvider).currentWordList.length;
                idx++)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 50,
                  child: NiceButtons(
                    startColor: Colors.pink.shade300,
                    endColor: Colors.pink.shade300,
                    progress: false,
                    borderThickness: 8,
                    onTap: (_) {
                      gameWord.add(ref
                          .read(multiImageGameProvider)
                          .currentWordList[idx]);
                      // wordController.text +=
                      //     ref.read(multiImageGameProvider).currentWordList[idx];
                      wordListener();
                      setState(() {});
                    },
                    child: Text(
                      ref.watch(multiImageGameProvider).currentWordList[idx],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
