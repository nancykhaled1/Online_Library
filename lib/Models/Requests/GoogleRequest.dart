class GoogleLoginRequest {
  final String token;


  GoogleLoginRequest({required this.token});

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}
