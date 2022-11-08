import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/constants/constant_utility.dart';
import 'package:picture_game/models/firebase_model.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FirebaseDBViewerScreen extends ConsumerStatefulWidget {
  const FirebaseDBViewerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FirebaseDBViewerScreenState();
}

class _FirebaseDBViewerScreenState
    extends ConsumerState<FirebaseDBViewerScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection("word-db").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        List<FirebaseModel> firebaseData = snapshot.data!.docs.map(
          (eachElement) {
            return FirebaseModel.fromJson(
              eachElement.data() as Map<String, dynamic>,
            );
          },
        ).toList();

        ref.read(pictureDataProvider).updateNewFirebaseDb(firebaseData);

        return ImageListViewBuilder(
          firebaseDBData: firebaseData,
        );
      },
    );
  }
}

class ImageListViewBuilder extends ConsumerStatefulWidget {
  const ImageListViewBuilder({
    Key? key,
    required this.firebaseDBData,
  }) : super(key: key);

  final List<FirebaseModel> firebaseDBData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ImageListViewBuilderState();
}

class ImageListViewBuilderState extends ConsumerState<ImageListViewBuilder> {
  List<bool> showPics = [];
  String buttonText = "View Image";

  String changeButtonText(bool value) {
    return value ? "Hide Image" : "View Image";
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.firebaseDBData.length; i++) {
      showPics.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var firebaseData = widget.firebaseDBData;
    return ListView.builder(
      itemCount: firebaseData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            color: ConstantUtility.fromHexToColor(
              hexCode: firebaseData[index].results.first.color,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(firebaseData[index].word.toUpperCase()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showPics[index] = !showPics[index];
                          });
                        },
                        child: Text(
                          changeButtonText(showPics[index]),
                        ),
                      ),
                      !showPics[index]
                          ? const Offstage()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (int i = 0;
                                    i < firebaseData[index].results.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: firebaseData[index]
                                            .results[i]
                                            .urls
                                            .raw,
                                        height: 10.h,
                                        width: 10.w,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.warning_rounded),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
