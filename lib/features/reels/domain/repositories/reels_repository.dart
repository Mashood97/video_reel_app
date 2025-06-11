import 'package:dartz/dartz.dart';
import 'package:video_reel_app/core/error/response_error.dart';
import 'package:video_reel_app/features/reels/domain/entities/request/fetch_reel_request_entity.dart';
import 'package:video_reel_app/features/reels/domain/entities/response/reel_video_response_entity.dart';

abstract class ReelsRepository {
  Future<Either<ResponseError, ReelVideoWithPaginationResponseEntity>> fetchReelVideos({
    required FetchReelRequestEntity requestParams,
  });
}
