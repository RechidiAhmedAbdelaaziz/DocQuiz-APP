import 'package:app/core/di/container.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/auth/data/source/auth.api.dart';
import 'package:app/feature/auth/data/source/auth.cache.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final _authApi = locator<AuthApi>();
  final _authCache = locator<AuthCache>();

  RepoResult<AuthResponse> login({
    required String email,
    required String password,
  }) {
    apiCall() async {
      final result = await _authApi.login({
        'email': email,
        'password': password,
      });

      final tokens = result.tokens!;
      await _authCache.setTokens(tokens);
      return result;
    }

    return TryCallApi.call(apiCall);
  }

  RepoResult<AuthResponse> register({
    required String email,
    required String password,
    required String name,
  }) {
    apiCall() async {
      final result = await _authApi.register({
        'email': email,
        'password': password,
        'name': name,
      });

      final tokens = result.tokens!;
      await _authCache.setTokens(tokens);
      return result;
    }

    return TryCallApi.call(apiCall);
  }

  RepoResult<AuthTokens> refreshToken(String refreshToken) {
    apiCall() async {
      final result = await _authApi.refreshToken(refreshToken);
      final tokens = result.tokens!;
      await _authCache.setTokens(tokens);
      return tokens;
    }

    return TryCallApi.call(apiCall);
  }

  RepoResult<String> forgotPassword({
    required String email,
  }) {
    apiCall() async {
      final result = await _authApi.forgotPassword({
        'email': email,
      });
      return result.message!;
    }

    return TryCallApi.call(apiCall);
  }

  RepoResult<String> verifyOtp({
    required String email,
    required String otp,
  }) {
    apiCall() async {
      final result = await _authApi.verifyOtp({
        'email': email,
        'otp': otp,
      });
      return result.message!;
    }

    return TryCallApi.call(apiCall);
  }

  RepoResult<String> resetPassword({
    required String email,
    required String password,
    required String otp,
  }) {
    apiCall() async {
      final result = await _authApi.resetPassword({
        'email': email,
        'password': password,
        'otp': otp,
      });
      return result.message!;
    }

    return TryCallApi.call(apiCall);
  }

  RepoResult<AuthResponse> googleAuth(GoogleSignIn googleSignIn) {
    apiCall() async {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw 'User cancelled';
      }

      final code = googleUser.serverAuthCode!;

      final result = await _authApi.googleCallback(code);
      final tokens = result.tokens!;

      await _authCache.setTokens(tokens);

      return result;
    }

    return TryCallApi.call(apiCall);
  }

  Future<void> logout() async {
    await _authCache.clearTokens();
  }
}
