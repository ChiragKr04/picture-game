import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../providers/global_providers.dart';

class CustomSideDrawer extends ConsumerWidget {
  const CustomSideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenSwitcherPvdReader = ref.read(screenSwitcherProvider);
    var screenSwitcherPvdWatcher = ref.watch(screenSwitcherProvider);
    return Drawer(
      child: ListView.builder(
        itemCount: screenSwitcherPvdReader.pageNameList.length,
        itemBuilder: (context, index) {
          return ListTile(
            selected: screenSwitcherPvdWatcher.currentPageIdx == index,
            selectedTileColor: Colors.lightBlue.shade300,
            tileColor: Colors.lightBlue.shade50,
            textColor: Colors.black,
            selectedColor: Colors.black,
            onTap: () {
              screenSwitcherPvdReader.changeScreen(pageIdx: index);
              Navigator.pop(context);
            },
            title: Text(
              screenSwitcherPvdReader.pageNameList[index],
            ),
          );
        },
      ),
    );
  }
}
