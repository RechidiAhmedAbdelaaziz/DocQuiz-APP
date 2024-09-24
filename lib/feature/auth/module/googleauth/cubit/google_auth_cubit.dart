import 'package:app/core/di/container.dart';
import 'package:app/feature/auth/data/repo/auth.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'google_auth_state.dart';
part 'google_auth_cubit.freezed.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final _authRepo = locator<AuthRepo>();

  GoogleAuthCubit() : super(const GoogleAuthState.initial());

  Future<void> signIn() async {
    emit(const GoogleAuthState.loading());

    final result = await _authRepo.googleAuth(GoogleSignIn(
      scopes: ['email', 'profile'],
      serverClientId:
          '657663867003-b4vdfcag1puldl32phnb9hukflg53fh1.apps.googleusercontent.com',
    ));

    result.when(
      success: (_) => emit(const GoogleAuthState.success()),
      error: (error) => emit(GoogleAuthState.error(error.message)),
    );
  }
}
