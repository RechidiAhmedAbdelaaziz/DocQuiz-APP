import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/user/data/model/user.model.dart';
import 'package:app/feature/user/data/source/user.api.dart';

class UserRepo {
  final _userApi = locator<UserApi>();

  RepoResult<UserModel> getProfile() async {
    apiCall() async {
      final response = await _userApi.getProfile();
      return UserModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<UserModel> updateProfile({
    String? name,
    String? email,
    String? domainId,
    String? levelId,
  }) async {
    apiCall() async {
      final response = await _userApi.updateProfile({
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (domainId != null) 'domainId': domainId,
        if (levelId != null) 'levelId': levelId,
      });
      return UserModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    apiCall() async {
      await _userApi.updatePassword({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });
    }

    return await TryCallApi.call(apiCall);
  }
}
