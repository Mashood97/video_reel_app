import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:video_reel_app/core/error/response_error.dart';
import 'package:video_reel_app/utils/http/response_handler/base_response_handler.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> extends BaseResponse {

  ListResponse({
    super.message,
    super.code,
    this.data,
  });

  factory ListResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    try {
      final List<dynamic>? rawList =
      (json['data']) as List<dynamic>?;

      final List<T> parsedList = rawList != null
          ? rawList.map<T>((item) => fromJsonT(item as Map<String, dynamic>)).toList()
          : [];

      return ListResponse<T>(
        message: json['message'] as String?,
        code: json['statusCode'] as int? ?? json['code'] as int?,
        data: parsedList,
      );
    } catch (e) {
      log(
        '====>>> Parsing Issue in ListResponse.fromJson: $e \n====>>> Raw JSON: $json',
        level: 1000,
      );
      throw ResponseError(
        errorStatus: 'Failed to parse list response: ${e.toString()}',
      );
    }
  }
  final List<T>? data;
}
