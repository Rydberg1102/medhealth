import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String category;
  String image;
  bool status;

  Todo({
    required this.category,
    required this.image,
    required this.status,
  });

  Todo.fromJson(Map<String, Object?> json)
      : this(
          category: json['category']! as String,
          image: json['image']! as String,
          status: json['status']! as bool,
        );

  Todo copyWith({
    String? category,
    String? image,
    bool? status,
  }) {
    return Todo(
        category: category ?? this.category,
        image: image ?? this.image,
        status: status ?? this.status);
  }

  Map<String, Object?> toJson() {
    return {
      'category': category,
      'image': image,
      'status': status,
    };
  }
}
