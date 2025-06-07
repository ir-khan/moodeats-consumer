abstract class DataState<T> {
  final Map<String, dynamic> data;
  final String error;

  DataState({this.data = const {}, this.error = ''});
}

class DataSuccess<T> extends DataState<T> {
  final int statusCode;
  final String message;
  final bool success;
  final T? extractedData;

  DataSuccess({
    required this.statusCode,
    required this.message,
    required super.data,
    required this.success,
    this.extractedData,
  });

  factory DataSuccess.fromJson(
    Map<String, dynamic> json,
    String? key,
    T Function(Map<String, dynamic>)
    fromJsonT,
  ) {
    final extracted =
        (json['data'] != null && json['data'][key] is Map<String, dynamic>)
            ? fromJsonT(json['data'][key] as Map<String, dynamic>)
            : null;

    return DataSuccess(
      statusCode: json['statusCode'] ?? 200,
      message: json['message'] ?? 'Success',
      data: json['data'] ?? {},
      success: json['success'] ?? true,
      extractedData: extracted,
    );
  }

  @override
  String toString() =>
      'DataSuccess(statusCode: $statusCode, message: $message, data: $data, success: $success, extractedData: $extractedData)';
}

class DataFailure<T> extends DataState<T> {
  final int statusCode;

  DataFailure({
    this.statusCode = 0,
    super.error = 'Sorry, an unexpected error occurred.',
  });

  @override
  String toString() => 'DataFailure(statusCode: $statusCode, message: $error)';
}
