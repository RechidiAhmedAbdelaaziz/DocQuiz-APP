import 'package:app/core/di/container.dart';
import 'package:app/feature/auth/data/repo/auth.repo.dart';
import 'package:app/feature/user/data/model/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup.state.dart';
part 'signup.cubit.freezed.dart';

class SignupCubit extends Cubit<SignupState> {
  final _authRepo = locator<AuthRepo>();

  SignupCubit() : super(const SignupState.initial());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    emit(const SignupState.loading());

    final result = await _authRepo.register(
        name: name, email: email, password: password);

    result.when(
      success: (data) => emit( SignupState.success(data.user!)),
      error: (error) => emit(SignupState.error(error.message)),
    );
  }
}
