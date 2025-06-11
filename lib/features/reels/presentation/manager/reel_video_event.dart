part of 'reel_video_bloc.dart';

sealed class ReelVideoEvent extends Equatable {
  const ReelVideoEvent();
}

final class FetchReelVideosEvent extends ReelVideoEvent {
  const FetchReelVideosEvent({
    required this.fetchReelRequestEntity,
  });

  final FetchReelRequestEntity fetchReelRequestEntity;

  @override
  List<Object?> get props => [
        fetchReelRequestEntity,
      ];
}

final class SetControllerAndPlayVideo extends ReelVideoEvent {
  const SetControllerAndPlayVideo({required this.index});

  final int index;

  @override
  List<Object?> get props => [
        index,
      ];
}

class FetchMoreReelVideosEvent extends ReelVideoEvent {
  const FetchMoreReelVideosEvent({required this.fetchReelRequestEntity});

  final FetchReelRequestEntity fetchReelRequestEntity;

  @override
  List<Object?> get props => [fetchReelRequestEntity];
}
