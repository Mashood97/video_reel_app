import 'package:equatable/equatable.dart';

class FetchReelRequestEntity extends Equatable {
  const FetchReelRequestEntity({
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  final int pageNumber;
  final int pageSize;

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
      ];
}
