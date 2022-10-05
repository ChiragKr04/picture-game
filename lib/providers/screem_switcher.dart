import 'package:flutter/widgets.dart';
import 'package:picture_game/screens/AdminScreen/admin_screen.dart';
import 'package:picture_game/screens/FirebaseDBViewerScreen/firebase_db_viewer_screen.dart';

class ScreeenSwitcher extends ChangeNotifier {
  late List<String> pageNameList;
  late String pageName;
  int currentPageIdx = 0;
  Widget currentScreen = const FirebaseDBViewerScreen();
  ScreeenSwitcher() {
    pageNameList = ["All Words", "Admin Screen"];
    pageName = pageNameList[currentPageIdx];
  }

  void changeScreen({required int pageIdx}) {
    if (currentPageIdx == pageIdx) {
      return;
    }
    if (pageIdx == 0) {
      currentScreen = const FirebaseDBViewerScreen();
    } else if (pageIdx == 1) {
      currentScreen = const AdminScreen();
    }
    currentPageIdx = pageIdx;
    pageName = pageNameList[currentPageIdx];
    notifyListeners();
  }
}
