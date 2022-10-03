import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/screens/AdminScreen/admin_screen.dart';
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
    return ResponsiveSizer(
      builder: (context, _, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Picture Game',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const AdminScreen(),
        );
      },
    );
  }
}
