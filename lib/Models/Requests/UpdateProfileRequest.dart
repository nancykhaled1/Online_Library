class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.image
  });

  String? name;
  String? phone;
  String? gender;
  String? email;
  String? image;




  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['gender'] = gender;
    map['email'] = email;
    if (image != null) map['baseImage64'] = image;


    return map;
  }


}