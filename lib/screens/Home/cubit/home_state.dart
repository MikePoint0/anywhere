part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetCharacterListLoading extends HomeState {}

class GetCharacterListSuccess extends HomeState {
  final CharacterList characterList;

  GetCharacterListSuccess(this.characterList);
}

class GetCharacterListError extends HomeState {
  final String message;
  GetCharacterListError(this.message);
}
