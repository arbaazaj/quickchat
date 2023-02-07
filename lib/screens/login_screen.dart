import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:quickchat/widgets/custom_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> checkUserState() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        } else {
          if (kDebugMode) {
            print('User is signed in!');
          }
        }
      }
    });
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      final loginUser = FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      loginUser.then((value) => Get.toNamed('/'));
    } else {
      Get.snackbar(
        'Login Error',
        'Please fill all the fields!',
        backgroundColor: Colors.red,
        colorText: Colors.amber,
      );
    }
  }

  Future<void> register() async {
    final email = emailController.text;
    final password = passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      final registerUser = FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      registerUser.then((value) {
        Get.snackbar(
          'Success',
          'Account created Successfully! 👍',
          backgroundColor: Colors.green,
          colorText: Colors.amber,
        );
      });
    } else {
      Get.snackbar(
        'Login Error',
        'Please fill all the fields!',
        backgroundColor: Colors.red,
        colorText: Colors.amber,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: Colors.deepPurple)),
            CustomTextField(
              controller: emailController,
              prefixIcon: Icons.email_outlined,
              hintText: 'E-mail',
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            CustomTextField(
              controller: passwordController,
              prefixIcon: Icons.password,
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(color: Colors.deepPurple, thickness: 1),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(10.0))),
                  onPressed: () {
                    login();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                  child: Transform.rotate(
                    angle: math.pi / 2,
                    child: const Divider(
                      color: Colors.deepPurple,
                      thickness: 2.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(10.0))),
                  onPressed: () {
                    register();
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
