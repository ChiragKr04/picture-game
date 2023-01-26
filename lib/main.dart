import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/constants/constant_utility.dart';
import 'package:picture_game/screens/LoginScreen/all_game_page.dart';
import 'package:picture_game/screens/LoginScreen/login_screen.dart';
import 'package:picture_game/screens/MultiImageGameScreen/multi_image_game_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return ResponsiveSizer(
      builder: (context, _, __) {
        return MaterialApp(
          routes: {
            "/multi": (context) => MultiImageGameScreen(),
            "/all": (context) => AllGamePage(),

          },
          debugShowCheckedModeBanner: false,
          title: 'Picture Game',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: ConstantUtility.sunnyFont,
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.pink),
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}
