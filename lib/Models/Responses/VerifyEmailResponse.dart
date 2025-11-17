class VerifyEmailResponse {
  final bool success;
  final VerifyEmailData data;

  VerifyEmailResponse({
    required this.success,
    required this.data,
  });

  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    return VerifyEmailResponse(
      success: json['success'],
      data: VerifyEmailData.fromJson(json['data']),
    );
  }
}

class VerifyEmailData {
  final String message;
  final String token;
  final String user;

  VerifyEmailData({
    required this.message,
    required this.token,
    required this.user,
  });

  factory VerifyEmailData.fromJson(Map<String, dynamic> json) {
    return VerifyEmailData(
      message: json['message'],
      token: json['token'],
      user: json['user'],
    );
  }
}

