import 'package:clean_architecture/core/network/error_message.dart';

class ServerException implements Exception {
  final ErrorMessage errorMessage;

  ServerException({required this.errorMessage});
}
