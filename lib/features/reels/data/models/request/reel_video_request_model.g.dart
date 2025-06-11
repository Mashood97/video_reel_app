// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_video_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReelVideoRequestModel _$ReelVideoRequestModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ReelVideoRequestModel',
      json,
      ($checkedConvert) {
        final val = ReelVideoRequestModel(
          reelPageNumber:
              $checkedConvert('page', (v) => (v as num?)?.toInt() ?? 1),
          reelPageSize:
              $checkedConvert('limit', (v) => (v as num?)?.toInt() ?? 10),
        );
        return val;
      },
      fieldKeyMap: const {'reelPageNumber': 'page', 'reelPageSize': 'limit'},
    );

Map<String, dynamic> _$ReelVideoRequestModelToJson(
        ReelVideoRequestModel instance) =>
    <String, dynamic>{
      'page': instance.reelPageNumber,
      'limit': instance.reelPageSize,
    };
