import 'package:marvel_heroes/src/models/character.dart';
import 'package:marvel_heroes/src/services/api_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersBloc extends Cubit<List<Character>> {
  CharactersBloc() : super(List.empty());

  void updateCharacterList() async {
    final results = await ApiManager().getCharacters();
    if (results == null) return;
    emit(results.data.results);
  }
}
