import 'package:flutter/material.dart';
import 'package:marvel_heroes/src/business_logic/blocs/characters_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/ui/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF100E2A),
        primaryColorLight: const Color(0xFF171538),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF100E2A),
          primaryVariant: Color(0xFF171538),
          secondary: Color (0xFFe4c94d),
          secondaryVariant: Color(0xFF545e66),
          onSurface: Colors.white,
          onSecondary: Colors.black
        ) ,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home:  const HomePage(),
    );
  }
}