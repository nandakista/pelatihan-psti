import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pertemuan_2/data/repository/auth_repository_impl.dart';
import 'package:pertemuan_2/pages/benefit/benefit_list_page.dart';
import 'package:pertemuan_2/pages/login/bloc/login_bloc.dart';
import 'package:pertemuan_2/utils/db/secure_storage_manager.dart';

class LoginPage extends StatefulWidget {
  static const String route = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(AuthRepositoryImpl()),
      child: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(hintText: 'phone'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(hintText: 'password'),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                SubmitLogin(
                                  phoneController.text,
                                  passwordController.text,
                                ),
                              );
                          // Navigator.pushNamed(context, BenefitListPage.route);
                        },
                        child: const Text('Login'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, BenefitListPage.route);
          } else if (state is LoginLoading) {
            log('loading');
          } else {
            log('Error login');
          }
        },
      ),
    );
  }
}
