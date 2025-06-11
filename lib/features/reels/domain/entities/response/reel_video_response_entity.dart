import 'package:equatable/equatable.dart';

class ReelVideoWithPaginationResponseEntity extends Equatable {
  const ReelVideoWithPaginationResponseEntity(
      {required this.reelVideos, required this.paginationResponseEntity});

  final List<ReelVideoResponseEntity> reelVideos;

  final PaginationResponseEntity paginationResponseEntity;

  @override
  List<Object?> get props => [
        reelVideos,
        paginationResponseEntity,
      ];
}

class PaginationResponseEntity extends Equatable {
  const PaginationResponseEntity({
    required this.totalRecords,
    required this.currentPage,
    required this.pageLimit,
  });

  final int? totalRecords;
  final int? currentPage;
  final int? pageLimit;

  @override
  List<Object?> get props => [
        totalRecords,
        currentPage,
        pageLimit,
      ];
}

class ReelVideoResponseEntity extends Equatable {
  const ReelVideoResponseEntity({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
    required this.userResponseEntity,
  });

  final int? id;
  final String? title;
  final String? videoUrl;
  final int? totalLikes;
  final int? totalComments;
  final int? totalShares;
  final UserResponseEntity? userResponseEntity;

  @override
  List<Object?> get props => [
        id,
        title,
        videoUrl,
        totalLikes,
        totalComments,
        totalShares,
        userResponseEntity,
      ];
}

class UserResponseEntity extends Equatable {
  const UserResponseEntity({
    required this.userId,
    required this.userName,
    required this.userFullName,
    required this.userProfilePicture,
  });

  final int? userId;
  final String? userName;
  final String? userFullName;
  final String? userProfilePicture;

  @override
  List<Object?> get props => [
        userId,
        userFullName,
        userName,
        userProfilePicture,
      ];
}
