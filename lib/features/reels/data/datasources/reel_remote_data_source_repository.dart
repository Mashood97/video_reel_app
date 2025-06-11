import 'package:video_reel_app/features/reels/data/models/request/reel_video_request_model.dart';
import 'package:video_reel_app/features/reels/data/models/response/reel_video_response_model.dart';

abstract class ReelRemoteDataSourceRepository {
  Future<ReelVideoWithPaginationResponseModel> fetchReelFromServer({
    required ReelVideoRequestModel requestParams,
  });
}
