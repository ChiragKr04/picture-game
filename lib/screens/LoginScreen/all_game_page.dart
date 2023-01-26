import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/constants/constant_colors.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:picture_game/screens/AdminScreen/admin_screen.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_image_screen.dart';
import 'package:picture_game/screens/FirebaseDBViewerScreen/firebase_db_viewer_screen.dart';
import 'package:picture_game/screens/MainPage/main_page.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_screen.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_viewer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../models/firebase_model.dart';

class AllGamePage extends ConsumerWidget {
  AllGamePage({super.key});

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection("word-db").snapshots();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var l1 = ["Add Words", "All Words"];
    var l2 = ["Multi-Image Game", "Blur-Image Game"];
    Widget getScaffold(Widget screen, String title) {
      return Scaffold(
        backgroundColor: ConstantColors.blueColor,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: screen,
      );
    }

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

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ref.watch(screenSwitcherProvider).isUserAdmin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < 2; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: InkWell(
                                onTap: () {
                                  if (i == 0) {
                                    // ref
                                    //     .read(screenSwitcherProvider)
                                    //     .changeScreen(pageIdx: 1);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              getScaffold(AdminScreen(), l1[i]),
                                        ));
                                  } else {
                                    // ref
                                    //     .read(screenSwitcherProvider)
                                    //     .changeScreen(pageIdx: 2);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => getScaffold(
                                                FirebaseDBViewerScreen(),
                                                l1[i])));
                                  }
                                },
                                child: Material(
                                  color: Colors.pink.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Center(
                                    child: Text(
                                      l1[i],
                                      style: const TextStyle(
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  : const Offstage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 2; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        height: 40.h,
                        width: 40.w,
                        child: InkWell(
                          onTap: () async {
                            if (i == 0) {
                              // ref
                              //     .read(screenSwitcherProvider)
                              //     .changeScreen(pageIdx: 3);
                              ref.watch(multiImageGameProvider).resetScore();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        getScaffold(
                                            MultiImageGameScreen(), l2[i]),
                                  ));
                            } else {
                              // ref
                              //     .read(screenSwitcherProvider)
                              //     .changeScreen(pageIdx: 4);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        getScaffold(BlurImageScreen(), l2[i]),
                                  ));
                            }
                          },
                          child: Material(
                            color: Colors.pink.shade400,
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: Text(
                                l2[i],
                                style: const TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
