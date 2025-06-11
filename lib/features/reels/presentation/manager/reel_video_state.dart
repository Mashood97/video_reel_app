part of 'reel_video_bloc.dart';

sealed class ReelVideoState extends Equatable {
  const ReelVideoState({
    required this.reelVideos,
  });

  final ReelVideoWithPaginationResponseEntity reelVideos;
}

final class ReelVideoInitial extends ReelVideoState {
  const ReelVideoInitial({required super.reelVideos});

  @override
  List<Object> get props => [
        super.reelVideos,
      ];
}

final class ReelVideoLoading extends ReelVideoState {
  const ReelVideoLoading({required super.reelVideos});

  @override
  List<Object> get props => [
        super.reelVideos,
      ];
}

final class ReelVideoSuccess extends ReelVideoState {
  const ReelVideoSuccess({
    required super.reelVideos,
    required this.videoPlayerController,
  });

  final VideoPlayerController? videoPlayerController;

  @override
  List<Object> get props => [
        super.reelVideos,

      ];
}

final class ReelVideoFailure extends ReelVideoState {
  const ReelVideoFailure({
    required super.reelVideos,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [
        super.reelVideos,
        errorMessage,
      ];
}
