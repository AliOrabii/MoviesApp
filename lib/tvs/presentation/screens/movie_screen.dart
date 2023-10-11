import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/locator/services.dart';
import 'package:clean_architecture/core/network/api_constance.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/tvs/data/data%20source/remote/remotedatasource.dart';
import 'package:clean_architecture/tvs/data/repository/movies_repoistory.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:clean_architecture/tvs/domain/repository/base_movies_repositroy.dart';
import 'package:clean_architecture/tvs/domain/usecases/now_playing.dart';
import 'package:clean_architecture/tvs/presentation/controller/movies_bloc.dart';
import 'package:clean_architecture/tvs/presentation/controller/movies_event.dart';
import 'package:clean_architecture/tvs/presentation/controller/movies_states.dart';
import 'package:clean_architecture/tvs/presentation/provider/movie_provider.dart';
import 'package:clean_architecture/tvs/presentation/screens/movie_details.dart';
import 'package:clean_architecture/tvs/presentation/screens/movies_list_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  List<Movie> TopRatedMovies = [];
  List<Movie> PopularMovies = [];
  List<Movie> NowPlayingMovies = [];
  // @override
  getcarosuelItem(context, {required Movie item}) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              id: item.id,
            ),
          )),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      '${ApiConstance.baseImageUrl}${item.imageUrl}'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            color: Colors.black54,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'NOW PLAYING',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getNowPlaying(
    context,
  ) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        switch (state.NowPlayingState) {
          case RequestState.loading:
            return SizedBox(
              height: 400,
              child: Center(child: CircularProgressIndicator()),
            );
          case RequestState.loaded:
            //var NowPlaying = state.NowPlayingMovies;
            return FadeIn(
              duration: const Duration(milliseconds: 3000),
              child: CarouselSlider(
                items: List<Widget>.from(state.NowPlayingMovies.map(
                    (e) => getcarosuelItem(context, item: e))),
                options: CarouselOptions(
                  height: 400,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  //enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 400,
              child: Center(child: Text(state.NowPlayingmessage)),
            );
        }
      },
    );
  }

  getNowPlayingProvider() {
    return Consumer<MovieProvider>(builder: (context, value, _) {
      print('Consumer Build');

      return FutureBuilder<Either<Failure, List<Movie>>>(
          future:
              value.state == ViewState.Success ? null : value.getNowplaying(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError || snapshot.data!.isLeft()) {
              final error = snapshot.error ?? "An error occurred";
              return Text("Error: $error");
            } else {
              final data = snapshot.data!.getOrElse(() => <Movie>[]);
              return FadeIn(
                duration: const Duration(milliseconds: 3000),
                child: CarouselSlider(
                  items: List<Widget>.from(
                      data.map((e) => getcarosuelItem(context, item: e))),
                  options: CarouselOptions(
                    height: 400,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    //enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              );
            }
          });
    });
  }

  getTitleRow(context,
      {required String title,
      required String buttonTitle,
      required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontSize: 18),
          ),
          Spacer(),
          InkWell(
            onTap: onPressed,
            child: Row(
              children: [
                Text(
                  buttonTitle,
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getSmallList({required bool TopRated}) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) {
        if (TopRated) {
          if (previous.TopRatedState != current.TopRatedState) {
            return true;
          }
          return false;
        } else {
          if (previous.PopularState != current.PopularState) {
            return true;
          }
          return false;
        }
      },
      builder: (context, state) {
        if (TopRated) {
          print('BLOC Builder Top Rated ${state.TopRatedState}');
          switch (state.TopRatedState) {
            case RequestState.loading:
              return SizedBox(
                height: 190,
                child: Center(child: CircularProgressIndicator()),
              );
            case RequestState.loaded:
              TopRatedMovies = state.TopRatedMovies;
              return FadeIn(
                duration: Duration(seconds: 3),
                child: Container(
                  height: 190,
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: TopRatedMovies.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetails(
                              id: TopRatedMovies[index].id,
                            ),
                          )),
                      child: SizedBox(
                        width: 130,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${ApiConstance.baseImageUrl}${TopRatedMovies[index].imageUrl}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.black54,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  TopRatedMovies[index].title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            case RequestState.error:
              return SizedBox(
                height: 190,
                child: Center(child: Text(state.TopRatedmessage)),
              );
          }
        } else {
          print('BLOC Builder Popular State${state.PopularState}');
          switch (state.PopularState) {
            case RequestState.loading:
              return SizedBox(
                height: 190,
                child: Center(child: CircularProgressIndicator()),
              );
            case RequestState.loaded:
              PopularMovies = state.PopularMovies;
              return FadeIn(
                duration: Duration(seconds: 3),
                child: Container(
                  height: 190,
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: PopularMovies.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetails(
                              id: PopularMovies[index].id,
                            ),
                          )),
                      child: SizedBox(
                        width: 130,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${ApiConstance.baseImageUrl}${PopularMovies[index].imageUrl}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.black54,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  PopularMovies[index].title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            case RequestState.error:
              return SizedBox(
                height: 190,
                child: Center(child: Text(state.Popularmessage)),
              );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[900],
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movie'),
            BottomNavigationBarItem(
                icon: Icon(Icons.computer), label: 'computer'),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              getNowPlayingProvider(),
              // getNowPlaying(
              //   context,
              // ),
              getTitleRow(
                context,
                title: 'Popular',
                buttonTitle: 'See More',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoviesList(
                        movies: PopularMovies, title: 'Popular Movies'),
                  ),
                ),
              ),
              getSmallList(TopRated: false),
              getTitleRow(
                context,
                title: 'TopRated',
                buttonTitle: 'See More',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoviesList(
                        movies: TopRatedMovies, title: 'Top Rated Movies'),
                  ),
                ),
              ),
              getSmallList(TopRated: true),
            ],
          ),
        ),
      ),
    );
  }
}
