/// success : true
/// data : {"message":"Book reviews fetched","book":{"_id":"691a4612a5c283182c4de7da","name":"Book Example","categoryId":"691448b1754324fe6aa70bd7","mainImage":"https://onlinelibrary-production.up.railway.app/uploads/books/69174062c824bbdb62ac1cf1.png","gallery":["https://onlinelibrary-production.up.railway.app/uploads/books/gallery/69174062c824bbdb62ac1cf1.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-16T21:45:54.868Z","updatedAt":"2025-11-16T21:45:54.868Z","__v":0},"reviews":[{"_id":"691b368128146284cb63ed6d","bookId":"691a4612a5c283182c4de7da","userId":{"_id":"691740a6c824bbdb62ac1cf2","name":"Ahmed Ali","id":"691740a6c824bbdb62ac1cf2"},"rating":3,"createdAt":"2025-11-17T14:51:45.852Z","updatedAt":"2025-11-17T14:51:45.852Z","__v":0},{"_id":"691b332928146284cb63ed4d","bookId":"691a4612a5c283182c4de7da","userId":{"_id":"6919c54aa5c283182c4de7b5","name":"nancy","id":"6919c54aa5c283182c4de7b5"},"rating":5,"createdAt":"2025-11-17T14:37:29.377Z","updatedAt":"2025-11-17T14:37:29.377Z","__v":0}]}

class BookReviewResponse {
  BookReviewResponse({
      this.success, 
      this.data,});

  BookReviewResponse.fromJson(dynamic json) {
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

/// message : "Book reviews fetched"
/// book : {"_id":"691a4612a5c283182c4de7da","name":"Book Example","categoryId":"691448b1754324fe6aa70bd7","mainImage":"https://onlinelibrary-production.up.railway.app/uploads/books/69174062c824bbdb62ac1cf1.png","gallery":["https://onlinelibrary-production.up.railway.app/uploads/books/gallery/69174062c824bbdb62ac1cf1.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-16T21:45:54.868Z","updatedAt":"2025-11-16T21:45:54.868Z","__v":0}
/// reviews : [{"_id":"691b368128146284cb63ed6d","bookId":"691a4612a5c283182c4de7da","userId":{"_id":"691740a6c824bbdb62ac1cf2","name":"Ahmed Ali","id":"691740a6c824bbdb62ac1cf2"},"rating":3,"createdAt":"2025-11-17T14:51:45.852Z","updatedAt":"2025-11-17T14:51:45.852Z","__v":0},{"_id":"691b332928146284cb63ed4d","bookId":"691a4612a5c283182c4de7da","userId":{"_id":"6919c54aa5c283182c4de7b5","name":"nancy","id":"6919c54aa5c283182c4de7b5"},"rating":5,"createdAt":"2025-11-17T14:37:29.377Z","updatedAt":"2025-11-17T14:37:29.377Z","__v":0}]

class Data {
  Data({
      this.message, 
      this.book, 
      this.reviews,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
  }
  String? message;
  Book? book;
  List<Reviews>? reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (book != null) {
      map['book'] = book?.toJson();
    }
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "691b368128146284cb63ed6d"
/// bookId : "691a4612a5c283182c4de7da"
/// userId : {"_id":"691740a6c824bbdb62ac1cf2","name":"Ahmed Ali","id":"691740a6c824bbdb62ac1cf2"}
/// rating : 3
/// createdAt : "2025-11-17T14:51:45.852Z"
/// updatedAt : "2025-11-17T14:51:45.852Z"
/// __v : 0

class Reviews {
  Reviews({
      this.id, 
      this.bookId, 
      this.userId, 
      this.rating,
      this.comment,
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Reviews.fromJson(dynamic json) {
    id = json['_id'];
    bookId = json['bookId'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? bookId;
  UserId? userId;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['bookId'] = bookId;
    if (userId != null) {
      map['userId'] = userId?.toJson();
    }
    map['rating'] = rating;
    map['comment'] = comment;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

/// _id : "691740a6c824bbdb62ac1cf2"
/// name : "Ahmed Ali"
/// id : "691740a6c824bbdb62ac1cf2"

class UserId {
  UserId({
      this.id, 
      this.name,
    this.photo
      });

  UserId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    id = json['id'];
    photo = json['photo'];

  }
  String? id;
  String? name;
  String? photo;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['photo'] = photo;


    return map;
  }

}

/// _id : "691a4612a5c283182c4de7da"
/// name : "Book Example"
/// categoryId : "691448b1754324fe6aa70bd7"
/// mainImage : "https://onlinelibrary-production.up.railway.app/uploads/books/69174062c824bbdb62ac1cf1.png"
/// gallery : ["https://onlinelibrary-production.up.railway.app/uploads/books/gallery/69174062c824bbdb62ac1cf1.png"]
/// numberOfCopies : 10
/// numberInStock : 10
/// borrowedBy : 0
/// publisher : "Publisher Name"
/// writer : "Writer Name"
/// language : "English"
/// publishYear : 2022
/// edition : "First"
/// Synopsis : "This is a sample book."
/// numPages : 250
/// condition : "new"
/// weight : 500
/// createdAt : "2025-11-16T21:45:54.868Z"
/// updatedAt : "2025-11-16T21:45:54.868Z"
/// __v : 0

class Book {
  Book({
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

  Book.fromJson(dynamic json) {
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