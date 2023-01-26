import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/constants/constant_colors.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:picture_game/screens/LoginScreen/all_game_page.dart';
import 'package:picture_game/screens/LoginScreen/login_screen.dart';

import '../../widgets/custom_side_drawer.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var screenSwitcherPvdReader = ref.read(screenSwitcherProvider);
    var screenSwitcherPvdWatcher = ref.watch(screenSwitcherProvider);
    return Scaffold(
      backgroundColor: ConstantColors.blueColor,
      appBar: AppBar(
        centerTitle: true,
        leading: const Offstage(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Text(
          screenSwitcherPvdWatcher.pageName,
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.pink,
      ),
      // drawer: const CustomSideDrawer(),
      body: screenSwitcherPvdWatcher.currentScreen,
      // body: AllGamePage(),
    );
  }
}
