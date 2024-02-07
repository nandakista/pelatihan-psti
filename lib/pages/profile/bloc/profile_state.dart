part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFailed extends ProfileState {
  final String message;

  const ProfileFailed(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileSuccess extends ProfileState {
  final User? user;
  const ProfileSuccess(this.user);
}
