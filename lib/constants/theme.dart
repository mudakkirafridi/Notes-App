import 'package:flutter/material.dart';

  ThemeData lightTheme = ThemeData(
    
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
       titleTextStyle:const TextStyle(
        color: Colors.white
      ),
      backgroundColor: Colors.purple.shade300,
      actionsIconTheme: const IconThemeData(
        color: Colors.black45
      )
    ),
     textTheme:const TextTheme(
      titleSmall: TextStyle(
        color: Colors.black,fontSize: 18
      ),
   
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple.shade300,

    )
  );
  //===============================================================


  ThemeData darkTheme = ThemeData(
     scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      titleTextStyle:const TextStyle(
        color: Colors.white
      ),
      backgroundColor: Colors.purple.shade300,
      actionsIconTheme: const IconThemeData(
        color: Colors.white
      )
    ),
    textTheme:const TextTheme(
      titleSmall: TextStyle(
        color: Colors.grey,fontSize: 18
      )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple.shade300,
      
    )
  );
