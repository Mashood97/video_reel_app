import 'package:json_annotation/json_annotation.dart';
import 'package:video_reel_app/features/reels/domain/entities/response/reel_video_response_entity.dart';

part 'reel_video_response_model.g.dart';

@JsonSerializable(
  checked: true,
)
class ReelVideoWithPaginationResponseModel
    extends ReelVideoWithPaginationResponseEntity {
  const ReelVideoWithPaginationResponseModel({
    required this.reelVideos,
    required this.paginationResponseModel,
  }) : super(
          reelVideos: reelVideos,
          paginationResponseEntity: paginationResponseModel,
        );


  factory ReelVideoWithPaginationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReelVideoWithPaginationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelVideoWithPaginationResponseModelToJson(this);

  @override
  @JsonKey(name: 'data')
  final List<ReelVideoResponseModel> reelVideos;
  @JsonKey(name: 'meta_data')
  final PaginationResponseModel paginationResponseModel;
}

@JsonSerializable(checked: true)
class PaginationResponseModel extends PaginationResponseEntity {
  const PaginationResponseModel(
      {required this.paginateTotalRecords,
      required this.paginateCurrentPage,
      required this.paginatePageLimit})
      : super(
          currentPage: paginateCurrentPage,
          pageLimit: paginatePageLimit,
          totalRecords: paginateTotalRecords,
        );

  factory PaginationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationResponseModelToJson(this);

  @JsonKey(name: "total")
  final int? paginateTotalRecords;

  @JsonKey(name: "page")
  final int? paginateCurrentPage;

  @JsonKey(name: "limit")
  final int? paginatePageLimit;


}

@JsonSerializable(
  checked: true,
)
class ReelVideoResponseModel extends ReelVideoResponseEntity {
  const ReelVideoResponseModel(
      {required this.reelId,
      required this.reelTitle,
      required this.reelTotalComments,
      required this.reelTotalLikes,
      required this.reelTotalShares,
      required this.reelVideoUrl,
      required this.reelUerResponseModel})
      : super(
          id: reelId,
          title: reelTitle,
          totalComments: reelTotalComments,
          totalLikes: reelTotalLikes,
          totalShares: reelTotalShares,
          videoUrl: reelVideoUrl,
          userResponseEntity: reelUerResponseModel,
        );

  factory ReelVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReelVideoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelVideoResponseModelToJson(this);

  @JsonKey(name: 'id')
  final int? reelId;
  @JsonKey(name: 'title')
  final String? reelTitle;
  @JsonKey(name: 'cdn_url')
  final String? reelVideoUrl;
  @JsonKey(name: 'total_likes')
  final int? reelTotalLikes;
  @JsonKey(name: 'total_comments')
  final int? reelTotalComments;
  @JsonKey(name: 'total_share')
  final int? reelTotalShares;
  @JsonKey(name: 'user')
  final UserResponseModel? reelUerResponseModel;
}

@JsonSerializable(
  checked: true,
)
class UserResponseModel extends UserResponseEntity {
  const UserResponseModel({
    required this.reelUserFullName,
    required this.reelUserId,
    required this.reelUserName,
    required this.reelUserProfilePicture,
  }) : super(
          userFullName: reelUserFullName,
          userId: reelUserId,
          userName: reelUserName,
          userProfilePicture: reelUserProfilePicture,
        );

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

  @JsonKey(name: 'user_id')
  final int? reelUserId;
  @JsonKey(name: 'username')
  final String? reelUserName;
  @JsonKey(name: 'fullname')
  final String? reelUserFullName;
  @JsonKey(name: 'profile_picture')
  final String? reelUserProfilePicture;
}
