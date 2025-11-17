/// success : true
/// data : {"message":"Signup successful, check your email for the code.","userId":"6918a246fa44419b086d4422"}

class RegisterResponse {
  RegisterResponse({
      this.success, 
      this.data,});

  RegisterResponse.fromJson(dynamic json) {
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

/// message : "Signup successful, check your email for the code."
/// userId : "6918a246fa44419b086d4422"

class Data {
  Data({
      this.message, 
      this.userId,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    userId = json['userId'];
  }
  String? message;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['userId'] = userId;
    return map;
  }

}