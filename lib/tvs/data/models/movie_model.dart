import 'package:clean_architecture/tvs/domain/models/models.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.imageUrl,
    required super.releaseDate,
    required super.adult,
    required super.voteAverage,
    required super.voteCount,
    required super.language,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        imageUrl: json['backdrop_path'] ?? "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
        releaseDate: json['release_date'],
        adult: json['adult'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        language: json['original_language'],
      );
}

class MovieDetailsModel extends MovieDetaillls {
  MovieDetailsModel(
      {required super.id,
      required super.title,
      required super.overview,
      required super.imageUrl,
      required super.releaseDate,
      required super.voteAverage,
      required super.genres,
      required super.runtime,
      required super.status});

  factory MovieDetailsModel.fromjson(Map<String, dynamic> json) =>
      MovieDetailsModel(
        id: json['id'],
        title: json['original_title'],
        overview: json['overview'],
        imageUrl: json['poster_path'],
        releaseDate: json['release_date'],
        voteAverage: json['vote_average'],
        genres: List<String>.from(json['genres'].map((e) => e['name'])),
        runtime: json['runtime'],
        status: json['status'],
      );
}
