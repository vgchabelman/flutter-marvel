part of 'characters_bloc.dart';

enum CharactersStatus { initial, success, failure }

class CharactersState extends Equatable {
  const CharactersState({
    this.status = CharactersStatus.initial,
    this.characters = const <Character>[],
    this.hasReachedMax = false,
  });

  final CharactersStatus status;
  final List<Character> characters;
  final bool hasReachedMax;

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
    bool? hasReachedMax,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }


  @override
  List<Object?> get props => [status, characters, hasReachedMax];
}