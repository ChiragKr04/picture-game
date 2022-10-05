import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/providers/global_providers.dart';

import '../../widgets/custom_side_drawer.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenSwitcherPvdReader = ref.read(screenSwitcherProvider);
    var screenSwitcherPvdWatcher = ref.watch(screenSwitcherProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(screenSwitcherPvdWatcher.pageName),
      ),
      drawer: const CustomSideDrawer(),
      body: screenSwitcherPvdWatcher.currentScreen,
    );
  }
}
