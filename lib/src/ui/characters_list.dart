import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_heroes/src/business_logic/blocs/characters_bloc.dart';
import 'package:marvel_heroes/src/models/character.dart';
import 'package:marvel_heroes/src/ui/bottom_loader.dart';

import 'grid_fixed_height.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({Key? key}) : super(key: key);

  @override
  _CharactersListState createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        switch (state.status) {
          case CharactersStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case CharactersStatus.failure:
            return const Center(child: Text('failed to fetch characters'));
          case CharactersStatus.success:
            return GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        height: 248,
                        crossAxisCount: 2
                    ),
                itemCount: _getItemCount(state),
                itemBuilder: (context, index) {
                  if (index >= state.characters.length) {
                    context.read<CharactersBloc>().add(CharactersFetched());
                    return const BottomLoader();
                  }
                  var character = state.characters[index];
                  return _buildCharacterTile(character);
                });
        }
      },
    );
  }
}

int _getItemCount(CharactersState state) {
  return state.hasReachedMax ? state.characters.length : state.characters.length + 1;
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
