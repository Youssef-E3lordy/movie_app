class ErrorMessageModel {
  final int statusCode;
  final String statusMessage;
  final bool success;

  ErrorMessageModel({
    required this.statusCode,
    required this.statusMessage,
    required this.success,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      statusCode: json['status_code'] ?? 0,
      statusMessage: json['status_message'] ?? 'Unknown Error occurred',
      success: json['success'] ?? false,
    );
  }
}