import 'package:equatable/equatable.dart';
import 'package:consumer/core/enums/enums.dart';

class AddressEntity extends Equatable {
  final String id;
  final AddressLabel label;
  final String street;
  final String city;
  final String state;
  final String? zipCode;
  final String country;
  final List<double> coordinates;
  final bool isDefault;

  const AddressEntity({
    required this.id,
    required this.label,
    required this.street,
    required this.city,
    required this.state,
    this.zipCode,
    required this.country,
    required this.coordinates,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [
    id,
    label,
    street,
    city,
    state,
    zipCode,
    country,
    coordinates,
    isDefault,
  ];

  @override
  String toString() {
    return 'AddressEntity(id: $id, label: $label, street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country, coordinates: $coordinates, isDefault: $isDefault)';
  }
}
