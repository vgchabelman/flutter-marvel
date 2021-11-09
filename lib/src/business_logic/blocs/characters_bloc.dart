import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_heroes/src/services/api_manager.dart';
import 'package:marvel_heroes/src/models/character.dart';

part 'characters_event.dart';

part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(const CharactersState()) {
    on<CharactersFetched>(_onCharactersFetched);
  }

  Future<void> _onCharactersFetched(
      CharactersFetched event, Emitter<CharactersState> emit) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == CharactersStatus.initial) {
        final marvel = await ApiManager().getCharacters();
        return emit(state.copyWith(
          status: CharactersStatus.success,
          characters: marvel!.data.results,
          hasReachedMax: false,
        ));
      }

      final marvel =
          await ApiManager().getCharacters(offset: state.characters.length);

      if (marvel!.data.total == state.characters.length) {
        emit(state.copyWith(hasReachedMax: true));
      }

      final characters = marvel.data.results;
      emit(state.copyWith(
        status: CharactersStatus.success,
        characters: List.of(state.characters)..addAll(characters),
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: CharactersStatus.failure));
    }
  }

// void updateCharacterList() async {
//   final results = await ApiManager().getCharacters();
//   if (results == null) return;
//   emit(results.data.results);
// }
}
