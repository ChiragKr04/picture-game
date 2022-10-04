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

  final successSnackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: const Text("Data added to Firebase"),
    backgroundColor: Colors.green,
    action: SnackBarAction(
      textColor: Colors.black,
      label: "Ok",
      onPressed: () {},
    ),
  );

  final failureSnackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: const Text("Error adding data to Firebase"),
    backgroundColor: Colors.red,
    action: SnackBarAction(
      textColor: Colors.black,
      label: "Retry",
      onPressed: () {},
    ),
  );

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
                  onPressed: () async {
                    await picturePvdReader.sendDataToFirebase().then(
                      (value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            successSnackBar,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            failureSnackBar,
                          );
                        }
                        return value;
                      },
                    );
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
          ElevatedButton(
            onPressed: () {
              picturePvdReader.fetchFirebasePictureData();
            },
            child: const Text("Fetch Data"),
          ),
          picturePvgWatcher.isLoading || picturePvgWatcher.isSendingToFB
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
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
