import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickchat/firebase_options.dart';
import 'package:quickchat/screens/chat_screen.dart';
import 'package:quickchat/screens/home_screen.dart';
import 'package:quickchat/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Chat',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/chatScreen', page: () => const ChatScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
      ],
      home: const LoginScreen(),
    );
  }
}
