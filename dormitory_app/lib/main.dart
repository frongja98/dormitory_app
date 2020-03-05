import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'home.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _route = <String, WidgetBuilder>{
    '/login': (context) => Login(),
    '/home': (context) => Home(),
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dormitory",
      home: Login(),
      routes: _route,
    );
  }
}
