import 'package:flutter/material.dart';
import 'package:taskkey/ui/home_page.dart';
import 'package:taskkey/ui/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light, //callmetode
      darkTheme: Themes.dark,
      themeMode: ThemeMode.dark,
      home: HomePage()
    );
  }
}
