class ErrorModelException implements Exception {
  final String errorMessage;

  ErrorModelException({required this.errorMessage});

  factory ErrorModelException.fromJson(String json) {
    return ErrorModelException(errorMessage: json);
  }
}
class SiginGoogleException implements Exception {}

class ServerException implements Exception {}

class ConnectionTimeoutException implements Exception {}

class UnauthorizedException implements Exception {}

class InternetException implements Exception {}
