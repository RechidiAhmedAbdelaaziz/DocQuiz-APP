import 'package:app/core/di/container.dart';
import 'package:app/feature/auth/data/repo/auth.repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password.state.dart';
part 'reset_password.cubit.freezed.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final _authRepo = locator<AuthRepo>();

  final String _email;
  final String _otp;

  ResetPasswordCubit(this._email, this._otp)
      : super(const ResetPasswordState.initial());

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      emit(const ResetPasswordState.loading());

      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      if (password != confirmPassword) {
        emit(const ResetPasswordState.error(
            'Password does not match'));
        return;
      }

      final result = await _authRepo.resetPassword(
        email: _email,
        otp: _otp,
        password: password,
      );

      result.when(
        success: (message) =>
            emit(const ResetPasswordState.success()),
        error: (error) =>
            emit(ResetPasswordState.error(error.message)),
      );
    }
  }
}
