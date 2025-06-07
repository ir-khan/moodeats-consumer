class AppException implements Exception {
  final String message;
  final String? details;

  AppException(this.message, {this.details});

  @override
  String toString() => "$message${details != null ? ' - $details' : ''}";
}

// Specific exceptions
class NetworkException extends AppException {
  NetworkException([super.message = "Network error occurred"]);
}

class ServerException extends AppException {
  ServerException([super.message = "Server error occurred"]);
}

class CacheException extends AppException {
  CacheException([super.message = "Cache error occurred"]);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = "Unauthorized access"]);
}

class TimeoutException extends AppException {
  TimeoutException([super.message = "Request timed out"]);
}

class BadRequestException extends AppException {
  BadRequestException([super.message = "Invalid request"]);
}

class ForbiddenException extends AppException {
  ForbiddenException([super.message = "Access denied"]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message = "Requested data not found"]);
}

class ConflictException extends AppException {
  ConflictException([super.message = "Conflict occurred"]);
}

class InternalException extends AppException {
  InternalException([super.message = "An internal error occurred"]);
}

class ValidationException extends AppException {
  ValidationException([super.message = "Invalid input"]);
}

// Exception Handler
class ExceptionHandler {
  static String handleException(Exception e) {
    if (e is NetworkException) {
      return "Please check your internet connection.";
    } else if (e is ServerException) {
      return "Something went wrong on the server. Please try again later.";
    } else if (e is CacheException) {
      return "Failed to retrieve data. Please restart the app.";
    } else if (e is UnauthorizedException) {
      return "You are not authorized. Please log in again.";
    } else if (e is TimeoutException) {
      return "Request timed out. Please try again.";
    } else if (e is BadRequestException) {
      return "Invalid request. Please check your input.";
    } else if (e is ForbiddenException) {
      return "Access denied. You do not have permission.";
    } else if (e is NotFoundException) {
      return "Requested data not found.";
    } else if (e is ConflictException) {
      return "A conflict occurred. Please try again.";
    } else if (e is InternalException) {
      return "An internal error occurred. Please restart the app.";
    } else if (e is ValidationException) {
      return "Invalid input. Please correct your data.";
    } else if (e is AppException) {
      return e.message;
    } else {
      return "An unexpected error occurred. Please try again.";
    }
  }
}
