import 'package:consumer/features/food/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.value,
    required super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'value': value,
    'image': image,
  };

  CategoryModel copyWith({
    String? id,
    String? name,
    String? value,
    String? image,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      image: image ?? this.image,
    );
  }

  @override
  String toString() =>
      'CategoryModel(id: $id, name: $name, value: $value, image: $image)';
}
