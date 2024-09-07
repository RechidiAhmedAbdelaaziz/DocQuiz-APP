part of 'login.cubit.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState.initial() = _Initial;

  factory LoginState.loading() = _Loading;
  factory LoginState.loaded() = _Loaded;

  factory LoginState.error(String message) = _Error;

}
