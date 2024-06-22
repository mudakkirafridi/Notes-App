import 'package:flutter/material.dart';
import 'package:notes_app/constants/provider.dart';
import 'package:notes_app/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      
      create: ( context) => MyProvider(),
      child: Builder(builder: (BuildContext context){
         final themeChanger =  Provider.of<MyProvider>(context);
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: themeChanger.themeMode, 
        home: const HomeScreen(),
      );
      })
    );
  }
}

