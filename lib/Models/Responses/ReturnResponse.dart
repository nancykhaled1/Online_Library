/// success : true
/// data : {"borrow":{"_id":"691f587266c14580b63715f1","user":{"_id":"6919c54aa5c283182c4de7b5","name":"nancy"},"book":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book"},"borrowDate":"2025-11-20","borrowTime":"18:05","mustReturnDate":"2025-11-27","qrCodeReturn":"https://res.cloudinary.com/diubywm4o/image/upload/v1763668463/qrcodes/ufucvmxz9x91qvivdbqc.png","status":"on_borrow"},"qrCodeReturn":"https://res.cloudinary.com/diubywm4o/image/upload/v1763668463/qrcodes/ufucvmxz9x91qvivdbqc.png"}

class ReturnResponse {
  ReturnResponse({
      this.success, 
      this.data,});

  ReturnResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? ReturnData.fromJson(json['data']) : null;
  }
  bool? success;
  ReturnData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// borrow : {"_id":"691f587266c14580b63715f1","user":{"_id":"6919c54aa5c283182c4de7b5","name":"nancy"},"book":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book"},"borrowDate":"2025-11-20","borrowTime":"18:05","mustReturnDate":"2025-11-27","qrCodeReturn":"https://res.cloudinary.com/diubywm4o/image/upload/v1763668463/qrcodes/ufucvmxz9x91qvivdbqc.png","status":"on_borrow"}
/// qrCodeReturn : "https://res.cloudinary.com/diubywm4o/image/upload/v1763668463/qrcodes/ufucvmxz9x91qvivdbqc.png"

class ReturnData {
  ReturnData({
      this.borrow, 
      this.qrCodeReturn,});

  ReturnData.fromJson(dynamic json) {
    borrow = json['borrow'] != null ? Borrow.fromJson(json['borrow']) : null;
    qrCodeReturn = json['qrCodeReturn'];
  }
  Borrow? borrow;
  String? qrCodeReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (borrow != null) {
      map['borrow'] = borrow?.toJson();
    }
    map['qrCodeReturn'] = qrCodeReturn;
    return map;
  }

}

/// _id : "691f587266c14580b63715f1"
/// user : {"_id":"6919c54aa5c283182c4de7b5","name":"nancy"}
/// book : {"_id":"691c8e1ab4adb1589feb5238","name":"Education Book"}
/// borrowDate : "2025-11-20"
/// borrowTime : "18:05"
/// mustReturnDate : "2025-11-27"
/// qrCodeReturn : "https://res.cloudinary.com/diubywm4o/image/upload/v1763668463/qrcodes/ufucvmxz9x91qvivdbqc.png"
/// status : "on_borrow"

class Borrow {
  Borrow({
      this.id, 
      this.user, 
      this.book, 
      this.borrowDate, 
      this.borrowTime, 
      this.mustReturnDate, 
      this.qrCodeReturn, 
      this.status,});

  Borrow.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
    borrowDate = json['borrowDate'];
    borrowTime = json['borrowTime'];
    mustReturnDate = json['mustReturnDate'];
    qrCodeReturn = json['qrCodeReturn'];
    status = json['status'];
  }
  String? id;
  User? user;
  Book? book;
  String? borrowDate;
  String? borrowTime;
  String? mustReturnDate;
  String? qrCodeReturn;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (book != null) {
      map['book'] = book?.toJson();
    }
    map['borrowDate'] = borrowDate;
    map['borrowTime'] = borrowTime;
    map['mustReturnDate'] = mustReturnDate;
    map['qrCodeReturn'] = qrCodeReturn;
    map['status'] = status;
    return map;
  }

}

/// _id : "691c8e1ab4adb1589feb5238"
/// name : "Education Book"

class Book {
  Book({
      this.id, 
      this.name,});

  Book.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}

/// _id : "6919c54aa5c283182c4de7b5"
/// name : "nancy"

class User {
  User({
      this.id, 
      this.name,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}