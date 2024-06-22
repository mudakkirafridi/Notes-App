import 'package:flutter/material.dart';
import 'package:notes_app/constants/theme.dart';
import 'package:notes_app/db_helper/db_helper.dart';

class MyProvider with ChangeNotifier{
  DatabaseHelper databaseHelper = DatabaseHelper();
  var _themeMode = darkTheme;
  ThemeData get themeMode  => _themeMode;

  setTheme(ThemeData themeData){
    _themeMode = themeData;
    notifyListeners();
  }

  
}