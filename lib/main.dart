import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'mainView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: mainView(title: 'DCSZ Visitor App'),
    );
  }
}

