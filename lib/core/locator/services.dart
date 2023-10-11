import 'package:clean_architecture/tvs/data/data%20source/remote/remotedatasource.dart';
import 'package:clean_architecture/tvs/data/repository/movies_repoistory.dart';
import 'package:clean_architecture/tvs/domain/repository/base_movies_repositroy.dart';
import 'package:clean_architecture/tvs/domain/usecases/movie_details.dart';
import 'package:clean_architecture/tvs/domain/usecases/now_playing.dart';
import 'package:clean_architecture/tvs/domain/usecases/popular_movies.dart';
import 'package:clean_architecture/tvs/domain/usecases/similar_movies.dart';
import 'package:clean_architecture/tvs/domain/usecases/top_rated.dart';
import 'package:clean_architecture/tvs/presentation/controller/bloc/movie_details_bloc.dart';
import 'package:clean_architecture/tvs/presentation/controller/movies_bloc.dart';
import 'package:clean_architecture/tvs/presentation/provider/movie_provider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    //// Bloc
    sl.registerFactory(() => MoviesBloc(sl(), sl(), sl(), sl()));

    sl.registerFactory(() => MovieDetailsBloc(sl(), sl()));
    //// UseCases
    sl.registerLazySingleton<NowPlayingUsecase>(() => NowPlayingUsecase(sl()));
    sl.registerLazySingleton<TopRatedUsecase>(() => TopRatedUsecase(sl()));
    sl.registerLazySingleton<MoiveDetailsUsecase>(
        () => MoiveDetailsUsecase(sl()));
    sl.registerLazySingleton<PopularMoviesUsecase>(
        () => PopularMoviesUsecase(sl()));
    sl.registerLazySingleton<SimilarMoviesUsecase>(
        () => SimilarMoviesUsecase(sl()));
    //// Provider

    sl.registerFactory(() => MovieProvider(
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
        ));

    //// Repository
    sl.registerLazySingleton<BaseMoviesRepo>(() => MoviesRepository(sl()));

    //// Data Source
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());
  }
}
