import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:video_reel_app/core/error/response_error.dart';
import 'package:video_reel_app/utils/http/response_handler/base_response_handler.dart';

@JsonSerializable(genericArgumentFactories: true)
class MapResponseHandler<T> extends BaseResponse {

  MapResponseHandler({
    super.message,
    super.code,
    required this.response,
  });

  factory MapResponseHandler.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    try {
      final dynamic rawResponse = json['data'];

      T parsedResponse;
      if (rawResponse == null || rawResponse is List) {
        parsedResponse = fromJsonT({});
      } else if (rawResponse is Map<String, dynamic>) {
        parsedResponse = fromJsonT(rawResponse);
      } else {
        throw ResponseError(
          errorStatus: 'Unexpected response type: ${rawResponse.runtimeType}',
        );
      }

      return MapResponseHandler<T>(
        message: json['message'] as String?,
        code: json['statusCode'] as int? ?? json['code'] as int?,
        response: parsedResponse,
      );
    } catch (e) {
      log(
        '====>>> Parsing Issue in MapResponseHandler.fromJson: $e \n====>>> Raw JSON: $json',
        level: 1000,
      );
      throw ResponseError(
        errorStatus: 'Failed to parse map response: ${e.toString()}',
      );
    }
  }
  final T response;
}
