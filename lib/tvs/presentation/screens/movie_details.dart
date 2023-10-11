import 'package:clean_architecture/core/locator/services.dart';
import 'package:clean_architecture/core/network/api_constance.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:clean_architecture/tvs/presentation/controller/bloc/movie_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetails extends StatelessWidget {
  int id;
  MovieDetails({required this.id});

  _getImage({
    required String ImageUrl,
  }) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('${ApiConstance.baseImageUrl}$ImageUrl'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _getMovieTitle({required BuildContext context, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.white, fontSize: 24),
      ),
    );
  }

  _getRow(
      {required String releaseData,
      required num voteAverage,
      required int duration}) {
    int hours = duration ~/ 60;
    int minutes = duration % 60;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        children: [
          Container(
            //width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.all(6),
            child: Text(
              releaseData.split('-').first,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            voteAverage.toStringAsFixed(1),
            style: TextStyle(color: Colors.white),
          ),
          // Todo we add the Duration of the movie..
          SizedBox(
            width: 25,
          ),
          Text(
            '$hours h $minutes min',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  _getOverView({required String overView}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Text(
        overView,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5),
      ),
    );
  }

  _getHeader({required String header}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        header,
        style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5),
      ),
    );
  }

  _getGridView({required List<Movie> movies}) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.6),
          itemCount: movies.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(4),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(
                            '${ApiConstance.baseImageUrl}${movies[index].imageUrl}'),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    movies[index].title,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<MovieDetailsBloc>()
          ..add(GetMovieDetailsEvent(id))
          ..add(GetMovieSimilarEvent(id)),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.grey[900],
          extendBodyBehindAppBar: true,
          body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
            builder: (context, state) {
              switch (state.state) {
                case RequestState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case RequestState.loaded:
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getImage(
                          ImageUrl: state.movieModel!.imageUrl,
                        ),
                        _getMovieTitle(
                            context: context, title: state.movieModel!.title),
                        _getRow(
                            releaseData: state.movieModel!.releaseDate,
                            voteAverage: state.movieModel!.voteAverage,
                            duration: state.movieModel!.runtime),
                        _getOverView(overView: state.movieModel!.overview),
                        _getHeader(header: 'MORE LIKE THIS'),
                        _getGridView(movies: state.similarMovies!),
                      ],
                    ),
                  );
                case RequestState.error:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return Container();
              }
            },
          ),
        ));
  }
}
