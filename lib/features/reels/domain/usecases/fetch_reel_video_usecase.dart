import 'package:dartz/dartz.dart';
import 'package:video_reel_app/core/error/response_error.dart';
import 'package:video_reel_app/core/usecase/usecase.dart';
import 'package:video_reel_app/features/reels/domain/entities/request/fetch_reel_request_entity.dart';
import 'package:video_reel_app/features/reels/domain/entities/response/reel_video_response_entity.dart';
import 'package:video_reel_app/features/reels/domain/repositories/reels_repository.dart';

class FetchReelVideoUseCase
    implements UseCase<ReelVideoWithPaginationResponseEntity, FetchReelRequestEntity> {
  const FetchReelVideoUseCase({required this.reelsRepository});

  final ReelsRepository reelsRepository;

  @override
  Future<Either<ResponseError, ReelVideoWithPaginationResponseEntity>> call(
    FetchReelRequestEntity params,
  ) async {
    return reelsRepository.fetchReelVideos(
      requestParams: params,
    );
  }
}
