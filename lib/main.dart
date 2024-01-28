import 'package:cleanuppp/responsive/mobile_screen_layout.dart';
import 'package:cleanuppp/responsive/responsive_layout_screen.dart';
import 'package:cleanuppp/responsive/web_screen_layout.dart';
import 'package:cleanuppp/screens/login_screen.dart';
import 'package:cleanuppp/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'util/colors.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDzngy487G5amatEhzvAShVdGCsxazuzuc",
          appId: "1:586008772070:android:4b3e8939edea54f1faea27",
          messagingSenderId: "58600877207",
          projectId: "cleanuppp-40250"));
  runApp(DevicePreview(
      builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cleaningess',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: SignupScreen(),
    );
  }
}
