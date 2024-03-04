part of 'movie_cubit.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class TrendingMoviesLoaded extends MovieState {
  final MovieModel trendingMovies;

  TrendingMoviesLoaded(this.trendingMovies);
}

final class TopRatedMoviesLoaded extends MovieState {
  final MovieModel topRatedMovies;

  TopRatedMoviesLoaded(this.topRatedMovies);
}

final class UpcomingMoviesLoaded extends MovieState {
  final MovieModel upcomingMovies;

  UpcomingMoviesLoaded(this.upcomingMovies);
}
