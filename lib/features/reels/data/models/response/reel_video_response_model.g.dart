// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_video_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReelVideoWithPaginationResponseModel
    _$ReelVideoWithPaginationResponseModelFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          'ReelVideoWithPaginationResponseModel',
          json,
          ($checkedConvert) {
            final val = ReelVideoWithPaginationResponseModel(
              reelVideos: $checkedConvert(
                  'data',
                  (v) => (v as List<dynamic>)
                      .map((e) => ReelVideoResponseModel.fromJson(
                          e as Map<String, dynamic>))
                      .toList()),
              paginationResponseModel: $checkedConvert(
                  'meta_data',
                  (v) => PaginationResponseModel.fromJson(
                      v as Map<String, dynamic>)),
            );
            return val;
          },
          fieldKeyMap: const {
            'reelVideos': 'data',
            'paginationResponseModel': 'meta_data'
          },
        );

Map<String, dynamic> _$ReelVideoWithPaginationResponseModelToJson(
        ReelVideoWithPaginationResponseModel instance) =>
    <String, dynamic>{
      'data': instance.reelVideos,
      'meta_data': instance.paginationResponseModel,
    };

PaginationResponseModel _$PaginationResponseModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginationResponseModel',
      json,
      ($checkedConvert) {
        final val = PaginationResponseModel(
          paginateTotalRecords:
              $checkedConvert('total', (v) => (v as num?)?.toInt()),
          paginateCurrentPage:
              $checkedConvert('page', (v) => (v as num?)?.toInt()),
          paginatePageLimit:
              $checkedConvert('limit', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'paginateTotalRecords': 'total',
        'paginateCurrentPage': 'page',
        'paginatePageLimit': 'limit'
      },
    );

Map<String, dynamic> _$PaginationResponseModelToJson(
        PaginationResponseModel instance) =>
    <String, dynamic>{
      'total': instance.paginateTotalRecords,
      'page': instance.paginateCurrentPage,
      'limit': instance.paginatePageLimit,
    };

ReelVideoResponseModel _$ReelVideoResponseModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ReelVideoResponseModel',
      json,
      ($checkedConvert) {
        final val = ReelVideoResponseModel(
          reelId: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          reelTitle: $checkedConvert('title', (v) => v as String?),
          reelTotalComments:
              $checkedConvert('total_comments', (v) => (v as num?)?.toInt()),
          reelTotalLikes:
              $checkedConvert('total_likes', (v) => (v as num?)?.toInt()),
          reelTotalShares:
              $checkedConvert('total_share', (v) => (v as num?)?.toInt()),
          reelVideoUrl: $checkedConvert('cdn_url', (v) => v as String?),
          reelUerResponseModel: $checkedConvert(
              'user',
              (v) => v == null
                  ? null
                  : UserResponseModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'reelId': 'id',
        'reelTitle': 'title',
        'reelTotalComments': 'total_comments',
        'reelTotalLikes': 'total_likes',
        'reelTotalShares': 'total_share',
        'reelVideoUrl': 'cdn_url',
        'reelUerResponseModel': 'user'
      },
    );

Map<String, dynamic> _$ReelVideoResponseModelToJson(
        ReelVideoResponseModel instance) =>
    <String, dynamic>{
      'id': instance.reelId,
      'title': instance.reelTitle,
      'cdn_url': instance.reelVideoUrl,
      'total_likes': instance.reelTotalLikes,
      'total_comments': instance.reelTotalComments,
      'total_share': instance.reelTotalShares,
      'user': instance.reelUerResponseModel,
    };

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserResponseModel',
      json,
      ($checkedConvert) {
        final val = UserResponseModel(
          reelUserFullName: $checkedConvert('fullname', (v) => v as String?),
          reelUserId: $checkedConvert('user_id', (v) => (v as num?)?.toInt()),
          reelUserName: $checkedConvert('username', (v) => v as String?),
          reelUserProfilePicture:
              $checkedConvert('profile_picture', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'reelUserFullName': 'fullname',
        'reelUserId': 'user_id',
        'reelUserName': 'username',
        'reelUserProfilePicture': 'profile_picture'
      },
    );

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      'user_id': instance.reelUserId,
      'username': instance.reelUserName,
      'fullname': instance.reelUserFullName,
      'profile_picture': instance.reelUserProfilePicture,
    };
