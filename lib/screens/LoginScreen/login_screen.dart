import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_game/constants/constant_colors.dart';
import 'package:picture_game/constants/constant_utility.dart';
import 'package:picture_game/providers/global_providers.dart';
import 'package:picture_game/screens/LoginScreen/all_game_page.dart';
import 'package:picture_game/screens/MainPage/main_page.dart';
import 'package:picture_game/widgets/custom_word_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ConstantColors.blueColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PICTURE GAME",
              style: TextStyle(
                fontSize: 100,
                color: Colors.pink,
                fontFamily: ConstantUtility.sunnyFont,
              ),
            ),
            SizedBox(
              width: size.width * 0.6,
              child: NiceButtons(
                borderColor: Colors.pink,
                onTap: (p0) {
                  ref.read(screenSwitcherProvider).changeAdmin(false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                  );
                },
                child: Text(
                  "Play",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.pink,
                    fontFamily: ConstantUtility.sunnyFont,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width * 0.6,
              child: NiceButtons(
                borderColor: Colors.pink,
                onTap: (p0) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          var emailct = TextEditingController();
                          var passct = TextEditingController();
                          return AlertDialog(
                            backgroundColor: ConstantColors.blueColor,
                            title: const Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: emailct,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.pink,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.pink,
                                      ),
                                    ),
                                    labelText: "Email",
                                    labelStyle: TextStyle(
                                      color: Colors.pink,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextField(
                                    controller: passct,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.pink,
                                        ),
                                      ),
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        color: Colors.pink,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.pink,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                        email: emailct.text.trim(),
                                        password: passct.text.trim(),
                                      )
                                          .then(
                                        (value) {
                                          if (value.user!.email != null) {
                                            ref
                                                .read(screenSwitcherProvider)
                                                .changeAdmin(true);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MainPage(),
                                              ),
                                            );
                                          }
                                          log("login cred ${value}");
                                          return value;
                                        },
                                      );
                                    },
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Colors.pink,
                                      ),
                                    ),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Colors.pink,
                                      ),
                                    ),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                child: Text(
                  "Admin Login",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.pink,
                    fontFamily: ConstantUtility.sunnyFont,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
