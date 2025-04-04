part of 'google_auth_cubit.dart';

@freezed
class GoogleAuthState with _$GoogleAuthState {
  const factory GoogleAuthState.initial() = _Initial;

  const factory GoogleAuthState.loading() = _Loading;
  const factory GoogleAuthState.success(UserModel user) = _Success;

  const factory GoogleAuthState.error(String message) = _Error;
}
