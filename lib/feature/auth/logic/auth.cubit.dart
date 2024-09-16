import 'package:app/core/di/container.dart';
import 'package:app/core/helper/dio.helper.dart';
import 'package:app/feature/auth/data/repo/auth.repo.dart';
import 'package:app/feature/auth/data/source/auth.cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.state.dart';
part 'auth.cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final _authRepo = locator<AuthRepo>();
  final _authCache = locator<AuthCache>();

  AuthCubit() : super(const AuthState.initial());

  Future<void> onAppStarted() async {
    final accessToken = await _authCache.accessToken;

    accessToken?.isNotEmpty == true
        ? onAuthinit()
        : emit(const AuthState.unauthenticated());
  }

  void onAuthinit() {
    DioHelper.addTokenInterceptor();
    emit(const AuthState.authenticated());
  }

  Future<void> onLogOut() async {
    await _authRepo.logout();
    DioHelper.removeTokenInterceptor();
    emit(const AuthState.unauthenticated());
  }

  Future<void> refreshToken(String refreshToken) async {
    final response = await _authRepo.refreshToken(refreshToken);

    response.when(
      success: (data) {
        DioHelper.addTokenInterceptor();
        emit(const AuthState.authenticated());
      },
      error: (error) async {
        await onLogOut();
        emit(const AuthState.sessionExpired());
      },
    );
  }
}
