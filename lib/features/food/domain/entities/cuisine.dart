import 'package:equatable/equatable.dart';

class CuisineEntity extends Equatable {
  final String id;
  final String name;
  final String value;
  final String image;

  const CuisineEntity({
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
    return 'CuisineEntity(id: $id, name: $name, value: $value, image: $image)';
  }
}
