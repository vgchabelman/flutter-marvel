part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CharactersFetched extends CharactersEvent {}