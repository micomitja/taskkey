import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart'; // za lokalno shranjevalne info na fonu
import 'package:get/get.dart';

class ThemeService {
  final _box = GetStorage(); // boolean status
  final _key = 'isDarkMode'; //kluč, ko id v jsonu recimo

  /// Get isDarkMode info iz local storage pol pa returna ThemeMode tak ko je ostal shranjen v aplikaciji
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  ///Funkcija _loadThemeFromBox nalož isDArkMode iz local storage pol pa če je empty, returns false (to pomen da je default thema light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false; // če je katera koli vrednost return that as tru čene pa false

  /// Saveaa isDarkMode v local storageee
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme pa save to local storage, funkcija za switchat themo
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark); //kličemo funkcijo če da tru daš light čene pa false
    _saveThemeToBox(!_loadThemeFromBox()); //pa saveš negirano v _box
  }
}
