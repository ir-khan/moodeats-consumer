import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String value;
  final String image;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.value,
    required this.image,
  });
  
  @override
  List<Object?> get props => [
    id,
    name,
    value,  
    image,
  ];

  @override
  String toString() {
    return 'CategoryEntity(id: $id, name: $name, value: $value, image: $image)';
  }
}
