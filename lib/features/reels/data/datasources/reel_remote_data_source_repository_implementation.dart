import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:video_reel_app/core/error/response_error.dart';
import 'package:video_reel_app/features/reels/data/datasources/reel_remote_data_source_repository.dart';
import 'package:video_reel_app/features/reels/data/models/request/reel_video_request_model.dart';
import 'package:video_reel_app/features/reels/data/models/response/reel_video_response_model.dart';
import 'package:video_reel_app/utils/constant/api_routes.dart';
import 'package:video_reel_app/utils/http/app_http.dart';
import 'package:video_reel_app/utils/http/response_handler/map_response_handler.dart';

class ReelRemoteDataSourceRepositoryImplementation
    extends ReelRemoteDataSourceRepository {
  ReelRemoteDataSourceRepositoryImplementation({
    required this.appHttp,
  });

  final AppHttp appHttp;

  @override
  Future<ReelVideoWithPaginationResponseModel> fetchReelFromServer({
    required ReelVideoRequestModel requestParams,
  }) async {
    try {
      //When we don't define the request method it's by default get.
      final response = await appHttp.request(
        requestPath: ApiRoutes.fetchReelVideos,
        body: requestParams.toJson(),
        // requestMethod: RequestMethod.get
      );
      if (response.statusCode == 200) {
        final bodyString = response.body;
        if (kDebugMode) {
          print('Fetched Data:::::: $bodyString');
        }
        final decodedJson = jsonDecode(bodyString) as Map<String, dynamic>;

        final result =
            MapResponseHandler<ReelVideoWithPaginationResponseModel>.fromJson(
          decodedJson,
          ReelVideoWithPaginationResponseModel.fromJson,
        ).response;

        return result;
      }

      return const ReelVideoWithPaginationResponseModel(
        reelVideos: [],
        paginationResponseModel: PaginationResponseModel(
            paginateCurrentPage: 1,
            paginatePageLimit: 10,
            paginateTotalRecords: 104),
      );
    } catch (e) {
      if (kDebugMode) {
        print(
          'Error while fetchReelFromServer :: ReelRemoteDataSourceRepositoryImplementation '
          ':::: $e',
        );
      }
      throw const ResponseError(
          errorStatus:
              'We are unable to process the request, please try again later.');
    }
  }
}
