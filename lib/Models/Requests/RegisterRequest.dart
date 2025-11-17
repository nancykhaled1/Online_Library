/// name : "Ahmed Ali"
/// email : "nancykhaledn905@gmail.com"
/// password : "12345678"
/// phone : "01012342678"
/// gender : "Female"

class RegisterRequest {
  RegisterRequest({
      this.name, 
      this.email, 
      this.password, 
      this.phone, 
      this.gender,});

  RegisterRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    gender = json['gender'];
  }
  String? name;
  String? email;
  String? password;
  String? phone;
  String? gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['phone'] = phone;
    map['gender'] = gender;
    return map;
  }

}