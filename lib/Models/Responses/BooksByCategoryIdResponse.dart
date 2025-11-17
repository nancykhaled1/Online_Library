/// success : true
/// data : {"message":"Books loaded successfully.","category":{"_id":"6919d302a5c283182c4de7c5","name":"Technology","parentId":"69139771b869ad112d090b78","createdAt":"2025-11-16T13:34:58.950Z","updatedAt":"2025-11-16T13:34:58.950Z","__v":0},"books":[{"_id":"691a468ba5c283182c4de7de","name":"Book Example 222","categoryId":"6919d302a5c283182c4de7c5","mainImage":"https://onlinelibrary-production.up.railway.app/uploads/books/69174062c824bbdb62ac1cf1.png","gallery":["https://onlinelibrary-production.up.railway.app/uploads/books/gallery/69174062c824bbdb62ac1cf1.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-16T21:47:55.200Z","updatedAt":"2025-11-16T21:47:55.200Z","__v":0}]}

class BooksByCategoryIdResponse {
  BooksByCategoryIdResponse({
      this.success, 
      this.data,});

  BooksByCategoryIdResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
  bool? success;
  HomeData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Books loaded successfully."
/// category : {"_id":"6919d302a5c283182c4de7c5","name":"Technology","parentId":"69139771b869ad112d090b78","createdAt":"2025-11-16T13:34:58.950Z","updatedAt":"2025-11-16T13:34:58.950Z","__v":0}
/// books : [{"_id":"691a468ba5c283182c4de7de","name":"Book Example 222","categoryId":"6919d302a5c283182c4de7c5","mainImage":"https://onlinelibrary-production.up.railway.app/uploads/books/69174062c824bbdb62ac1cf1.png","gallery":["https://onlinelibrary-production.up.railway.app/uploads/books/gallery/69174062c824bbdb62ac1cf1.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-16T21:47:55.200Z","updatedAt":"2025-11-16T21:47:55.200Z","__v":0}]

class HomeData {
  HomeData({
      this.message, 
      this.category, 
      this.books,});

  HomeData.fromJson(dynamic json) {
    message = json['message'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['books'] != null) {
      books = [];
      json['books'].forEach((v) {
        books?.add(BooksByCategoryId.fromJson(v));
      });
    }
  }
  String? message;
  Category? category;
  List<BooksByCategoryId>? books;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (books != null) {
      map['books'] = books?.map((v) => v.toJson()).toList();
    }
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

class BooksByCategoryId {
  BooksByCategoryId({
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

  BooksByCategoryId.fromJson(dynamic json) {
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

/// _id : "6919d302a5c283182c4de7c5"
/// name : "Technology"
/// parentId : "69139771b869ad112d090b78"
/// createdAt : "2025-11-16T13:34:58.950Z"
/// updatedAt : "2025-11-16T13:34:58.950Z"
/// __v : 0

class Category {
  Category({
      this.id, 
      this.name, 
      this.parentId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Category.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    parentId = json['parentId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? parentId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['parentId'] = parentId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}