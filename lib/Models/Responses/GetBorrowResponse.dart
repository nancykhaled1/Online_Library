/// success : true
/// data : {"borrowed":[{"_id":"691f587266c14580b63715f1","userId":"6919c54aa5c283182c4de7b5","bookId":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-11-20T18:48:12.456Z","__v":0},"borrowDate":"2025-11-20T18:05:37.891Z","borrowTime":"18:05","mustReturnDate":"2025-11-27T18:05:37.891Z","status":"on_borrow","qrCodeBorrow":"https://res.cloudinary.com/diubywm4o/image/upload/v1763661938/qrcodes/yig4stbrwdf0vsyiz977.png","qrBorrowExpiresAt":"2025-11-20T21:05:37.891Z","createdAt":"2025-11-20T18:05:38.864Z","updatedAt":"2025-11-20T18:48:12.353Z","__v":0,"scannedByAdminAt":"2025-11-20T18:48:12.352Z"}],"returned":[]}

class GetBorrowResponse {
  GetBorrowResponse({
      this.success, 
      this.data,});

  GetBorrowResponse.fromJson(dynamic json) {
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

/// borrowed : [{"_id":"691f587266c14580b63715f1","userId":"6919c54aa5c283182c4de7b5","bookId":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-11-20T18:48:12.456Z","__v":0},"borrowDate":"2025-11-20T18:05:37.891Z","borrowTime":"18:05","mustReturnDate":"2025-11-27T18:05:37.891Z","status":"on_borrow","qrCodeBorrow":"https://res.cloudinary.com/diubywm4o/image/upload/v1763661938/qrcodes/yig4stbrwdf0vsyiz977.png","qrBorrowExpiresAt":"2025-11-20T21:05:37.891Z","createdAt":"2025-11-20T18:05:38.864Z","updatedAt":"2025-11-20T18:48:12.353Z","__v":0,"scannedByAdminAt":"2025-11-20T18:48:12.352Z"}]
/// returned : []

class Data {
  Data({
      this.borrowed, 
      this.returned,});

  Data.fromJson(dynamic json) {
    if (json['borrowed'] != null) {
      borrowed = [];
      json['borrowed'].forEach((v) {
        borrowed?.add(Borrowed.fromJson(v));
      });
    }
    if (json['returned'] != null) {
      returned = [];
      json['returned'].forEach((v) {
        returned?.add(Returned.fromJson(v));
      });
    }
  }
  List<Borrowed>? borrowed;
  List<Returned>? returned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (borrowed != null) {
      map['borrowed'] = borrowed?.map((v) => v.toJson()).toList();
    }
    if (returned != null) {
      map['returned'] = returned?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "691f587266c14580b63715f1"
/// userId : "6919c54aa5c283182c4de7b5"
/// bookId : {"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-11-20T18:48:12.456Z","__v":0}
/// borrowDate : "2025-11-20T18:05:37.891Z"
/// borrowTime : "18:05"
/// mustReturnDate : "2025-11-27T18:05:37.891Z"
/// status : "on_borrow"
/// qrCodeBorrow : "https://res.cloudinary.com/diubywm4o/image/upload/v1763661938/qrcodes/yig4stbrwdf0vsyiz977.png"
/// qrBorrowExpiresAt : "2025-11-20T21:05:37.891Z"
/// createdAt : "2025-11-20T18:05:38.864Z"
/// updatedAt : "2025-11-20T18:48:12.353Z"
/// __v : 0
/// scannedByAdminAt : "2025-11-20T18:48:12.352Z"

class Borrowed {
  Borrowed({
      this.id, 
      this.userId, 
      this.bookId, 
      this.borrowDate, 
      this.borrowTime, 
      this.mustReturnDate, 
      this.status, 
      this.qrCodeBorrow, 
      this.qrBorrowExpiresAt, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.scannedByAdminAt,});

  Borrowed.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    bookId = json['bookId'] != null ? BookId.fromJson(json['bookId']) : null;
    borrowDate = json['borrowDate'];
    borrowTime = json['borrowTime'];
    mustReturnDate = json['mustReturnDate'];
    status = json['status'];
    qrCodeBorrow = json['qrCodeBorrow'];
    qrBorrowExpiresAt = json['qrBorrowExpiresAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    scannedByAdminAt = json['scannedByAdminAt'];
  }
  String? id;
  String? userId;
  BookId? bookId;
  String? borrowDate;
  String? borrowTime;
  String? mustReturnDate;
  String? status;
  String? qrCodeBorrow;
  String? qrBorrowExpiresAt;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? scannedByAdminAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    if (bookId != null) {
      map['bookId'] = bookId?.toJson();
    }
    map['borrowDate'] = borrowDate;
    map['borrowTime'] = borrowTime;
    map['mustReturnDate'] = mustReturnDate;
    map['status'] = status;
    map['qrCodeBorrow'] = qrCodeBorrow;
    map['qrBorrowExpiresAt'] = qrBorrowExpiresAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['scannedByAdminAt'] = scannedByAdminAt;
    return map;
  }

}

/// _id : "691c8e1ab4adb1589feb5238"
/// name : "Education Book"
/// categoryId : "691b7d849e366d61f7897b75"
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png"
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"]
/// numberOfCopies : 10
/// numberInStock : 9
/// borrowedBy : 1
/// publisher : "Publisher Name"
/// writer : "Writer Name"
/// language : "English"
/// publishYear : 2022
/// edition : "First"
/// Synopsis : "This is a sample book."
/// numPages : 250
/// condition : "old"
/// weight : 500
/// createdAt : "2025-11-18T15:17:46.596Z"
/// updatedAt : "2025-11-20T18:48:12.456Z"
/// __v : 0

class BookId {
  BookId({
      this.id, 
      this.name, 
      this.categoryId, 
      this.mainImage, 
      this.gallery, 
      this.numberOfCopies, 
      this.numberInStock, 
      this.borrowedBy, 
      this.publisher, 
      this.writer, 
      this.language, 
      this.publishYear, 
      this.edition, 
      this.synopsis, 
      this.numPages, 
      this.condition, 
      this.weight, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  BookId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    categoryId = json['categoryId'];
    mainImage = json['mainImage'];
    gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    numberOfCopies = json['numberOfCopies'];
    numberInStock = json['numberInStock'];
    borrowedBy = json['borrowedBy'];
    publisher = json['publisher'];
    writer = json['writer'];
    language = json['language'];
    publishYear = json['publishYear'];
    edition = json['edition'];
    synopsis = json['Synopsis'];
    numPages = json['numPages'];
    condition = json['condition'];
    weight = json['weight'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? categoryId;
  String? mainImage;
  List<String>? gallery;
  int? numberOfCopies;
  int? numberInStock;
  int? borrowedBy;
  String? publisher;
  String? writer;
  String? language;
  int? publishYear;
  String? edition;
  String? synopsis;
  int? numPages;
  String? condition;
  int? weight;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['categoryId'] = categoryId;
    map['mainImage'] = mainImage;
    map['gallery'] = gallery;
    map['numberOfCopies'] = numberOfCopies;
    map['numberInStock'] = numberInStock;
    map['borrowedBy'] = borrowedBy;
    map['publisher'] = publisher;
    map['writer'] = writer;
    map['language'] = language;
    map['publishYear'] = publishYear;
    map['edition'] = edition;
    map['Synopsis'] = synopsis;
    map['numPages'] = numPages;
    map['condition'] = condition;
    map['weight'] = weight;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}


class Returned {
  Returned({
    this.id,
    this.userId,
    this.bookId,
    this.borrowDate,
    this.borrowTime,
    this.mustReturnDate,
    this.status,
    this.qrCodeBorrow,
    this.qrBorrowExpiresAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.scannedByAdminAt,
    this.qrCodeReturn,
    this.qrReturnExpiresAt,
    this.returnedAt,});

  Returned.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    bookId = json['bookId'] != null ? BookId.fromJson(json['bookId']) : null;
    borrowDate = json['borrowDate'];
    borrowTime = json['borrowTime'];
    mustReturnDate = json['mustReturnDate'];
    status = json['status'];
    qrCodeBorrow = json['qrCodeBorrow'];
    qrBorrowExpiresAt = json['qrBorrowExpiresAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    scannedByAdminAt = json['scannedByAdminAt'];
    qrCodeReturn = json['qrCodeReturn'];
    qrReturnExpiresAt = json['qrReturnExpiresAt'];
    returnedAt = json['returnedAt'];
  }
  String? id;
  String? userId;
  BookId? bookId;
  String? borrowDate;
  String? borrowTime;
  String? mustReturnDate;
  String? status;
  String? qrCodeBorrow;
  String? qrBorrowExpiresAt;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? scannedByAdminAt;
  String? qrCodeReturn;
  String? qrReturnExpiresAt;
  String? returnedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    if (bookId != null) {
      map['bookId'] = bookId?.toJson();
    }
    map['borrowDate'] = borrowDate;
    map['borrowTime'] = borrowTime;
    map['mustReturnDate'] = mustReturnDate;
    map['status'] = status;
    map['qrCodeBorrow'] = qrCodeBorrow;
    map['qrBorrowExpiresAt'] = qrBorrowExpiresAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['scannedByAdminAt'] = scannedByAdminAt;
    map['qrCodeReturn'] = qrCodeReturn;
    map['qrReturnExpiresAt'] = qrReturnExpiresAt;
    map['returnedAt'] = returnedAt;
    return map;
  }

}