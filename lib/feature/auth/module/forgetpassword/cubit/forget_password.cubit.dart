import 'package:app/core/di/container.dart';
import 'package:app/feature/auth/data/repo/auth.repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password.state.dart';
part 'forget_password.cubit.freezed.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final _authRepo = locator<AuthRepo>();

  ForgetPasswordCubit() : super(const ForgetPasswordState.initial());

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String get email => emailController.text;

  Future<void> forgetPassword() async {
    if (formKey.currentState!.validate()) {
      emit(const ForgetPasswordState.loading());

      final email = emailController.text;

      final result = await _authRepo.forgotPassword(email: email);

      result.when(
        success: (message) =>
            emit(ForgetPasswordState.success(message)),
        error: (error) =>
            emit(ForgetPasswordState.error(error.message)),
      );
    }
  }
}
