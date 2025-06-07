import 'package:consumer/features/food/domain/entities/address.dart';
import 'package:consumer/features/food/domain/entities/cuisine.dart';
import 'package:equatable/equatable.dart';
import 'package:consumer/core/enums/enums.dart';

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String owner;
  final List<AddressEntity> addresses;
  final String phone;
  final CuisineEntity cuisine;
  final double? rating;
  final List<String>? reviews;
  final List<String>? orders;
  final String logo;
  final List<String> images;
  final bool isOpen;
  final RestaurantStatus status;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.owner,
    required this.addresses,
    required this.phone,
    required this.cuisine,
    this.rating,
    this.reviews,
    this.orders,
    required this.logo,
    required this.images,
    required this.isOpen,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    owner,
    addresses,
    phone,
    cuisine,
    rating,
    reviews,
    orders,
    logo,
    images,
    isOpen,
    status,
  ];

  @override
  String toString() {
    return 'RestaurantEntity(id: $id, name: $name, owner: $owner, addresses: $addresses, phone: $phone, cuisine: $cuisine, rating: $rating, reviews: $reviews, orders: $orders, logo: $logo, images: $images, isOpen: $isOpen, status: $status)';
  }
}
