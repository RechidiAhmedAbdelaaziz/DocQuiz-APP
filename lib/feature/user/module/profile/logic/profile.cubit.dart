import 'package:app/core/di/container.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/user/data/model/user.model.dart';
import 'package:app/feature/user/data/repo/user.repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile.state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final _userRepo = locator<UserRepo>();

  ProfileCubit() : super(ProfileState.initial());

  Future<void> fetchProfile() async {
    final result = await _userRepo.getProfile();
    result.when(
      success: (user) => _updateUser(user),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  final infoFormKey = GlobalKey<FormState>();
  final securityFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  DomainModel? domain;
  LevelModel? level;
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool get canUpdateInof =>
      nameController.text != state.user!.name ||
      emailController.text != state.user!.email;

  Future<void> updateInfo() async {
    if (!canUpdateInof || !infoFormKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text == state.user!.name
        ? null
        : nameController.text;

    final email = emailController.text == state.user!.email
        ? null
        : emailController.text;

    _updateProfile(name: name, email: email);
  }

  bool get canUpdateSpeciality =>
      (domain != null && level != null) &&
      (level != state.user!.level || domain != state.user!.domain);

  Future<void> updateSpeciality() async {
    if (!canUpdateSpeciality) return;

    final domainId = domain == state.user!.domain ? null : domain!.id;
    final levelId = level == state.user!.level ? null : level!.id;

    _updateProfile(domainId: domainId, levelId: levelId);
  }

  bool get canUpdatePassword =>
      passwordController.text.isNotEmpty &&
      newPasswordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty;

  Future<void> updatePassword() async {
    if (!canUpdatePassword ||
        !securityFormKey.currentState!.validate()) {
      return;
    }

    final oldPassword = passwordController.text;
    final newPassword = newPasswordController.text;

    final result = await _userRepo.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    result.when(
      success: (_) => _updateUser(null, isUpdate: true),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  Future<void> _updateProfile({
    String? name,
    String? email,
    String? domainId,
    String? levelId,
  }) async {
    final result = await _userRepo.updateProfile(
      name: name,
      email: email,
      domainId: domainId,
      levelId: levelId,
    );
    result.when(
      success: (user) => _updateUser(user, isUpdate: true),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  void _updateUser(UserModel? user, {bool isUpdate = false}) {
    if (user != null) {
      nameController.text = user.name!;
      emailController.text = user.email!;
      domain = user.domain;
      level = user.level;
    }

    isUpdate
        ? emit(state._updateProfile(user))
        : emit(state._fetchProfile(user!));
  }

  void infoUpdated(String? value) => emit(state._updateProfile(null));
}
