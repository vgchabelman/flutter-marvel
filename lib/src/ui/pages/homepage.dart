import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel_heroes/src/models/marvel.dart';
import 'package:marvel_heroes/src/models/character.dart';
import 'package:marvel_heroes/src/services/api_manager.dart';

import '../grid_fixed_height.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Marvel?> _marvel;

  @override
  void initState() {
    _marvel = ApiManager().getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel'),
      ),
      body: FutureBuilder<Marvel?>(
        future: _marvel,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  height: 240, crossAxisCount: 2),
              itemCount: snapshot.requireData!.data.count,
              itemBuilder: (context, index) {
                var character = snapshot.requireData!.data.results[index];
                return _buildCharacterTile(character);
              });
        },
      ),
    );
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
