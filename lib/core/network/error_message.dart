import 'package:equatable/equatable.dart';

class ErrorMessage extends Equatable {
  final String statusMessage;
  final bool success;
  final int statusCode;

  const ErrorMessage({
    required this.statusMessage,
    required this.statusCode,
    required this.success,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        statusMessage: json['status_message'],
        statusCode: json['status_code'],
        success: json['success'],
      );

  @override
  List<Object?> get props => [statusCode, statusMessage, success];
}
