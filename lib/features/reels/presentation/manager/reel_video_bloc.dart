import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';
import 'package:video_reel_app/features/reels/domain/entities/request/fetch_reel_request_entity.dart';
import 'package:video_reel_app/features/reels/domain/entities/response/reel_video_response_entity.dart';
import 'package:video_reel_app/features/reels/domain/usecases/fetch_reel_video_usecase.dart';

part 'reel_video_event.dart';

part 'reel_video_state.dart';

class ReelVideoBloc extends Bloc<ReelVideoEvent, ReelVideoState> {
  ReelVideoBloc({
    required this.fetchReelVideoUseCase,
  }) : super(
          const ReelVideoInitial(
            reelVideos: ReelVideoWithPaginationResponseEntity(
              reelVideos: [],
              paginationResponseEntity: PaginationResponseEntity(
                  totalRecords: 0, currentPage: 1, pageLimit: 10),
            ),
          ),
        ) {
    on<FetchReelVideosEvent>(_fetchReelVideos, transformer: droppable());
    on<FetchMoreReelVideosEvent>(
      _fetchMoreReelVideos,
      transformer: droppable(),
    );

    on<SetControllerAndPlayVideo>(
      _initPlayerAndPlayVideo,
    );
  }

  final FetchReelVideoUseCase fetchReelVideoUseCase;
  int currentPage = 0;

  VideoPlayerController? _controller;

  int _controllerSessionId = 0;

  Future<void> _initPlayerAndPlayVideo(
    SetControllerAndPlayVideo event,
    Emitter<ReelVideoState> emitter,
  ) async {
    final int currentSession = ++_controllerSessionId;

    final previousController = _controller;

    final url = state.reelVideos.reelVideos[event.index].videoUrl ?? '';
    if (url.isEmpty) return;

    final newController = VideoPlayerController.networkUrl(Uri.parse(url));

    try {
      await newController.initialize();
      await newController.setLooping(true);

      // If another session started before this finished, discard it
      if (currentSession != _controllerSessionId) {
        await newController.dispose();
        return;
      }

      await previousController?.pause();
      await previousController?.dispose();

      _controller = newController;
      await _controller?.play();

      emitter(ReelVideoLoading(reelVideos: state.reelVideos));
      emitter(ReelVideoSuccess(
        reelVideos: state.reelVideos,
        videoPlayerController: _controller,
      ));
    } catch (e) {
      await newController.dispose();
    }
  }

  Future<void> _fetchReelVideos(
      FetchReelVideosEvent event, Emitter<ReelVideoState> emitter) async {
    emitter(
      ReelVideoLoading(reelVideos: state.reelVideos),
    );
    final response = await fetchReelVideoUseCase.call(
      event.fetchReelRequestEntity,
    );
    response.fold(
      (error) => emitter(
        ReelVideoFailure(
          reelVideos: state.reelVideos,
          errorMessage: error.errorStatus,
        ),
      ),
      (success) async {

        if(success.reelVideos.isEmpty)
          {
            return emitter(
              ReelVideoFailure(
                reelVideos: state.reelVideos,
                errorMessage: "We are unable to fetch the reels.",
              ),
            );
          }

        emitter(
          ReelVideoSuccess(reelVideos: success, videoPlayerController: null),
        );

        add(const SetControllerAndPlayVideo(index: 0));
      },
    );
  }

  Future<void> _fetchMoreReelVideos(
    FetchMoreReelVideosEvent event,
    Emitter<ReelVideoState> emitter,
  ) async {
    final currentReels = state.reelVideos.reelVideos;
    final currentPage = state.reelVideos.paginationResponseEntity.currentPage;
    final totalRecords =
        state.reelVideos.paginationResponseEntity.totalRecords ?? 0;
    final limit = state.reelVideos.paginationResponseEntity.pageLimit;

    // Prevent further API calls if all data is loaded
    if (currentReels.length >= totalRecords) return;

    // emitter(ReelVideoLoading(reelVideos: state.reelVideos));

    final updatedRequest = FetchReelRequestEntity(
      pageNumber: (currentPage ?? 0) + 1,
      pageSize: limit ?? 10,
    );

    final response = await fetchReelVideoUseCase.call(updatedRequest);

    response.fold(
      (error) {
        emitter(
          ReelVideoFailure(
            reelVideos: state.reelVideos,
            errorMessage: error.errorStatus,
          ),
        );
      },
      (newData) {
        emitter(
          ReelVideoSuccess(
            reelVideos: ReelVideoWithPaginationResponseEntity(
              reelVideos: List.from(currentReels)..addAll(newData.reelVideos),
              paginationResponseEntity: newData.paginationResponseEntity,
            ),
            videoPlayerController: _controller,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}
