import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/constants/constant_utility.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, _, __) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Picture Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      );
    });
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pictureData = ref.watch(pictureDataProvider).pictureData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Picture Game"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("Picture Game"),
          ElevatedButton(
            child: const Text("Call"),
            onPressed: () {
              ref.read(pictureDataProvider).getSearchedWordData(
                    word: "dog",
                  );
            },
          ),
          pictureData.results.isEmpty
              ? const Offstage()
              : Expanded(
                  child: SizedBox(
                    width: 50.w,
                    height: 80.h,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Material(
                            elevation: 10,
                            shadowColor: ConstantUtility.fromHexToColor(
                              hexCode: pictureData.results[index].color,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                pictureData.results[index].urls.raw,
                                height: 5.h,
                                width: 5.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
