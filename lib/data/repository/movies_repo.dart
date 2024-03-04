import 'package:movies_app/data/api_services/api.dart';
import 'package:movies_app/data/models/movie.dart';

class MoviesRepo {
  ApiServices? apiServices;

  MoviesRepo() {
    apiServices = ApiServices();
  }

  Future<MovieModel> getTrendingMovies() async {
    MovieModel trendingMovies = await apiServices!.getTrendingMovies();
    return trendingMovies;
  }

  Future<MovieModel> getTopRatedMovies() async {
    MovieModel topRatedMovies = await apiServices!.getTopRatedMovies();
    print("=======${topRatedMovies.results[0].title}");
    return topRatedMovies;
  }

  Future<MovieModel> getUpcomingMovies() async {
    MovieModel upcomingMovies = await apiServices!.getUpcomingMovies();
    return upcomingMovies;
  }
}
