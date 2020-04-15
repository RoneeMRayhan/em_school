import 'package:flutter/material.dart';
import 'package:em_school/screens/home.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
      primaryColor: Colors.purple,
    ),
  ));
}
