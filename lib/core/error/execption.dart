class GeneralException implements Exception {
  final String message;

  GeneralException(this.message);
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class StatusCodeException implements Exception {
  final String message;

  StatusCodeException(this.message);
}

class EmptyException implements Exception {
  final String message;

  EmptyException(this.message);
}
