

import 'package:consumer/core/enums/enums.dart';
import 'package:consumer/features/food/data/models/address_model.dart';
import 'package:consumer/features/food/data/models/cuisine_model.dart';
import 'package:consumer/features/food/domain/entities/restaurant.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.owner,
    required super.addresses,
    required super.phone,
    required super.cuisine,
    super.rating,
    super.reviews,
    super.orders,
    required super.logo,
    required super.images,
    required super.isOpen,
    required super.status,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      owner: json['owner']?.toString() ?? '',
      addresses:
          (json['addresses'] as List? ?? []).map((a) {
            if (a is String) {
              return AddressModel(
                id: a,
                label: AddressLabel.other,
                street: '',
                city: '',
                state: '',
                country: '',
                coordinates: [],
                isDefault: false,
              );
            }
            return AddressModel.fromJson(a);
          }).toList(),
      phone: json['phone']?.toString() ?? '',
      cuisine:
          json['cuisine'] is String
              ? CuisineModel(
                id: json['cuisine'],
                name: '',
                value: '',
                image: '',
              )
              : CuisineModel.fromJson(json['cuisine']),
      rating: (json['rating'] as num?)?.toDouble(),
      reviews: List<String>.from(json['reviews'] ?? []),
      orders: List<String>.from(json['orders'] ?? []),
      logo: json['logo']?.toString() ?? '',
      images: List<String>.from(json['images'] ?? []),
      isOpen: json['isOpen'] as bool? ?? true,
      status: RestaurantStatusExtension.fromString(
        json['status']?.toString() ?? '',
      ),
    );
  }

  static RestaurantModel empty(String id) => RestaurantModel(
    id: id,
    name: '',
    owner: '',
    addresses: const [],
    phone: '',
    cuisine: const CuisineModel(id: '', name: '', value: '', image: ''),
    logo: '',
    images: const [],
    isOpen: true,
    status: RestaurantStatus.pending,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'owner': owner,
    'addresses': addresses.map((a) => a.id).toList(),
    'phone': phone,
    'cuisine': cuisine.id,
    'rating': rating,
    'reviews': reviews,
    'orders': orders,
    'logo': logo,
    'images': images,
    'isOpen': isOpen,
    'status': status.value,
  };

  RestaurantModel copyWith({
    String? id,
    String? name,
    String? owner,
    List<AddressModel>? addresses,
    String? phone,
    CuisineModel? cuisine,
    double? rating,
    List<String>? reviews,
    List<String>? orders,
    String? logo,
    List<String>? images,
    bool? isOpen,
    RestaurantStatus? status,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      addresses: addresses ?? this.addresses,
      phone: phone ?? this.phone,
      cuisine: cuisine ?? (this.cuisine as CuisineModel).copyWith(),
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      orders: orders ?? this.orders,
      logo: logo ?? this.logo,
      images: images ?? this.images,
      isOpen: isOpen ?? this.isOpen,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'RestaurantModel(id: $id, name: $name, owner: $owner, phone: $phone, isOpen: $isOpen, status: $status)';
  }
}
