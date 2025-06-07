import 'package:consumer/features/food/domain/entities/cuisine.dart';

class CuisineModel extends CuisineEntity {
  const CuisineModel({
    required super.id,
    required super.name,
    required super.value,
    required super.image,
  });

  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
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

  CuisineModel copyWith({
    String? id,
    String? name,
    String? value,
    String? image,
  }) {
    return CuisineModel(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      image: image ?? this.image,
    );
  }

  @override
  String toString() =>
      'CuisineModel(id: $id, name: $name, value: $value, image: $image)';
}
