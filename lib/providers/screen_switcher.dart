import 'package:flutter/widgets.dart';
import 'package:picture_game/screens/AdminScreen/admin_screen.dart';
import 'package:picture_game/screens/BlurImageScreen/blur_image_screen.dart';
import 'package:picture_game/screens/FirebaseDBViewerScreen/firebase_db_viewer_screen.dart';
import 'package:picture_game/screens/LoginScreen/all_game_page.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_screen.dart';

class ScreeenSwitcher extends ChangeNotifier {
  late List<String> pageNameList;
  late String pageName;
  int currentPageIdx = 0;
  bool isUserAdmin = true;
  Widget currentScreen = AllGamePage();
  ScreeenSwitcher() {
    pageNameList = [
      "Picture Game",
      "All Words",
      "Admin Screen",
      "Multi Image Game",
      "Blur Image Game",
    ];
    pageName = pageNameList[currentPageIdx];
  }

  void changeAdmin(bool value) {
    isUserAdmin = value;
    notifyListeners();
  }

  void changeScreen({required int pageIdx}) {
    if (currentPageIdx == pageIdx) {
      return;
    }
    if (pageIdx == 0) {
      currentScreen = AllGamePage();
    } else if (pageIdx == 1) {
      currentScreen = const FirebaseDBViewerScreen();
    } else if (pageIdx == 2) {
      currentScreen = const AdminScreen();
    } else if (pageIdx == 3) {
      currentScreen = const MultiImageGameScreen();
    } else if (pageIdx == 4) {
      currentScreen = const BlurImageScreen();
    }
    currentPageIdx = pageIdx;
    pageName = pageNameList[currentPageIdx];
    notifyListeners();
  }
}
