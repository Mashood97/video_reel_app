import 'package:json_annotation/json_annotation.dart';
import 'package:video_reel_app/features/reels/domain/entities/request/fetch_reel_request_entity.dart';

part 'reel_video_request_model.g.dart';

@JsonSerializable(checked: true)
class ReelVideoRequestModel extends FetchReelRequestEntity {
  const ReelVideoRequestModel({this.reelPageNumber = 1, this.reelPageSize = 10})
      : super(
          pageNumber: reelPageNumber,
          pageSize: reelPageSize,
        );

  factory ReelVideoRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReelVideoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelVideoRequestModelToJson(this);

  @JsonKey(name: 'page')
  final int reelPageNumber;
  @JsonKey(name: 'limit')
  final int reelPageSize;
}
