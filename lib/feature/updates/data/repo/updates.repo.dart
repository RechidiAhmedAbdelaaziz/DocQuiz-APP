import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/updates/data/model/updates.model.dart';
import 'package:app/feature/updates/data/source/updates.api.dart';

class UpdatesRepo {
  final _updatesApi = locator<UpdatesApi>();

  RepoListResult<UpdatesModel> getUpdates() async {
    apiCall() async {
      final response = await _updatesApi.getUpdates();
      return response.data!
          .map((e) => UpdatesModel.fromJson(e))
          .toList();
    }

    return await TryCallApi.call(apiCall);
  }
}
