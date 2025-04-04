import 'package:app/core/di/container.dart';
import 'package:app/feature/auth/data/repo/auth.repo.dart';
import 'package:app/feature/user/data/model/user.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.state.dart';
part 'login.cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final _authRepo = locator<AuthRepo>();

  LoginCubit() : super(LoginState.initial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    emit(LoginState.loading());

    final email = emailController.text;
    final password = passwordController.text;

    final result =
        await _authRepo.login(email: email, password: password);

    result.when(
      success: (data) => emit(LoginState.loaded(data.user!)),
      error: (erorr) => emit(LoginState.error(erorr.message)),
    );
  }

  bool get isLogining =>
      state.maybeWhen(loading: () => true, orElse: () => false);
}
