part of 'otp_cubit.dart';

@freezed
class OtpState with _$OtpState {
  const factory OtpState.initial() = _Initial;

  const factory OtpState.loading() = _Loading;
  const factory OtpState.success({
    required String email,  
    required String otp,
  }) = _Success;

  const factory OtpState.error(String message) = _Error;
}
