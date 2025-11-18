/// success : true
/// data : {"message":"Favorites fetched","favorites":[{"_id":"691c5b902d1cd8e65a413a61","userId":"6919c54aa5c283182c4de7b5","bookId":{"_id":"691a468ba5c283182c4de7de","name":"Book Example 222","categoryId":"6919d302a5c283182c4de7c5","mainImage":"https://onlinelibrary-production.up.railway.app/uploads/books/69174062c824bbdb62ac1cf1.png","gallery":["https://onlinelibrary-production.up.railway.app/uploads/books/gallery/69174062c824bbdb62ac1cf1.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-16T21:47:55.200Z","updatedAt":"2025-11-16T21:47:55.200Z","__v":0},"createdAt":"2025-11-18T11:42:08.597Z","updatedAt":"2025-11-18T11:42:08.597Z","__v":0}]}

class AllSavedBooksResponse {
  AllSavedBooksResponse({
      this.success, 
      this.data,});

  AllSavedBooksResponse.fromJson(dynamic json) {
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

/// message : "Favorites fetched"
/// favorites : [{"_id":"691c5b902d1cd8e65a413a61","userId":"6919c54aa5c283182c4de7b5","bookId":{"_id":"691a468ba5c283182c4de7de","name":"Book Example 222","categoryId":"6919d302a5c283182c4de7c5","mainImage":"https://onlinelibrary-production.up.railway.app/uploads/books/69174062c824bbdb62ac1cf1.png","gallery":["https://onlinelibrary-production.up.railway.app/uploads/books/gallery/69174062c824bbdb62ac1cf1.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-16T21:47:55.200Z","updatedAt":"2025-11-16T21:47:55.200Z","__v":0},"createdAt":"2025-11-18T11:42:08.597Z","updatedAt":"2025-11-18T11:42:08.597Z","__v":0}]

class Data {
  Data({
      this.message, 
      this.favorites,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    if (json['favorites'] != null) {
      favorites = [];
      json['favorites'].forEach((v) {
        favorites?.add(Favorites.fromJson(v));
      });
    }
  }
  String? message;
  List<Favorites>? favorites;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (favorites != null) {
      map['favorites'] = favorites?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "691c5b902d1cd8e65a413a61"
/// userId : "6919c54aa5c283182c4de7b5"
/// bookId : {"_id":"691a468ba5c283182c4de7de","name":"Book Example 222","categoryId":"6919d302a5c283182c4de7c5","mainImage":"https://onlinelibrary-production.up.railway.app/uploads/books/69174062c824bbdb62ac1cf1.png","gallery":["https://onlinelibrary-production.up.railway.app/uploads/books/gallery/69174062c824bbdb62ac1cf1.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-16T21:47:55.200Z","updatedAt":"2025-11-16T21:47:55.200Z","__v":0}
/// createdAt : "2025-11-18T11:42:08.597Z"
/// updatedAt : "2025-11-18T11:42:08.597Z"
/// __v : 0

class Favorites {
  Favorites({
      this.id, 
      this.userId, 
      this.bookId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Favorites.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    bookId = json['bookId'] != null ? BookId.fromJson(json['bookId']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? userId;
  BookId? bookId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    if (bookId != null) {
      map['bookId'] = bookId?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

/// _id : "691a468ba5c283182c4de7de"
/// name : "Book Example 222"
/// categoryId : "6919d302a5c283182c4de7c5"
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
/// createdAt : "2025-11-16T21:47:55.200Z"
/// updatedAt : "2025-11-16T21:47:55.200Z"
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