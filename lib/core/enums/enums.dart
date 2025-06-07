enum ToastType { success, error, info }
enum UserRole { client, owner, driver }

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.client:
        return 'CLIENT';
      case UserRole.owner:
        return 'OWNER';
      case UserRole.driver:
        return 'DRIVER';
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.client:
        return 'Client';
      case UserRole.owner:
        return 'Owner';
      case UserRole.driver:
        return 'Driver';
    }
  }

  static UserRole fromString(String role) {
    switch (role.toUpperCase()) {
      case 'CLIENT':
        return UserRole.client;
      case 'OWNER':
        return UserRole.owner;
      case 'DRIVER':
        return UserRole.driver;
      default:
        throw ArgumentError('Invalid user role: $role');
    }
  }
}

enum RestaurantStatus {
  active,
  pending,
  inactive,
  temporarilyClosed,
  underMaintenance,
  suspended,
}

extension RestaurantStatusExtension on RestaurantStatus {
  String get value {
    switch (this) {
      case RestaurantStatus.active:
        return 'ACTIVE';
      case RestaurantStatus.pending:
        return 'PENDING';
      case RestaurantStatus.inactive:
        return 'INACTIVE';
      case RestaurantStatus.temporarilyClosed:
        return 'TEMPORARILY_CLOSED';
      case RestaurantStatus.underMaintenance:
        return 'UNDER_MAINTENANCE';
      case RestaurantStatus.suspended:
        return 'SUSPENDED';
    }
  }

  String get displayName {
    switch (this) {
      case RestaurantStatus.active:
        return 'Active';
      case RestaurantStatus.pending:
        return 'Pending';
      case RestaurantStatus.inactive:
        return 'Inactive';
      case RestaurantStatus.temporarilyClosed:
        return 'Temporarily Closed';
      case RestaurantStatus.underMaintenance:
        return 'Under Maintenance';
      case RestaurantStatus.suspended:
        return 'Suspended';
    }
  }

  static RestaurantStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return RestaurantStatus.active;
      case 'PENDING':
        return RestaurantStatus.pending;
      case 'INACTIVE':
        return RestaurantStatus.inactive;
      case 'TEMPORARILY_CLOSED':
        return RestaurantStatus.temporarilyClosed;
      case 'UNDER_MAINTENANCE':
        return RestaurantStatus.underMaintenance;
      case 'SUSPENDED':
        return RestaurantStatus.suspended;
      default:
        throw ArgumentError('Invalid restaurant status: $status');
    }
  }
}

enum AddressLabel { home, work, other, restaurant, warehouse }

extension AddressLabelExtension on AddressLabel {
  String get value {
    switch (this) {
      case AddressLabel.home:
        return 'HOME';
      case AddressLabel.work:
        return 'WORK';
      case AddressLabel.other:
        return 'OTHER';
      case AddressLabel.restaurant:
        return 'RESTAURANT';
      case AddressLabel.warehouse:
        return 'WAREHOUSE';
    }
  }

  String get displayName {
    switch (this) {
      case AddressLabel.home:
        return 'Home';
      case AddressLabel.work:
        return 'Work';
      case AddressLabel.other:
        return 'Other';
      case AddressLabel.restaurant:
        return 'Restaurant';
      case AddressLabel.warehouse:
        return 'Warehouse';
    }
  }

  static AddressLabel fromString(String label) {
    switch (label.toUpperCase()) {
      case 'HOME':
        return AddressLabel.home;
      case 'WORK':
        return AddressLabel.work;
      case 'OTHER':
        return AddressLabel.other;
      case 'RESTAURANT':
        return AddressLabel.restaurant;
      case 'WAREHOUSE':
        return AddressLabel.warehouse;
      default:
        throw ArgumentError('Unknown address label: $label');
    }
  }
}
