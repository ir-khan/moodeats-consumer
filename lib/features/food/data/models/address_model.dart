import 'package:consumer/core/enums/enums.dart';
import 'package:consumer/features/food/domain/entities/address.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.label,
    required super.street,
    required super.city,
    required super.state,
    super.zipCode,
    required super.country,
    required super.coordinates,
    required super.isDefault,
  });
  
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    final rawCoords = json['location']?['coordinates'] as List<dynamic>? ?? [];

    return AddressModel(
      id: json['_id']?.toString() ?? '',
      label: AddressLabelExtension.fromString(
        json['label']?.toString() ?? 'OTHER',
      ),
      street: json['street']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      zipCode: json['zipCode']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      coordinates: rawCoords.map((e) => (e as num).toDouble()).toList(),
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'label': label.value,
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'location': {'type': 'Point', 'coordinates': coordinates},
      'isDefault': isDefault,
    };
  }

  AddressModel copyWith({
    String? id,
    AddressLabel? label,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    List<double>? coordinates,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      coordinates: coordinates ?? this.coordinates,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String toString() {
    return 'AddressModel(id: $id, label: $label, street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country, coordinates: $coordinates, isDefault: $isDefault)';
  }
}
