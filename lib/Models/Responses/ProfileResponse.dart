/// success : true
/// data : {"message":"User profile fetched","user":{"_id":"6919c54aa5c283182c4de7b5","name":"nancy","email":"nancyhendawy22@gmail.com","phone":"0123456789","role":"user","gender":"female","emailVerified":true,"createdAt":"2025-11-16T12:36:26.051Z","updatedAt":"2025-11-16T12:38:45.256Z","__v":0,"id":"6919c54aa5c283182c4de7b5"}}

class ProfileResponse {
  ProfileResponse({
      this.success, 
      this.data,});

  ProfileResponse.fromJson(dynamic json) {
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

/// message : "User profile fetched"
/// user : {"_id":"6919c54aa5c283182c4de7b5","name":"nancy","email":"nancyhendawy22@gmail.com","phone":"0123456789","role":"user","gender":"female","emailVerified":true,"createdAt":"2025-11-16T12:36:26.051Z","updatedAt":"2025-11-16T12:38:45.256Z","__v":0,"id":"6919c54aa5c283182c4de7b5"}

class Data {
  Data({
      this.message, 
      this.user,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? ProfileUser.fromJson(json['user']) : null;
  }
  String? message;
  ProfileUser? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// _id : "6919c54aa5c283182c4de7b5"
/// name : "nancy"
/// email : "nancyhendawy22@gmail.com"
/// phone : "0123456789"
/// role : "user"
/// gender : "female"
/// emailVerified : true
/// createdAt : "2025-11-16T12:36:26.051Z"
/// updatedAt : "2025-11-16T12:38:45.256Z"
/// __v : 0
/// id : "6919c54aa5c283182c4de7b5"

class ProfileUser {
  ProfileUser({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.role, 
      this.gender,
      this.baseImage64,
      this.emailVerified, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      });

  ProfileUser.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    gender = json['gender'];
    baseImage64 = json['BaseImage64'];
    emailVerified = json['emailVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];

  }
  String? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? gender;
  dynamic baseImage64;
  bool? emailVerified;
  String? createdAt;
  String? updatedAt;
  int? v;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['gender'] = gender;
    map['BaseImage64'] = baseImage64;
    map['emailVerified'] = emailVerified;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;

    return map;
  }

}