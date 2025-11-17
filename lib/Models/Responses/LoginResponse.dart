/// success : true
/// data : {"message":"Login successful.","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MTc0MGE2YzgyNGJiZGI2MmFjMWNmMiIsInJvbGUiOiJ1c2VyIiwibmFtZSI6IkFobWVkIEFsaSIsImlhdCI6MTc2MzIwNzg1NiwiZXhwIjoxNzYzODEyNjU2fQ.BodbwxT5U2UBqF1_a-9Xv9d7e05qY8qT9J1eKo5JuWE","user":"Ahmed Ali","role":"user","email":"hassan@example.com","_id":"691740a6c824bbdb62ac1cf2"}

class LoginResponse {
  LoginResponse({
      this.success, 
      this.data,});

  LoginResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Login successful."
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MTc0MGE2YzgyNGJiZGI2MmFjMWNmMiIsInJvbGUiOiJ1c2VyIiwibmFtZSI6IkFobWVkIEFsaSIsImlhdCI6MTc2MzIwNzg1NiwiZXhwIjoxNzYzODEyNjU2fQ.BodbwxT5U2UBqF1_a-9Xv9d7e05qY8qT9J1eKo5JuWE"
/// user : "Ahmed Ali"
/// role : "user"
/// email : "hassan@example.com"
/// _id : "691740a6c824bbdb62ac1cf2"

class Data {
  Data({
      this.message, 
      this.token, 
      this.user, 
      this.role, 
      this.email, 
      this.id,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    user = json['user'];
    role = json['role'];
    email = json['email'];
    id = json['_id'];
  }
  String? message;
  String? token;
  String? user;
  String? role;
  String? email;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    map['user'] = user;
    map['role'] = role;
    map['email'] = email;
    map['_id'] = id;
    return map;
  }

}