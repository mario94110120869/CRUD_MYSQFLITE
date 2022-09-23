

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        "home": (BuildContext context) => HomePage(),
        // "lista": (BuildContext context) => ListaImagenes(),
      },
    );
  }
}
