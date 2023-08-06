import 'package:anywhere/core/startup/app_startup.dart';
import 'package:anywhere/screens/Home/models/character_list_model.dart';
import 'package:anywhere/screens/Home/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService service;

  HomeCubit(this.service) : super(HomeInitial());

  getCharacterList() async {
    emit(GetCharacterListLoading());
    try {
      Map? body = await service.getCharacterList();
      if (body == null) emit(GetCharacterListError("null error"));
      var response = CharacterList.fromJson(body!);
      print("here");

      if (serviceLocator.isRegistered<CharacterList>()) {
          serviceLocator.unregister<CharacterList>();
        }
        serviceLocator.registerSingleton<CharacterList>(response);

        emit(GetCharacterListSuccess(response));

    } catch (_) {
      print(_.toString());
      emit(GetCharacterListError(_.toString()));
    }
  }

}