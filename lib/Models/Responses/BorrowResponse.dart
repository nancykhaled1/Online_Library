/// success : true
/// data : {"borrow":{"_id":"691f587266c14580b63715f1","user":{"_id":"6919c54aa5c283182c4de7b5","name":"nancy"},"book":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","numberInStock":10,"publisher":"Publisher Name","writer":"Writer Name","edition":"First","numPages":250,"condition":"old","weight":500,"Synopsis":"This is a sample book.","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png"},"borrowDate":"2025-11-20","borrowTime":"18:05","mustReturnDate":"2025-11-27","status":"pending","qrCodeBorrow":"https://res.cloudinary.com/diubywm4o/image/upload/v1763661938/qrcodes/yig4stbrwdf0vsyiz977.png"},"qrCodeBorrow":"https://res.cloudinary.com/diubywm4o/image/upload/v1763661938/qrcodes/yig4stbrwdf0vsyiz977.png"}

class BorrowResponse {
  BorrowResponse({
      this.success, 
      this.data,});

  BorrowResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? BorrowData.fromJson(json['data']) : null;
  }
  bool? success;
  BorrowData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// borrow : {"_id":"691f587266c14580b63715f1","user":{"_id":"6919c54aa5c283182c4de7b5","name":"nancy"},"book":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","numberInStock":10,"publisher":"Publisher Name","writer":"Writer Name","edition":"First","numPages":250,"condition":"old","weight":500,"Synopsis":"This is a sample book.","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png"},"borrowDate":"2025-11-20","borrowTime":"18:05","mustReturnDate":"2025-11-27","status":"pending","qrCodeBorrow":"https://res.cloudinary.com/diubywm4o/image/upload/v1763661938/qrcodes/yig4stbrwdf0vsyiz977.png"}
/// qrCodeBorrow : "https://res.cloudinary.com/diubywm4o/image/upload/v1763661938/qrcodes/yig4stbrwdf0vsyiz977.png"

class BorrowData {
  BorrowData({
      this.borrow, 
      this.qrCodeBorrow,});

  BorrowData.fromJson(dynamic json) {
    borrow = json['borrow'] != null ? Borrow.fromJson(json['borrow']) : null;
    qrCodeBorrow = json['qrCodeBorrow'];
  }
  Borrow? borrow;
  String? qrCodeBorrow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (borrow != null) {
      map['borrow'] = borrow?.toJson();
    }
    map['qrCodeBorrow'] = qrCodeBorrow;
    return map;
  }

}

/// _id : "691f587266c14580b63715f1"
/// user : {"_id":"6919c54aa5c283182c4de7b5","name":"nancy"}
/// book : {"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","numberInStock":10,"publisher":"Publisher Name","writer":"Writer Name","edition":"First","numPages":250,"condition":"old","weight":500,"Synopsis":"This is a sample book.","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png"}
/// borrowDate : "2025-11-20"
/// borrowTime : "18:05"
/// mustReturnDate : "2025-11-27"
/// status : "pending"
/// qrCodeBorrow : "https://res.cloudinary.com/diubywm4o/image/upload/v1763661938/qrcodes/yig4stbrwdf0vsyiz977.png"

class Borrow {
  Borrow({
      this.id, 
      this.user, 
      this.book, 
      this.borrowDate, 
      this.borrowTime, 
      this.mustReturnDate, 
      this.status, 
      this.qrCodeBorrow,});

  Borrow.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
    borrowDate = json['borrowDate'];
    borrowTime = json['borrowTime'];
    mustReturnDate = json['mustReturnDate'];
    status = json['status'];
    qrCodeBorrow = json['qrCodeBorrow'];
  }
  String? id;
  User? user;
  Book? book;
  String? borrowDate;
  String? borrowTime;
  String? mustReturnDate;
  String? status;
  String? qrCodeBorrow;

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
    map['status'] = status;
    map['qrCodeBorrow'] = qrCodeBorrow;
    return map;
  }

}

/// _id : "691c8e1ab4adb1589feb5238"
/// name : "Education Book"
/// numberInStock : 10
/// publisher : "Publisher Name"
/// writer : "Writer Name"
/// edition : "First"
/// numPages : 250
/// condition : "old"
/// weight : 500
/// Synopsis : "This is a sample book."
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"]
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png"

class Book {
  Book({
      this.id, 
      this.name, 
      this.numberInStock, 
      this.publisher, 
      this.writer, 
      this.edition, 
      this.numPages, 
      this.condition, 
      this.weight, 
      this.synopsis, 
      this.gallery, 
      this.mainImage,});

  Book.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    numberInStock = json['numberInStock'];
    publisher = json['publisher'];
    writer = json['writer'];
    edition = json['edition'];
    numPages = json['numPages'];
    condition = json['condition'];
    weight = json['weight'];
    synopsis = json['Synopsis'];
    gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    mainImage = json['mainImage'];
  }
  String? id;
  String? name;
  int? numberInStock;
  String? publisher;
  String? writer;
  String? edition;
  int? numPages;
  String? condition;
  int? weight;
  String? synopsis;
  List<String>? gallery;
  String? mainImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['numberInStock'] = numberInStock;
    map['publisher'] = publisher;
    map['writer'] = writer;
    map['edition'] = edition;
    map['numPages'] = numPages;
    map['condition'] = condition;
    map['weight'] = weight;
    map['Synopsis'] = synopsis;
    map['gallery'] = gallery;
    map['mainImage'] = mainImage;
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