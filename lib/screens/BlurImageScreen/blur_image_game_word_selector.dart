import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../providers/global_providers.dart';

import 'dart:developer';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/custom_word_button.dart';

class BlurImageGameWordSelector extends ConsumerStatefulWidget {
  const BlurImageGameWordSelector({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiImageGameWordSelectorState();
}

class _MultiImageGameWordSelectorState
    extends ConsumerState<BlurImageGameWordSelector> {
  TextEditingController wordController = TextEditingController();
  List<String> currentWord = [];
  @override
  void initState() {
    super.initState();
    currentWord = ref.read(multiImageGameProvider).currentWordList;
  }

  void wordListener() {
    wordController.addListener(() {
      if (wordController.text.length != currentWord.length) {
        return;
      }
      bool isSpellCorrect = ref
          .read(multiImageGameProvider)
          .checkIfSpellingCorrect(wordController.text);
      log("${wordController.text} $isSpellCorrect");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              isSpellCorrect ? "Correct Answer" : "Wrong Answer",
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
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
    });
  }

  void backspaceButtonFn() {
    if (wordController.text.isNotEmpty) {
      var newText = wordController.text.split("");
      newText.removeLast();
      wordController.text = newText.join("");
    }
  }

  @override
  Widget build(BuildContext context) {
    wordListener();
    return Column(
      children: [
        SizedBox(
          width: 60.w,
          child: PinCodeTextField(
            controller: wordController,
            appContext: context,
            length: currentWord.length,
            pinTheme: PinTheme.defaults(),
            enabled: false,
            onChanged: (value) {},
            onCompleted: (value) {},
          ),
        ),
        SizedBox(
          width: 60.w,
          child: NiceButtons(
            child: const Icon(Icons.backspace_rounded),
            onTap: (p0) {
              backspaceButtonFn();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int idx = 0; idx < currentWord.length; idx++)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 50,
                  child: NiceButtons(
                    progress: false,
                    borderThickness: 8,
                    onTap: (_) {
                      wordController.text += currentWord[idx];
                    },
                    child: Text(
                      currentWord[idx],
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
