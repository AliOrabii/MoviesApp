import 'dart:convert';

import 'package:clean_architecture/core/locator/services.dart';
import 'package:clean_architecture/tvs/data/data%20source/remote/remotedatasource.dart';
import 'package:clean_architecture/tvs/data/models/movie_model.dart';
import 'package:clean_architecture/tvs/presentation/provider/movie_provider.dart';
import 'package:clean_architecture/tvs/presentation/screens/movie_screen.dart';
import 'package:clean_architecture/tvs/presentation/screens/movies_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() async {
  ServiceLocator().init();
  runApp(const MyApp());
}

Future<List<MovieModel>> getMovies() async {
  try {
    var response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/now_playing'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWNhODE3MjMxODUxYzcwZTZlODljZjA0YzVlZmY2ZiIsInN1YiI6IjY0ZTg4ZjQ1OTBlYTRiMDEzYjgyYzA3NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6Ju_cpvZB7MuYrUkSd5tQGfWYpkMvFAmVbVqTKKwg6A',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> result = json.decode(response.body);
    List<dynamic> list = result['results'];
    List<MovieModel> movies = [];

    list.forEach((element) {
      movies.add(MovieModel.fromJson(element));
    });
    movies.forEach((element) {
      print(element.title);
      print(element.id);
      print(element.overview);
      print(element.releaseDate);
      print(element.adult);
      print(element.voteAverage);
      print(element.voteCount);
      print(element.language);
      print('///////////////////////');
    });
    return movies;
  } on Exception catch (e) {
    return [];
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<MovieProvider>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: MovieScreen(),
      ),
    );
  }
}
