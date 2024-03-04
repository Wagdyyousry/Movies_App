import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/data/repository/movies_repo.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MoviesRepo moviesRepo;
  //late MovieModel trendingMovies, topRatedMovies, upcomingMovies;
  MovieCubit(this.moviesRepo) : super(MovieInitial());

  Future<void> getTrendingMovies() async{
    await moviesRepo.getTrendingMovies().then(
          (movieModel) => {
            emit(TrendingMoviesLoaded(movieModel)),
            //trendingMovies = movieModel,
          },
        );
    //return trendingMovies;
  }

  Future<void> getTopRatedMovies() async{
    await moviesRepo.getTopRatedMovies().then(
          (movieModel) => {
            emit(TopRatedMoviesLoaded(movieModel)),
            //topRatedMovies = movieModel,
          },
        );
    //return topRatedMovies;
  }

  Future<void> getUpcomingMovies() async{
    await moviesRepo.getUpcomingMovies().then(
          (movieModel) => {
            emit(UpcomingMoviesLoaded(movieModel)),
            //upcomingMovies = movieModel,
          },
        );
    //return upcomingMovies;
  }

}
