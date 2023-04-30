import 'dart:developer';

class CustomException implements Exception {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  CustomException({
    this.message = 'Aconteceu um erro inesperado, tente novamente mais tarde!',
    this.error,
    this.stackTrace,
  }) {
    log('$runtimeType => $message', error: error, stackTrace: stackTrace);
  }

  @override
  String toString() {
    return '$message\n$error\n$stackTrace';
  }
}

class RequestedSupportException extends CustomException {
  RequestedSupportException({
    super.message =
        'Aconteceu um erro inesperado. Se persistir busque apoio com o suporte do aplicativo',
    super.error,
    super.stackTrace,
  });
}
