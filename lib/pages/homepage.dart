import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel_heroes/models/marvel.dart';
import 'package:marvel_heroes/services/api_manager.dart';

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

          return ListView.builder(
              itemCount: snapshot.requireData!.data!.count,
              itemBuilder: (context, index) {
                var character = snapshot.requireData!.data!.results![index];

                return Container(
                  height: 100,
                  child: Text(character.name),
                  color: index % 2 == 0 ? Colors.red : Colors.blue,
                  margin: const EdgeInsets.all(10),
                );
              });
        },
      ),
    );
  }
}
