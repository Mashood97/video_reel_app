import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_reel_app/features/reels/domain/entities/request/fetch_reel_request_entity.dart';
import 'package:video_reel_app/features/reels/domain/entities/response/reel_video_response_entity.dart';
import 'package:video_reel_app/features/reels/presentation/manager/reel_video_bloc.dart';
import 'package:video_reel_app/utils/constant/app_constant.dart';
import 'package:video_reel_app/utils/constant/app_snackbar.dart';
import 'package:video_reel_app/utils/dependency_injection/di_container.dart';
import 'package:video_reel_app/utils/theme/themes/text_theme.dart';

class ReelVideoPage extends StatefulWidget {
  const ReelVideoPage({super.key});

  @override
  State<ReelVideoPage> createState() => _ReelVideoPageState();
}

class _ReelVideoPageState extends State<ReelVideoPage> {
  late ReelVideoBloc reelVideoBloc;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    reelVideoBloc = getItInstance.get<ReelVideoBloc>();

    reelVideoBloc.add(
      const FetchReelVideosEvent(
        fetchReelRequestEntity: FetchReelRequestEntity(
          pageSize: 15,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();

    reelVideoBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider.value(
          value: reelVideoBloc,
          child: BlocConsumer<ReelVideoBloc, ReelVideoState>(
            builder: (ctx, state) {
              if (state is ReelVideoLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (state is ReelVideoSuccess) {
                return state.reelVideos.reelVideos.isEmpty
                    ? const Center(
                        child: Text('we are unable to fetch the reels.'),
                      )
                    : PageView.builder(
                        physics: const PageScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) async {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            reelVideoBloc.add(
                              SetControllerAndPlayVideo(index: index),
                            );
                          });
                          if (index >= state.reelVideos.reelVideos.length - 2) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              reelVideoBloc.add(
                                const FetchMoreReelVideosEvent(
                                  fetchReelRequestEntity:
                                      FetchReelRequestEntity(),
                                ),
                              );
                            });
                          }
                        },
                        scrollDirection: Axis.vertical,
                        itemCount: state.reelVideos.reelVideos.length,
                        itemBuilder: (context, index) {
                          return _successItemBuilder(
                            state.reelVideos,
                            index,
                            state.videoPlayerController,
                          );
                        },
                      );
              }

              return state.reelVideos.reelVideos.isEmpty
                  ? const Center(
                      child: Text('we are unable to fetch the reels.'),
                    )
                  : PageView.builder(
                      physics: const PageScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) async {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          reelVideoBloc.add(
                            SetControllerAndPlayVideo(index: index),
                          );
                        });
                        if (index >= state.reelVideos.reelVideos.length - 2) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            reelVideoBloc.add(
                              const FetchMoreReelVideosEvent(
                                fetchReelRequestEntity:
                                    FetchReelRequestEntity(),
                              ),
                            );
                          });
                        }
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: state.reelVideos.reelVideos.length,
                      itemBuilder: (context, index) {
                        return _failureItemBuilder(
                          state.reelVideos,
                          index,
                        );
                      },
                    );
            },
            listener: (ctx, state) {
              if (state is ReelVideoFailure) {
                AppSnackBar().showErrorSnackBar(
                  context: ctx,
                  error: state.errorMessage,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _failureItemBuilder(
    ReelVideoWithPaginationResponseEntity item,
    int index,
  ) {
    return Stack(
      key: ValueKey(item.reelVideos[index].id),
      children: [
        Center(
          child: Image.network(
            item.reelVideos[index].userResponseEntity?.userProfilePicture ?? '',
            errorBuilder: (_, __, ___) => const Icon(
              Icons.error,
              size: 50,
            ),
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool? wasSynchronouslyLoaded) {
              return Padding(
                padding: const EdgeInsets.all(
                  AppConstant.kAppSidePadding,
                ),
                child: child,
              );
            },
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              return Center(child: child);
            },
          ),
        ),

        ..._userDetails(item, index)
      ],
    );
  }

  Widget _successItemBuilder(ReelVideoWithPaginationResponseEntity item,
      int index, VideoPlayerController? controller) {
    return Stack(
      key: ValueKey(item.reelVideos[index].id),
      children: [
        Center(
          child: (item.reelVideos[index].videoUrl == null ||
                  item.reelVideos[index].videoUrl?.isEmpty == true)
              ? Image.network(
                  item.reelVideos[index].userResponseEntity
                          ?.userProfilePicture ??
                      '',
                  frameBuilder: (BuildContext context, Widget child, int? frame,
                      bool? wasSynchronouslyLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(
                        AppConstant.kAppSidePadding,
                      ),
                      child: child,
                    );
                  },
                  loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    return Center(child: child);
                  },
                )
              : controller == null
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : controller.value.isInitialized == true
                      ? AspectRatio(
                          aspectRatio: controller.value.aspectRatio ?? 9 / 16,
                          child: VideoPlayer(
                            controller,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
        ),

        ..._userDetails(item, index)
      ],
    );
  }

  List<Positioned> _userDetails(
    ReelVideoWithPaginationResponseEntity item,
    int index,
  ) {
    return [
      Positioned(
        left: 16,
        top: 0,
        right: 80,
        child: Text(
          'Reels',
          style: context.textTheme.titleLarge,
        ),
      ),
      Positioned(
        left: 16,
        bottom: 20,
        right: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '@${item.reelVideos[index].userResponseEntity?.userName}',
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              '${item.reelVideos[index].title}',
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
      Positioned(
        right: 16,
        bottom: 100,
        child: Column(
          children: [
            _iconWithText(
              Icons.favorite,
              '${item.reelVideos[index].totalLikes}',
            ),
            const SizedBox(height: 16),
            _iconWithText(
              Icons.comment,
              '${item.reelVideos[index].totalComments}',
            ),
            const SizedBox(height: 16),
            _iconWithText(
              Icons.share,
              '${item.reelVideos[index].totalShares}',
            ),
            const SizedBox(height: 16),
            ClipOval(
              child: Image.network(
                item.reelVideos[index].userResponseEntity?.userProfilePicture ??
                    '',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const CircleAvatar();
                },
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _iconWithText(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
