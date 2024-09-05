part of 'api_response.model.dart';

class _Tokens {
  _Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory _Tokens.fromJson(Map<String, dynamic>? json) {
    return _Tokens(
      accessToken: json?['accessToken'],
      refreshToken: json?['refreshToken'],
    );
  }

  final String accessToken;
  final String refreshToken;
}
