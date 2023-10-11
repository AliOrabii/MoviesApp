class ApiConstance {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static const String nowPlayingMoviesPath =
      '$baseUrl/movie/now_playing?api_key=$apiKey';
  static const String PopularMoviesPath =
      '$baseUrl/movie/popular?api_key=$apiKey';
  static const String TopRatedMoviesPath =
      '$baseUrl/movie/top_rated?api_key=$apiKey';
  static const String apiKey = '89ca817231851c70e6e89cf04c5eff6f';
  static String MovieDetailsPath(int id) =>
      '$baseUrl/movie/$id?api_key=$apiKey';
  static String SimilarMoviePath(int id) =>
      '$baseUrl/movie/$id/similar?api_key=$apiKey';
}
