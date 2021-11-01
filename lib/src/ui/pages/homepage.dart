import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_heroes/src/business_logic/blocs/characters_bloc.dart';
import 'package:marvel_heroes/src/models/character.dart';

import '../grid_fixed_height.dart';

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
        body: BlocBuilder<CharactersBloc, List<Character>>(
          builder: (context, snapshot) {
            if (snapshot.isEmpty) {
              context.read<CharactersBloc>().updateCharacterList();
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        height: 248, crossAxisCount: 2),
                itemCount: snapshot.length,
                itemBuilder: (context, index) {
                  if (index >= snapshot.length) {
                    // _suggestions.addAll(generateWordPairs().take(10));
                  }

                  var character = snapshot[index];
                  return _buildCharacterTile(character);
                });
          },
        ));
  }

  StatelessWidget _buildCharacterTile(Character character) {
    return Card(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.network(
                character.thumbnail.getImageUrl(),
                height: 160,
                fit: BoxFit.fitWidth,
              ),
              const CircleAvatar(
                backgroundColor: Colors.white,
                // radius: 100,
                child: Icon(
                  // alreadySaved ? Icons.favorite : Icons.favorite_border,
                  Icons.favorite,
                  color: Colors.red,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              character.name,
              overflow: TextOverflow.visible,
            ),
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
    );
  }
}
