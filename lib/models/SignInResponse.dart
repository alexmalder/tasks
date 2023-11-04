class SignInResponse {
  final String accessToken;
  final int expiresIn;
  final int refreshExpiresIn;
  final String refreshToken;
  final String tokenType;
  final int notBeforePolicy;
  final String sessionState;
  final String scope;

  const SignInResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.refreshToken,
    required this.tokenType,
    required this.notBeforePolicy,
    required this.sessionState,
    required this.scope,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      accessToken: json['access_token'] as String,
      expiresIn: json['expires_in'] as int,
      refreshExpiresIn: json['refresh_expires_in'] as int,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      notBeforePolicy: json['not-before-policy'] as int,
      sessionState: json['session_state'] as String,
      scope: json['scope'] as String,
    );
  }
}