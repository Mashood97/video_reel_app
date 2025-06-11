import 'package:http/http.dart' as http;
import 'package:video_reel_app/core/error/response_error.dart';
import 'package:video_reel_app/core/platform/network_information.dart';
import 'package:video_reel_app/utils/constant/api_routes.dart';

enum RequestMethod { get, post, delete, put }

class AppHttp {
  AppHttp({
    required this.networkInfo,
  });

  final NetworkInfo networkInfo;

  Future<http.Response> request({
    required String requestPath,
    required dynamic body,
    RequestMethod requestMethod = RequestMethod.get,
  }) async {
    if (await networkInfo.isConnected) {
      switch (requestMethod) {
        case RequestMethod.get:
          try {
            final params = (body as Map<String, dynamic>).map((key, value) {
              if (value is Iterable) {
                return MapEntry(key, value.map((e) => e.toString()).toList());
              } else {
                return MapEntry(key, value.toString());
              }
            });
            final url = Uri.https(ApiRoutes.kBaseUrl, requestPath, params);
            print('API:  REQUEST METHOD:$requestMethod, URL: $url ');
            final result = await http.get(url, headers: {});
            return result;
          } catch (e) {
            throw ResponseError(
              errorStatus: e.toString(),
            );
          }

        case RequestMethod.post:
          try {
            final url = Uri.https(ApiRoutes.kBaseUrl, requestPath);
            final result = await http.post(url, body: body, headers: {});
            return result;
          } catch (e) {
            throw ResponseError(
              errorStatus: e.toString(),
            );
          }

        case RequestMethod.delete:
          try {
            final url = Uri.https(ApiRoutes.kBaseUrl, requestPath);
            final result = await http.delete(url, body: body, headers: {});
            return result;
          } catch (e) {
            throw ResponseError(
              errorStatus: e.toString(),
            );
          }

        case RequestMethod.put:
          try {
            final url = Uri.https(ApiRoutes.kBaseUrl, requestPath);
            final result = await http.put(url, body: body, headers: {});
            return result;
          } catch (e) {
            throw ResponseError(
              errorStatus: e.toString(),
            );
          }
      }
    } else {
      throw const ResponseError(
        errorStatus: 'There is no internet connection, please try again later',
      );
    }
  }
}
