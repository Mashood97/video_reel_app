import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:get_it/get_it.dart';
import 'package:video_reel_app/core/platform/network_information.dart';
import 'package:video_reel_app/features/reels/data/datasources/reel_remote_data_source_repository.dart';
import 'package:video_reel_app/features/reels/data/datasources/reel_remote_data_source_repository_implementation.dart';
import 'package:video_reel_app/features/reels/data/repositories/reel_repository_implementation.dart';
import 'package:video_reel_app/features/reels/domain/repositories/reels_repository.dart';
import 'package:video_reel_app/features/reels/domain/usecases/fetch_reel_video_usecase.dart';
import 'package:video_reel_app/features/reels/presentation/manager/reel_video_bloc.dart';
import 'package:video_reel_app/utils/http/app_http.dart';
import 'package:video_reel_app/utils/internet_checker/network_bloc.dart';
import 'package:video_reel_app/utils/theme/cubit/cubit/theme_cubit.dart';

final getItInstance = GetIt.instance;

void initializeDependencies() {
  _initializeBlocsAndCubits();
  _initializeRepositories();
  _initializeUseCases();
  _initializeExternalPackages();
}

void _initializeBlocsAndCubits() {
  getItInstance
    ..registerLazySingleton(
      NetworkBloc.new,
    )
    ..registerLazySingleton(
      ThemeCubit.new,
    )
    ..registerFactory<ReelVideoBloc>(
      () => ReelVideoBloc(
        fetchReelVideoUseCase: getItInstance(),
      ),
    );
}

void _initializeRepositories() {
  getItInstance
    ..registerLazySingleton<ReelsRepository>(
      () => ReelRepositoryImplementation(
        reelRemoteDataSourceRepository: getItInstance(),
      ),
    )
    ..registerLazySingleton<ReelRemoteDataSourceRepository>(
      () => ReelRemoteDataSourceRepositoryImplementation(
        appHttp: getItInstance(),
      ),
    );
}

void _initializeUseCases() {
  getItInstance.registerLazySingleton<FetchReelVideoUseCase>(
    () => FetchReelVideoUseCase(
      reelsRepository: getItInstance(),
    ),
  );
}

void _initializeExternalPackages() {
  getItInstance
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        networkConnectionCheck: getItInstance(),
      ),
    )
    ..registerLazySingleton(Connectivity.new)
    ..registerLazySingleton(
      () => AppHttp(
        networkInfo: getItInstance(),
      ),
    );
}
