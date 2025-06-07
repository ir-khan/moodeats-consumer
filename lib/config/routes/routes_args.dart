import 'dart:convert';

class OtpArgs {
  final String phone;
  final bool fromRegister;

  const OtpArgs({required this.phone, required this.fromRegister});

  /// Convert from JSON
  factory OtpArgs.fromJson(Map<String, dynamic> json) {
    return OtpArgs(
      phone: json['phone'] as String,
      fromRegister: json['fromRegister'] as bool,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {'phone': phone, 'fromRegister': fromRegister};
  }

  /// Convert object to JSON string
  String toJsonString() => jsonEncode(toJson());

  /// Create object from JSON string
  factory OtpArgs.fromJsonString(String jsonString) {
    return OtpArgs.fromJson(jsonDecode(jsonString));
  }
}
