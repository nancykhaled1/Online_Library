/// success : true
/// data : {"message":"User profile deleted","user":{"_id":"692466ff58540df5fe549dc6","name":"nancy","email":"nancyhendawy22@gmail.com","phone":"01012342678","role":"user","photo":"https://res.cloudinary.com/diubywm4o/image/upload/v1763995182/users/fbywcuq8gcphdcw1a94f.jpg","gender":"female","emailVerified":true,"createdAt":"2025-11-24T14:09:03.087Z","updatedAt":"2025-11-24T14:39:42.933Z","__v":0,"id":"692466ff58540df5fe549dc6"}}

class DeleteProfileResponse {
  DeleteProfileResponse({
      this.success, 
      this.data,});

  DeleteProfileResponse.fromJson(dynamic json) {
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

/// message : "User profile deleted"
/// user : {"_id":"692466ff58540df5fe549dc6","name":"nancy","email":"nancyhendawy22@gmail.com","phone":"01012342678","role":"user","photo":"https://res.cloudinary.com/diubywm4o/image/upload/v1763995182/users/fbywcuq8gcphdcw1a94f.jpg","gender":"female","emailVerified":true,"createdAt":"2025-11-24T14:09:03.087Z","updatedAt":"2025-11-24T14:39:42.933Z","__v":0,"id":"692466ff58540df5fe549dc6"}

class Data {
  Data({
      this.message, 
      this.user,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? message;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// _id : "692466ff58540df5fe549dc6"
/// name : "nancy"
/// email : "nancyhendawy22@gmail.com"
/// phone : "01012342678"
/// role : "user"
/// photo : "https://res.cloudinary.com/diubywm4o/image/upload/v1763995182/users/fbywcuq8gcphdcw1a94f.jpg"
/// gender : "female"
/// emailVerified : true
/// createdAt : "2025-11-24T14:09:03.087Z"
/// updatedAt : "2025-11-24T14:39:42.933Z"
/// __v : 0
/// id : "692466ff58540df5fe549dc6"

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.role, 
      this.photo, 
      this.gender, 
      this.emailVerified, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      });

  User.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    photo = json['photo'];
    gender = json['gender'];
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
  String? photo;
  String? gender;
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
    map['photo'] = photo;
    map['gender'] = gender;
    map['emailVerified'] = emailVerified;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}