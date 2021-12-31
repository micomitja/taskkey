import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskkey/services/theme_services.dart';
import 'package:taskkey/ui/home_page.dart';
import 'package:taskkey/ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
      themeMode: ThemeServices().theme,
      home: HomePage()
    );
  }
}
