// import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pertemuan_2/data/repository/auth_repository.dart';
import 'package:pertemuan_2/utils/db/secure_storage_manager.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String tag = 'LoginBloc::->';

  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<SubmitLogin>(_onSubmit);
  }

  void _onSubmit(
    SubmitLogin event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      final login = await repository.login(
        phoneNumber: event.phone,
        password: event.password,
      );

      SecureStorageManager().setToken(value: login.token);

      emit(const LoginSuccess());

      // log('phone ${event.phone}');
      // log('password ${event.password}');

      // if (event.phone == '08' && event.password == 'password') {
      //   emit(const LoginSuccess());
      // } else {
      //   emit(LoginFailed('login failed'));
      // }
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
