import 'package:app/core/di/container.dart';
import 'package:app/feature/auth/data/repo/auth.repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_state.dart';
part 'otp_cubit.freezed.dart';

class OtpCubit extends Cubit<OtpState> {
  final _authRepo = locator<AuthRepo>();
  final String _email;

  OtpCubit(this._email) : super(const OtpState.initial());

  final otpController = TextEditingController();

  Future<void> submitOtp() async {
    emit(const OtpState.loading());

    final otp = otpController.text;

    final result = await _authRepo.verifyOtp(email: _email, otp: otp);

    result.when(
      success: (message) => emit(
        OtpState.success(email: _email, otp: otp),
      ),
      error: (error) => emit(OtpState.error(error.message)),
    );
  }
}
