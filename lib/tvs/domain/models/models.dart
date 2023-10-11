class Movie {
  final int id;
  final String title;
  final String overview;
  final String imageUrl;
  final String releaseDate;
  final bool adult;
  final num voteAverage;
  final int voteCount;
  final String language;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.imageUrl,
    required this.releaseDate,
    required this.adult,
    required this.voteAverage,
    required this.voteCount,
    required this.language,
  });
}

class MovieDetaillls {
  final int id;
  final String title;
  final String overview;
  final String imageUrl;
  final String releaseDate;
  final num voteAverage;
  final List<String> genres;
  final int runtime;
  final String status;

  MovieDetaillls({
    required this.id,
    required this.title,
    required this.overview,
    required this.imageUrl,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
    required this.runtime,
    required this.status,
  });
}
