import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskkey/db/db_helper.dart';
import 'package:taskkey/services/theme_services.dart';
import 'package:taskkey/ui/pages/home_page.dart';
import 'package:taskkey/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // poskbrel bo da se prvo izvede ta getstorage init pol šele runnaš app
  await DBHelper.initDb();
  await GetStorage.init(); // get storage rabi ta async oz ta await za inicializacijo
runApp(MyApp());
}
///Main Dart kjer se nastavjo zadeve torej thema pa theme mode potem pa še določi Home page
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, /// stran damo tist debug tag da ga ni več gor
      theme: Themes.light, /// nastaviš ka je light thema
      darkTheme: Themes.dark, /// pa ka je dark thema za svitcnaje
      themeMode: ThemeService().theme, /// kličeš gor theme services da spremeni temo
      home: HomePage(),
    );
  }
}
