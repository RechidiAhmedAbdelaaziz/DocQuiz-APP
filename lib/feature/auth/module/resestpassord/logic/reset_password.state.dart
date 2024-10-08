part of 'reset_password.cubit.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;

  const factory ResetPasswordState.loading() = _Loading;

  const factory ResetPasswordState.success() = _Success;

  const factory ResetPasswordState.error(String message) = _Error;
}
