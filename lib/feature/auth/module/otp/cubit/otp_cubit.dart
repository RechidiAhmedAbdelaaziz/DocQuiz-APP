import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_state.dart';
part 'otp_cubit.freezed.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.email) : super(const OtpState.initial());

  final String email;
  final otpController = TextEditingController();

  Future<void> submitOtp() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
