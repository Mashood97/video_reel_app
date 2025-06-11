import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:video_reel_app/core/error/response_error.dart';
import 'package:video_reel_app/features/reels/data/datasources/reel_remote_data_source_repository.dart';
import 'package:video_reel_app/features/reels/data/models/request/reel_video_request_model.dart';
import 'package:video_reel_app/features/reels/domain/entities/request/fetch_reel_request_entity.dart';
import 'package:video_reel_app/features/reels/domain/entities/response/reel_video_response_entity.dart';
import 'package:video_reel_app/features/reels/domain/repositories/reels_repository.dart';

class ReelRepositoryImplementation implements ReelsRepository {
  ReelRepositoryImplementation({
    required this.reelRemoteDataSourceRepository,
  });

  final ReelRemoteDataSourceRepository reelRemoteDataSourceRepository;

  @override
  Future<Either<ResponseError, ReelVideoWithPaginationResponseEntity>>
      fetchReelVideos({
    required FetchReelRequestEntity requestParams,
  }) async {
    try {
      final response = await reelRemoteDataSourceRepository.fetchReelFromServer(
        requestParams: ReelVideoRequestModel(
          reelPageNumber: requestParams.pageNumber,
          reelPageSize: requestParams.pageSize,
        ),
      );
      return Right(response);
    } on ResponseError catch (e) {
      if (kDebugMode) {
        print(
          'ERROR ISSS ReelRepositoryImplementation:::fetchReelVideos::: $e',
        );
      }

      return left(e);
    }
  }
}
