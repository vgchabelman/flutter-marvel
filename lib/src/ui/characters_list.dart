import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_heroes/src/business_logic/blocs/characters_bloc.dart';
import 'package:marvel_heroes/src/models/character.dart';

import 'grid_fixed_height.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({Key? key}) : super(key: key);

  @override
  _CharactersListState createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

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
                        height: 248, crossAxisCount: 2),
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  var character = state.characters[index];
                  return _buildCharacterTile(character);
                });
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CharactersBloc>().add(CharactersFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

StatelessWidget _buildCharacterTile(Character character) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
