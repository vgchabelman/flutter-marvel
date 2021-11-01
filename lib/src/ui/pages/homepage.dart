import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_heroes/src/business_logic/blocs/characters_bloc.dart';
import 'package:marvel_heroes/src/ui/characters_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Marvel'),
        ),
        body: BlocProvider(
          create: (_) => CharactersBloc()..add(CharactersFetched()),
          child: const CharactersList(),
        ));
  }
}
