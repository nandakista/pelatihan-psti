import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pertemuan_2/data/repository/auth_repository_impl.dart';

import 'bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  static const String route = '/profile';

  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(AuthRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: ProfileBloc(AuthRepositoryImpl())..add(GetProfile()),
          builder: (context, state) {
            if (state is ProfileSuccess) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'nama : ${state.user?.fullName}',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'email : ${state.user?.email}',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'no.telp : ${state.user?.phoneNumber}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileFailed) {
              return Center(child: Text('Error : ${state.message}'));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
