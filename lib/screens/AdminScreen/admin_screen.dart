import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';

import '../../widgets/image_grid_view.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var picturePvdReader = ref.read(pictureDataProvider);
    var picturePvgWatcher = ref.watch(pictureDataProvider);
    var pictureData = picturePvgWatcher.pictureData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Screen"),
        centerTitle: true,
      ),
      floatingActionButton:
          ref.watch(pictureDataProvider).selectedPictures.length == 4
              ? FloatingActionButton.extended(
                  onPressed: () {
                    /// TODO: Send selected picture data to firebase
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Send to Firebase",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.send,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Enter a word (name, place, animal or thing)",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              picturePvdReader.getSearchedWordData(
                word: controller.text.trim(),
              );
            },
            child: const Text("Get Images"),
          ),
          picturePvgWatcher.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : pictureData.results.isEmpty
                  ? const Offstage()
                  : ImageGridView(
                      pictureData: pictureData,
                    ),
        ],
      ),
    );
  }
}
