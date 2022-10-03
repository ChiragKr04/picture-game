import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/models/picture_model.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/constant_utility.dart';

class ImageGridView extends ConsumerWidget {
  const ImageGridView({
    Key? key,
    required this.pictureData,
  }) : super(key: key);

  final PictureModel pictureData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var picturePvdReader = ref.read(pictureDataProvider);
    var picturePvgWatcher = ref.watch(pictureDataProvider);
    void showSelectedLimitPopup() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: Text("Limit Reached"),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Center(
                  child: Text(
                    "You can only selected upto 4 pictures",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
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
    }

    return Expanded(
      child: SizedBox(
        width: 50.w,
        height: 80.h,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
          ),
          itemCount: pictureData.results.length,
          itemBuilder: (context, index) {
            bool isThisPresent = picturePvgWatcher.checkIfImagePresent(
              id: pictureData.results[index].id,
            );
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  if (!isThisPresent) {
                    picturePvdReader.addToSelectedPicture(idx: index);
                    return;
                  }
                  if (picturePvdReader.selectedPictures.length == 4) {
                    showSelectedLimitPopup();
                    return;
                  }
                  picturePvdReader.addToSelectedPicture(idx: index);
                },
                child: Material(
                  elevation: 10,
                  shadowColor: ConstantUtility.fromHexToColor(
                    hexCode: pictureData.results[index].color,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          pictureData.results[index].urls.raw,
                          height: 5.h,
                          width: 5.h,
                          fit: BoxFit.fill,
                        ),
                        !isThisPresent
                            ? const Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 50,
                                ),
                              )
                            : const Offstage(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
