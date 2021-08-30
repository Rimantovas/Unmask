import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unmaskapp/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xff5A189A),
            canvasColor: const Color(0xff10002B),
            colorScheme: ColorScheme.fromSwatch().copyWith(
                brightness: Brightness.dark,
                secondary: const Color(0xffC77DFF)),
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(color: Colors.white),
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(
                  color: Color(0xffC77DFF),
                ))),
        home: const HomeScreen());
  }
}
