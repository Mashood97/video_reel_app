class BaseResponse {
  BaseResponse({this.message, this.code});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json['message'] as String?,
      code: json['statusCode'] as int?,
    );
  }

  int? code;
  String? message;
}
