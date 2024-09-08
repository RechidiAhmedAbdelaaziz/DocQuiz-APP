part of 'forget_password.cubit.dart';

@freezed
class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState.initial() = _Initial;

  const factory ForgetPasswordState.loading() = _Loading;
  const factory ForgetPasswordState.success(String message) =
      _Success;
  const factory ForgetPasswordState.error(String message) = _Error;
}
