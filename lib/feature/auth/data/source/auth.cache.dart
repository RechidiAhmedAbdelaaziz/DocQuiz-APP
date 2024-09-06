import 'package:app/core/di/container.dart';
import 'package:app/core/helper/cache.helper.dart';
import 'package:app/core/network/models/api_response.model.dart';

class AuthCache {
  final CacheHelper _cacheHelper = locator();

  Future<void> setTokens(AuthTokens tokens) async {
    await _cacheHelper.setSecuredString(
      'ACCESS_TOKEN',
      tokens.accessToken,
    );

    await _cacheHelper.setSecuredString(
      'REFRESH_TOKEN',
      tokens.refreshToken,
    );
  }

  Future<String?> get accessToken async =>
      await _cacheHelper.getSecuredString('ACCESS_TOKEN');

  Future<String?> get refreshToken async =>
      await _cacheHelper.getSecuredString('REFRESH_TOKEN');

  Future<void> clearTokens() async {
    await _cacheHelper.removeSecuredData('TOKEN');
    await _cacheHelper.removeSecuredData('REFRESH_TOKEN');
  }
}
