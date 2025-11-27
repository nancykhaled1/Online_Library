class GoogleResponse {
  final bool success;
  final String token;
  final UserData user;


  GoogleResponse({
    required this.success,
    required this.token,
    required this.user,
  });

  factory GoogleResponse.fromJson(Map<String, dynamic> json) {
    return GoogleResponse(
      success: json["success"],
      token: json["token"],
      user: UserData.fromJson(json['user'] ?? {}),
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;




  UserData({
    required this.id,
    required this.name,
    required this.email,

  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"]??'',
      name: json["name"]??'',
      email: json["email"],
      // role: json["role"],

    );
  }
}


// success: true,
// token: authToken,
// user: {
// id: user._id,
// name: user.name,
// email: user.email,
// },

