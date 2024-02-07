import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pertemuan_2/data/model/user.dart';
import 'package:pertemuan_2/data/repository/auth_repository.dart';
import 'package:pertemuan_2/utils/db/storage_manager.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String tag = 'ProfileBloc::->';

  final AuthRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<GetProfile>(_onGetProfile);
  }

  void _onGetProfile(
      GetProfile event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      emit(ProfileLoading());
      User? user = await repository.getProfile();
      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileFailed(e.toString()));
    }
  }
}
